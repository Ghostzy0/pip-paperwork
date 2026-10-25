# Read and mark up a PDF on your Mac

Paperwork keeps the opened input as the protected original. Begin with **Open sample** to try the workflow using a labelled synthetic document.

1. Open a PDF or the sample. Use thumbnails, Go to page, zoom and Find to navigate.
2. Select text, then choose Highlight, Underline or Strike. Use Note for a sticky note or Freehand to draw. Undo and Redo apply to document changes.
3. Select a supported form widget and use the controlled field editor. Inline viewer fields are read-only so changes cannot bypass the document history.
4. Rotate, move or delete pages as needed. Insert or merge copies pages from another supported PDF. The original files stay unchanged.
5. Choose **Save a copy** and enter a new filename. Existing files are refused. Reopen the output and check annotation, form value and page order with another reader before relying on an important document.

**Extract pages** accepts a range such as `1-3, 5` and preserves the entered order. **Split** writes page files in a new folder. **Export text** contains only available text; a scan may have none. **Export page image** writes a PNG of the current page.

**Searchable scan copy** recognises English using on-device Vision. It creates a flattened output, so keep the editable original. Stop requests cancellation of recognition. In the recorded stopped scenarios, it kept the working copy and created no output. **Flatten a copy** paints annotations/forms into page content, while **Optimise a copy** may reduce image detail and may not make the file smaller.

In Plus, Searchable scan first asks for one main language from the current Mac’s supported list. Canceling that chooser starts no OCR. Core continues its English request. Plus also offers Hide inspector/Show inspector in the toolbar and View menu; restore it to edit form fields or annotations. Selected chooser, inspector and French-copy scenarios passed native checks; see TESTING for exact scope and open limits.

Recovery is off by default. Enable it in File only if you want a local document-content snapshot. Restore opens a detached working copy; save it separately. Discard removes the stored recovery file, while later edits can create another if recovery remains on.

Current limits and verification gaps are in [TESTING](../TESTING.md) and [PARITY](../PARITY.md). The [FAQ](FAQ.md) explains why restricted/signed/encrypted inputs are protected.
