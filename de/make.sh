PATH=$PATH:/opt/homebrew/bin
echo Starting lernOS Guide Generation ...

# Variables
filename="lernOS-fuer-Dich-Leitfaden"
chapters="./src/index.md ./src/1-0-Grundlagen.md ./src/1-1-Lebenslanges-Lernen-und-Wissensarbeit.md ./src/1-2-lernOS-Canvas.md ./src/1-3-lernOS-Flow.md ./src/1-4-lernOS-Workplace.md ./src/1-5-lernOS-Memex.md ./src/2-0-Lernpfade.md ./src/2-1-0-Lernpfad-PS.md ./src/2-1-1-Kata-1.md ./src/2-1-2-Kata-2.md ./src/2-1-3-Kata-3.md ./src/2-1-4-Kata-4.md ./src/2-1-5-Kata-5.md ./src/2-1-6-Kata-6.md ./src/2-1-7-Kata-7.md ./src/2-1-8-Kata-8.md ./src/2-1-9-Kata-9.md ./src/2-1-10-Kata-10.md ./src/2-1-11-Kata-11.md ./src/2-2-0-Lernpfad-ZF.md ./src/2-2-1-Kata-1.md ./src/2-2-2-Kata-2.md ./src/2-2-3-Kata-3.md ./src/2-2-4-Kata-4.md ./src/2-2-5-Kata-5.md ./src/2-2-6-Kata-6.md ./src/2-2-7-Kata-7.md ./src/2-2-8-Kata-8.md ./src/2-2-9-Kata-9.md ./src/2-2-10-Kata-10.md ./src/2-2-11-Kata-11.md ./src/2-3-0-Lernpfad-OV.md ./src/2-3-1-Kata-1.md ./src/2-3-2-Kata-2.md ./src/2-3-3-Kata-3.md ./src/2-3-4-Kata-4.md ./src/2-3-5-Kata-5.md ./src/2-3-6-Kata-6.md ./src/2-3-7-Kata-7.md ./src/2-3-8-Kata-8.md ./src/2-3-9-Kata-9.md ./src/2-3-10-Kata-10.md ./src/2-3-11-Kata-11.md ./src/3-Anhang.md"

# Delete Old Versions
echo Deleting old versions ...
rm -rf $filename.*
rm -rf ../docs/de/*
#rm -ff ../docs/de-slides/index.html

# Create Web Version (mkdocs)
echo Creating Web Version ...
mkdocs build

# Create Microsoft Word Version (docx)
echo Creating Word version ...
pandoc metadata.yaml --from markdown -s --resource-path="./src" -F mermaid-filter --number-sections -V lang=de-de -o $filename.docx $chapters

# Create HTML Version (html)
echo Creating HTML version ...
pandoc metadata.yaml --from markdown -s --resource-path="./src" -F mermaid-filter --number-sections -V lang=de-de -o $filename.html $chapters

# Create PDF Version (pdf)
echo Creating PDF version ...
pandoc metadata.yaml --from markdown -s --resource-path="./src" -F mermaid-filter --template lernos --number-sections --toc -V lang=de-de -o $filename.pdf $chapters

# Create eBook Versions (epub, mobi)
echo Creating eBook versions ...
magick -density 300 $filename.pdf[0] src/images/ebook-cover.jpg
mogrify -size 2500x2500 -resize 2500x2500 src/images/ebook-cover.jpg
mogrify -crop 1563x2500+102+0 src/images/ebook-cover.jpg
pandoc metadata.yaml --from markdown -s --resource-path="./src" -F mermaid-filter --epub-cover-image=src/images/ebook-cover.jpg --number-sections --toc -V lang=de-de -o $filename.epub $chapters
ebook-convert $filename.epub $filename.mobi

# Create Slides (revealjs)
# echo Creating Presentation ...
# pandoc metadata.yaml --from markdown -s --resource-path="./src" -t revealjs -V theme=night -s ./slides/index.md -o ../docs/de-slides/index.html
