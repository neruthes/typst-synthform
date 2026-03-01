#import "@local/synthform:0.1.0" as synthform





// =======================================================================
// BEGIN DOCUMENT CODE
// =======================================================================
#let std_lowerbox = box(
  fill: color.hsl(210deg, 20%, 96%),
  stroke: color.hsl(215deg, 30%, 35%) + 0.6pt,
  width: 100%,
  height: 100%,
  inset: (left: 6pt),
  align(left + horizon, text(size: 1em, "")),
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
ntypstpro examples/form01-bg.typ
ntex examples/form01-real.tex
*/
