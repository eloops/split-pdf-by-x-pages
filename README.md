# split-pdf-by-x-pages
Windows batch script to split a PDF file into a specified number of pages

There's a lot more that can be done with this, edit the batch file to set the options (ie how many pages to split by, where to save them, which tool to use, locations of tools)

Requires pdfinfo.exe from Poppler Tools, available here: http://blog.alivate.com.au/poppler-windows/ or in a pinch you could use the XPDF tools for Windows, available here: http://gnuwin32.sourceforge.net/packages/xpdf.htm

For the actual splitting, you can use either PDFtk available here: http://www.pdflabs.com/tools/pdftk-server/ or the community version of Coherent PDF command-line available here: http://community.coherentpdf.com/.

My preference is the Coherent PDF tools as they seem to be a little faster on really big PDF files.
