Render LaTeX cource code in document stream

```typ
#context raw(synthform.dump-final-latex-get-string(bg-path: "_dist/form-bg.pdf"))
```

Include LaTeX source code as an attachment

```typ
#context synthform.add-form-latex-attachment("form-real.tex", bg-path: "_dist/form-bg.pdf")
```
