// =======================================================================
//
// Git repository: 
//      https://github.com/neruthes/typst-synthform
//
//
// Copyright (c) 2026 Neruthes.
// Published with the MIT license.
//
// =======================================================================





// =======================================================================
// BEGIN LIBRARY CODE
// =======================================================================
#let form_box_registry = state("form_box_registry__5e21ded1439f404187e5c8a723e07a53", ())

#let text-field(width: 10em, height: 1.5em, lowerbox) = context {
  let pos = locate(here()).position()
  let mybox = box(width: width, height: height, lowerbox)
  [#mybox]
  let entry = (pos: pos, size: measure(mybox))
  form_box_registry.update(my_arr => {
    my_arr.push(entry)
    my_arr
  })
}

#let dump-final-latex-get-string(bg-path: "form.pdf") = {
  let raw_arr = form_box_registry.get()

  let latex_doc_content_session = ""
  let current_page_cache = 1
  let __insertbgpic(pagenum) = {
    "\\AddToShipoutPictureBG*{%
  \\put(0mm,0mm){%
    \\includegraphics[%
      page=@PAGENUM,height=\\paperheight%
    ]{@BGPATH}}}\n"
      .replace(
        "@BGPATH",
        bg-path,
      )
      .replace("@PAGENUM", repr(pagenum))
  }

  latex_doc_content_session += __insertbgpic(1)
  // Iterate through entries...
  for row in range(0, raw_arr.len()) {
    let entry = raw_arr.at(row)
    let delta_page_num = entry.pos.page - current_page_cache
    if delta_page_num > 0 {
      for itr in range(0, delta_page_num) {
        current_page_cache += 1
        latex_doc_content_session += (
          "\\clearpage~%\n%%%%%%%%%%%%%%%%%%%%%%% END OF PAGE" + repr(current_page_cache - 1) + "\n"
        )
        latex_doc_content_session += __insertbgpic(current_page_cache)
      }
    }
    latex_doc_content_session += "\\absTextField{@X}{@Y}{@WIDTH}{@HEIGHT}{input-@ITEM}%% page=@PAGE\n"
      .replace("@ITEM", repr(row))
      .replace("@X", repr(entry.pos.x))
      .replace("@Y", repr(entry.pos.y))
      .replace("@PAGE", repr(entry.pos.page))
      .replace("@WIDTH", repr(entry.size.width))
      .replace("@HEIGHT", repr(entry.size.height))
  }


  let __latex_header = "\\documentclass[a4paper,10pt]{article}
\\usepackage[margin=10mm]{geometry}
\\usepackage{calc,graphicx,eso-pic,hyperref}
\\pagestyle{empty}
\\newcommand{\\absTextField}[5]{%
    % argv: x, y, width, height, id
    \\AddToShipoutPictureFG*{\\put(#1+1pt,\\paperheight-#2-0.5pt){%
        \\TextField[width=#3,height=#4,name=#5]{}%
    }}%
}
\\begin{document}
\\Form~%
"
  let __latex_footer = "\end{document}"
  return __latex_header + latex_doc_content_session + __latex_footer
}
#let add-form-latex-attachment(filename, bg-path: "form.pdf") = {
  pdf.attach(filename, bytes(dump-final-latex-get-string(bg-path: bg-path)))
}




