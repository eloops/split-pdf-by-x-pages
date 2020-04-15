@echo off
setlocal EnableDelayedExpansion
setlocal EnableExtensions

:: Get source directory script is running from and change to it
for /f "delims= tokens=*" %%i in ("%0") do set srcdir=%%~dpi
cd "%srcdir%

REM split by this number
set pagesplit=2

REM program locations
set cpdf=C:\ostools\cpdf.exe
REM set pdftk=C:\Program Files (x86)\PDFtk Server\bin\pdftk.exe
set pdfi=C:\ostools\pdfinfo.exe

REM Get these tools from here:
REM http://www.pdflabs.com/tools/pdftk-server/
REM   or you could use cpdf tools from here: http://community.coherentpdf.com/
REM   in testing it worked much quicker than pdftk
REM http://blog.alivate.com.au/poppler-windows/

REM grab the file specified on input & remove quotes just in case we double up on them
set input=%*
set input=%input:"=%
set /a pagediff=%pagesplit% - 1

REM get the number of pages in the specified PDF
set pages=
for /f "tokens=1,2" %%a in ('%pdfi% ^"%input%^" ^| find ^"Pages^"') do (
  set pages=%%b
  set pages=!pages: =!
)

REM loop through the PDF by pagenumber & split them up 
set count=1
for /l %%c in (1,%pagesplit%,%pages%) do (
  REM leading zero stuff ... helps to keep the files organised correctly. Add an extra line if you're going over 1000
  set zcount=!count!
  if !count! LSS 100 (set zcount=0!count!)
  if !count! LSS 10 (set zcount=00!count!)

  REM get our range for the current iteration
  set pagelim=
  set pagelim=%%c
  set /a pagelim+=%pagediff%
  REM if its the last split ensure we aren't trying to pull out a higher number than there are pages
  if !pagelim! GTR !pages! (set pagelim=!pages!)
  
  REM actually perform the split using cpdf
  echo Splitting pages %%c to !pagelim! from %input%
  "%cpdf%" "%input%" %%c-!pagelim! -o "%srcdir%splitpdf-!zcount!.pdf" 2>NUL
  
  REM if you're using pdftk change the line to below
  REM "%pdftk%" "%input%" cat %%c-!pagelim! output "%srcdir%splitpdf-!count!-!newtime!.pdf"

  set /a count+=1
)

:end
