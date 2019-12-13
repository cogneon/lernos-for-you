@echo off
echo Starting lernOS Guide Generation ...

REM Required Software
REM See lernOS Core Repository

REM Variables
set filename="lernOS-for-You-Guide-de"

REM Delete Old Versions
echo Deleting old versions ...
del %filename%.docx %filename%.epub %filename%.mobi %filename%.html %filename%.pdf

REM Create Microsoft Word Version (docx)
echo Creating Word version ...
pandoc metadata.yaml -s -o %filename%.docx %filename%.md

REM Create HTML Version
echo Creating Web version ...
pandoc metadata.yaml -s --toc -o %filename%.html %filename%.md

REM Create PDF Version
echo Creating PDF version ...
pandoc metadata.yaml %filename%.md -o %filename%.pdf --from markdown --template lernOS --number-sections -V lang=de-de

REM Create eBook Versions (epub, mobi)
echo Creating eBook versions ...
magick -density 300 %filename%.pdf[0] images/ebook-cover.jpg
magick mogrify -size 2500x2500 -resize 2500x2500 images/ebook-cover.jpg
magick mogrify -crop 1563x2500+102+0 images/ebook-cover.jpg
pandoc metadata.yaml -s --epub-cover-image=images/ebook-cover.jpg -o %filename%.epub %filename%.md
ebook-convert %filename%.epub %filename%.mobi

echo Done. Check for error messages or warnings above. 

pause
