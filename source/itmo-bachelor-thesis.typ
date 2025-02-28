#let itmo-bachelor-thesis(
  title: str,
  author: str,
  doc,
) = {
  set document(
    title: title,
    author: author,
  )


  set page(paper: "a4")

  set text(
    font: "Times New Roman",
    size: 14pt,
    spacing: 150%,
  )

  set par(justify: true)


  set page(
    margin: (
      top: 10cm,
    ),
  )

  align(center)[
    #text(24pt, weight: "bold")[#title]
    #v(1cm)
    #author
  ]

  pagebreak()


  set page(
    margin: (
      left: 30mm,
      right: 15mm,
      top: 20mm,
      bottom: 20mm,
    ),
    numbering: "1",
  )

  counter(page).update(2)

  doc
}

#let structural-element(text) = {
  pagebreak()
  align(center)[#heading[#text]]
}
