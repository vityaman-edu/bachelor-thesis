set -ex

WORKDIR="$HOME/Downloads"

rm -f "$WORKDIR/main.pdf"
rm -f "$WORKDIR/main4.pdf"
rm -f "$WORKDIR/output.pdf"

typst compile source/main.typ

gs \
  -sDEVICE=pdfwrite \
  -dNOPAUSE \
  -dBATCH \
  -dSAFER \
  -sOutputFile="$WORKDIR/main.pdf" \
  source/main.pdf

gs \
  -sDEVICE=pdfwrite \
  -dNOPAUSE \
  -dBATCH \
  -dFirstPage=6 \
  -dLastPage=9999 \
  -sOutputFile="$WORKDIR/main4.pdf" \
  "$WORKDIR/main.pdf"

pdfunite \
  "$WORKDIR/title.pdf" \
  "$WORKDIR/task.pdf" \
  "$WORKDIR/annotation.pdf" \
  "$WORKDIR/main4.pdf" \
  "$WORKDIR/output.pdf"

