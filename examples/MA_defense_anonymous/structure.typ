#import "colours.typ": *

#let theorem(body) = block(
  width: 100%,
  inset: 0.5em,
  stroke: (left: 3pt + default_colours.at("foreground")),
  fill: default_colours.at("foreground").lighten(90%),
)[
  #text(weight: "bold")[Theorem] \
  #body
]

#let proposition(body) = block(
  width: 100%,
  inset: 0.5em,
  stroke: (left: 3pt + default_colours.at("foreground")),
  fill: default_colours.at("foreground").lighten(90%),
)[
  #text(weight: "bold")[Proposition] \
  #body
]

#let proof(body) = block(
  width: 100%,
  inset: 0.5em,
)[
  #text(style: "italic")[Proof.] #body #h(1fr) $square$
]

#let proofsk(body) = block(
  width: 100%,
  inset: 0.5em,
)[
  #text(style: "italic")[Proof sketch.] #body #h(1fr) $square$
]

#let firsthalfproof(body) = block(
  width: 100%,
  inset: 0.5em,
)[
  #text(style: "italic")[Proof.] #body
]

#let firsthalfproofsk(body) = block(
  width: 100%,
  inset: 0.5em,
)[
  #text(style: "italic")[Proof sketch.] #body
]

#let sechalfproof(body) = block(
  width: 100%,
  inset: 0.5em,
)[
  #body #h(1fr) $square$
]

#let definition(title: none, body) = block(
  width: 100%,
  inset: 0.5em,
  stroke: (left: 3pt + default_colours.at("foreground")),
  fill: rgb("#f0f0f0"),
)[
  #text(weight: "bold")[Definition]#if title != none [ (#title)] \
  #body
]

#let cite_note(body) = place(bottom + left,
  dy: -2em,
  text(size: 8pt)[#body]
)

#let note(title: [Note], body) = block(
  width: 100%,
  inset: 0.5em,
  stroke: (left: 3pt + default_colours.at("foreground")),
  fill: default_colours.at("foreground").lighten(90%),
)[
  #text(weight: "bold")[#title] \
  #body
]

#let thanks(body) = {
  show footnote: it => { }
  footnote[#body]
}