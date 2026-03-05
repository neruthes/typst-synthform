// #import "@local/synthform:0.1.0" as synthform
#import "../src/synthform.typ" as synthform






// =======================================================================
// BEGIN DOCUMENT CODE
// =======================================================================
#let std_lowerbox = box(
  fill: none,
  stroke: none,
  width: 100%,
  height: 100%,
  inset: -0.5pt,
  box(width: 100%, height: 100%, fill: color.hsl(210deg, 40%, 91%)),
)


PAGE 1

What is your name? #synthform.text-field(width: 14em, std_lowerbox)

And age? #synthform.text-field(width: 7em, std_lowerbox)

#pagebreak()

SKIP PAGE 2

#pagebreak()

PAGE 3

What is your name? #synthform.text-field(width: 14em, std_lowerbox)

And age? #synthform.text-field(width: 7em, std_lowerbox)





// Render LaTeX cource code in document stream
#context raw(synthform.dump-final-latex-get-string(bg-path: "_dist/examples/form01-bg.pdf"))

// Include LaTeX source code as an attachment
#context synthform.add-form-latex-attachment("form01-real.tex", bg-path: "_dist/examples/form01-bg.pdf")



/*
mkdir -p .tmp &&
ntypstpro examples/form01-bg.typ &&
cpdf -dump-attachments _dist/examples/form01-bg.pdf -o .tmp &&
mv .tmp/srcform01-real.tex examples/form01-real.tex &&
ntex examples/form01-real.tex
*/

