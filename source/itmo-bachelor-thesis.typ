#let itmo-bachelor-thesis(
  faculty: str,
  program: str,
  specialty: str,
  title: str,
  author: str,
  mentor: content,
  consultant: content,
  year: int,
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
    hyphenate: false,
  )

  set par(
    first-line-indent: (
      amount: 1.25cm,
      all: true,
    ),
    justify: true,
    spacing: 1em,
  )

  show heading.where(depth: 2): it => {
    block(inset: (left: 1.25cm), it)
  }

  show link: underline

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


  align(center)[
    Университет ИТМО \
    #faculty \
    \ \
    #program \
    #specialty \
    \ \ \ \ \ \
    #heading(outlined: false)[#title] \
    \ \ \ \
    *Автор*: #author \
    *Руководитель от университета ИТМО*: \ #mentor \
    *Руководитель от профильной организации*: \ #consultant \
    \
  ]

  align(center + bottom)[Санкт-Петербург, #year]

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
  align(center)[#heading[#name]]
}
