#let itmo-bachelor-thesis(
  doc,
) = {
  set page(
    paper: "a4",
    margin: (
      top: 20mm,
      bottom: 20mm,
      left: 30mm,
      right: 15mm,
    ),
  )

  set text(
    font: "Times New Roman",
    size: 14pt,
    spacing: 150%,
  )

  set par(
    justify: true,
    spacing: 1.25cm,
  )

  set page(numbering: "1")
  counter(page).update(1)

  doc
}
