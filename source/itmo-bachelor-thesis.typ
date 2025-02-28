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
    lang: "ru",
  )

  set par(
    first-line-indent: (
      amount: 1em,
      all: true,
    ),
    justify: true,
    spacing: 1em,
  )

  set figure.caption(separator: [ --- ])

  show figure.where(kind: image): set figure(supplement: "Рисунок")

  show figure.where(kind: table): set figure(supplement: "Таблица")
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.caption.where(kind: table): it => [
    #align(left)[#it]
  ]

  set math.equation(
    block: true,
    numbering: "(1)",
  )

  set list(marker: [---])

  set enum(numbering: "1)")


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

  set heading(numbering: "1.1")

  doc
}

#let structural-element(name, outlined: true) = {
  pagebreak()
  align(center)[
    #heading(
      numbering: none,
      outlined: outlined,
    )[#upper(name)]
  ]
  v(1em)
}

#let term(name, definition) = {
  par(
    first-line-indent: (
      amount: 0em,
    ),
  )[#name --- #definition]
}

#let chapter(name) = {
  pagebreak()
  heading[#name]
}
