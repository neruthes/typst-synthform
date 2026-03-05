# typst-synthform

Use the `synthform` package to create fillable PDF using Typst + LaTeX with 2 steps.

[Demo PDF](https://pub-714f8d634e8f451d9f2fe91a4debfa23.r2.dev/typst-synthform/9cd71ab4820a5730f54d6233/form01-real.pdf)





## Workflow

### Installation
```sh
# Clone this repository and
./make.sh i
```

```typ
#import "@local/synthform:0.1.0" as synthform
```

### Make Text Field Boxes
```typ
#synthform.text-field(width: 14em, std-lower-box)
// NOTE: Define your own visual box as std-lower-box
```

### Dump LaTeX Code
```typ
// Include LaTeX code as an attachment
#context synthform.add-form-latex-attachment("form-real.tex", bg-path: "_dist/form-bg.pdf")
// -- OR --
// Preview LaTeX code in the document
#context raw(synthform.dump-final-latex-get-string(bg-path: "_dist/form-bg.pdf"))
```

### Build LaTeX to PDF
Now you can use your favorite LaTeX workflow to make the final fillable PDF.




## Notes
- When the Typst document has trailing pages that do not contain `text-field`, the LaTeX document cannot properly include them. This should be fixed in future. Meanwhile, use `pdfpages` add code like `\includepdf[pages=5-]{_dist/form-bg.pdf}`.




## Copyright

Copyright (c) 2026 Neruthes.

Published with the MIT license.
