#!/usr/bin/env python3
"""Independent pypdf/Poppler regression; test-only Python is not shipped runtime."""
import hashlib,json,os,subprocess,sys,tempfile
from pathlib import Path
from pypdf import PdfReader
from pypdf.generic import NameObject,DictionaryObject,StreamObject
engine=Path(__file__).resolve().parent
repo=engine.parents[2]
helper=Path(sys.argv[1]) if len(sys.argv)>1 else engine/'build/canonical-pdf'
samples=repo/'.local-evidence/paperwork/audits/r1/outputs-before-form-fix'
original=repo/'apps/paperwork/Tests/PaperworkCoreTests/Fixtures/controls.pdf'
outputs=repo/'.local-evidence/paperwork/audits/r1/engine-outputs'
outputs.mkdir(exist_ok=True)
# Each test run gets a fresh directory; preserve previous evidence.
import time
outputs=outputs/str(time.time_ns());outputs.mkdir()

def run(name,edits,template=None):
 source=samples/name;dest=outputs/name
 if dest.exists():raise RuntimeError('create-only test destination already exists: '+str(dest))
 req={'version':1,'edits':edits}
 if template:req['original']=str(template)
 with tempfile.NamedTemporaryFile(mode='w',suffix='.json') as f:
  os.chmod(f.name,0o600);json.dump(req,f);f.flush()
  subprocess.run([str(helper),str(source),str(dest),f.name],check=True,timeout=35)
 return dest

filled=run('controls-filled.pdf',{'consent':'Yes','delivery':'express'},original)
unchanged=run('controls-unmodified.pdf',{})
text=run('form-filled.pdf',{})
r=PdfReader(filled,strict=True);fields=r.get_fields()
assert fields['consent']['/V']==NameObject('/Yes') and isinstance(fields['consent']['/V'],NameObject)
assert fields['delivery']['/V']==NameObject('/express') and isinstance(fields['delivery']['/V'],NameObject)
assert fields['region']['/V']=='FR',fields['region']
radio=[]
for page in r.pages:
 for ref in page['/Annots']:
  w=ref.get_object();f=w.get('/Parent',w).get_object()
  if f.get('/FT')!='/Btn':continue
  normal=w['/AP']['/N'].get_object()
  assert isinstance(normal,DictionaryObject) and not isinstance(normal,StreamObject)
  assert '/Off' in normal and w['/AS'] in normal
  for state,stream in normal.items():
   assert isinstance(stream.get_object(),StreamObject)
   # Exact original bytes are preserved for normal appearances.
   of=PdfReader(original)
   matches=[a.get_object() for a in of.pages[0]['/Annots'] if a.get_object().get('/Parent',a.get_object()).get_object().get('/T')==f['/T'] and a.get_object()['/Rect']==w['/Rect']]
   assert len(matches)==1
   assert stream.get_object().get_data()==matches[0]['/AP']['/N'][state].get_data()
  if f['/T']=='delivery':
   assert '/V' not in w;radio.append(w['/AS'])
assert sorted(radio)==['/Off','/express']
for source,dest in [(samples/'controls-unmodified.pdf',unchanged),(samples/'form-filled.pdf',text)]:
 a,b=PdfReader(source),PdfReader(dest,strict=True)
 assert len(a.pages)==len(b.pages)
 assert {k:v.get('/V') for k,v in a.get_fields().items()}=={k:v.get('/V') for k,v in b.get_fields().items()}
 assert [p.extract_text() for p in a.pages]==[p.extract_text() for p in b.pages]
# Poppler must parse and render without malformed stream diagnostics.
for pdf in [filled,unchanged,text]:
 command=['pdftoppm','-f','1','-singlefile','-scale-to','800','-png',str(pdf),str(pdf.with_suffix(''))]
 result=subprocess.run(command,capture_output=True,text=True,timeout=35)
 diagnostics=result.stderr.replace('Fontconfig error: Cannot load default config file: File not found','').strip()
 assert result.returncode==0 and not diagnostics,result.stderr
# Native first-serialization extraction and explicit flatten regressions.
integrated=repo/'.local-evidence/paperwork/audits/r1/outputs-integrated'
if (integrated/'raw-extracted.pdf').exists():
 source=integrated/'raw-extracted.pdf';dest=outputs/'extracted-forms.pdf'
 request=outputs/'extracted-request.json';request.write_text(json.dumps({'version':1,'edits':{'consent':'Yes','delivery':'standard'},'original':str(original)}));os.chmod(request,0o600)
 subprocess.run([str(helper),str(source),str(dest),str(request)],check=True,timeout=35)
 extracted=PdfReader(dest,strict=True);fields=extracted.get_fields()
 assert set(fields)=={'consent','delivery','region','short','secret','fixed'}
 assert fields['consent']['/V']==NameObject('/Yes') and fields['delivery']['/V']==NameObject('/standard')
 assert fields['fixed']['/Ff']==1 and fields['region']['/V']=='GB'
 for ref in extracted.pages[0]['/Annots']:
  widget=ref.get_object();assert '/Parent' in widget and '/T' not in widget
  assert widget.indirect_reference in widget['/Parent']['/Kids']
if (integrated/'form-flattened.pdf').exists():
 source=integrated/'form-flattened.pdf';dest=outputs/'flattened.pdf';request=outputs/'flatten-request.json'
 request.write_text(json.dumps({'version':1,'edits':{},'flatten':True}));os.chmod(request,0o600)
 subprocess.run([str(helper),str(source),str(dest),str(request)],check=True,timeout=35)
 flattened=PdfReader(dest,strict=True)
 assert '/AcroForm' not in flattened.trailer['/Root']
 assert all(a.get_object().get('/Subtype')!='/Widget' for page in flattened.pages for a in page.get('/Annots',[]))
# Failure paths must not publish or replace output bytes.
with tempfile.TemporaryDirectory() as scratch:
 root=Path(scratch);request=root/'request.json'
 cases=[({'version':1,'edits':{'consent':'Yes'}},samples/'controls-filled.pdf'),
        ({'version':1,'edits':{'consent':'made-up'},'original':str(original)},samples/'controls-filled.pdf'),
        ({'version':1,'edits':{'delivery':'Off'},'original':str(original)},original)]
 for i,(req,source) in enumerate(cases):
  request.write_text(json.dumps(req));os.chmod(request,0o600);dest=root/f'reject-{i}.pdf'
  result=subprocess.run([str(helper),str(source),str(dest),str(request)],capture_output=True,timeout=35)
  assert result.returncode!=0 and not dest.exists(),result.stderr
 request.write_text(json.dumps({'version':1,'edits':{}}));dest=root/'existing.pdf';dest.write_bytes(b'preserved')
 result=subprocess.run([str(helper),str(original),str(dest),str(request)],capture_output=True,timeout=35)
 assert result.returncode!=0 and dest.read_bytes()==b'preserved'
 result=subprocess.run([str(helper),str(original),str(original),str(request)],capture_output=True,timeout=35)
 assert result.returncode!=0
# Preserve originals, outputs and the exact candidate identity.
print(json.dumps({'status':'PASS','checks':['canonical Name values','AS matches real state dictionaries','byte-identical original normal appearances','choice/text/page preservation','Poppler no stream warnings'],'helper_sha256':hashlib.sha256(helper.read_bytes()).hexdigest(),'outputs':str(outputs)},indent=2))
