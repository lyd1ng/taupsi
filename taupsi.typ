/*
* taupsi is a presentation template suited for academic presentations
*
* In taupsi slides are not more or less than a nice frame around a single
* content variable.
* The stepping behaviour, usually implemented with a show later design pattern,
* is implemented by constructing slides from slide descriptors.
* A slide descriptor is function mapping a range 0..N of natural numbers
* to content variables. Because contents form an associative magma
* slide descriptors form an associative magma as well.
* This allows it to describe slides by concatenating archetype of elements.
*/

#import "descriptors.typ": *
#import "containers.typ": *
#import "colours.typ": *

// These states are set inside the setup funcition and *SHOULD NOT* be
// set anywhere else except one knows exactly what they are doing.
// It might be more paradigmatic to pass those variables as optional
// parameters which could then be set by show rules but this would
// require more typing^^
#let TITLE = state("title", ()) // Of the form (title, short title)
#let AUTHORS = state("authors", ()) // Of the form [(name, affiliation),..]
#let COLOUR_PALETTE = state("color_palette", (:)) // as defined in colours.typ
#let SIZE0 = state("size0", ()) // Large font size
#let SIZE1 = state("size1", ()) // Small font size
#let SLIDE_COUNTER = counter("slide_counter")

// Shows the authors and their affiliations
// the authors parameter is a list of tuples of the form (name, affiliations)
#let authors_and_affiliations() = {
  set text(
    fill: COLOUR_PALETTE.get().at("background"),
    size: SIZE1.get())
  let content = text(AUTHORS.get().at(0).at(0) + " @ " + AUTHORS.get().at(0).at(1))
  for index in range(1, AUTHORS.get().len()) {
    let author = AUTHORS.get().at(index)
    let name = author.at(0)
    let affiliation = author.at(1)
    content += h(0.2em) + text(" | ") + h(0.25em) + text(name + " @ " + affiliation)
  }
  content
}

#let title_and_section(section, subsection) = {
  context {
    set text(
      fill: COLOUR_PALETTE.get().at("background"),
      size: SIZE0.get())
    if (TITLE.get().at(1) != "" and TITLE.get().at(1) != none) {
      text(TITLE.get().at(1))
    }else {
      text(TITLE.get().at(0))
    }
    place(horizon + right, text(section + ", " + subsection, fill: COLOUR_PALETTE.get().at("background")))
  }
}

#let slide_counter() = {
  context {
    set text(
      fill: COLOUR_PALETTE.get().at("background"),
      size: SIZE1.get())
    text(SLIDE_COUNTER.display()) + "/" + [#SLIDE_COUNTER.final().at(0)]
  }
}

#let slide(section, subsection, colour_palette: default_colours, body) = {
  set page(
    background: context{
      SLIDE_COUNTER.step()
      place(top + left)[
        #block(
          width: 100%,
          height: auto,
          fill: COLOUR_PALETTE.get().at("foreground"),
          inset: (x: 0.25em, y: 20%))[#title_and_section(section, subsection)]
      ]
      place(bottom + left)[
        #block(
          width: 100%,
          height: auto,
          fill: COLOUR_PALETTE.get().at("foreground"),
          inset: (x: 0.25em, y: 20%))[
            #authors_and_affiliations()
            #place(horizon + right)[#slide_counter()]
          ]
      ]
    }
  )
  body
}

#let setup(
  title,
  short_title,
  authors,
  colour_palette: default_colours,
  size0: 20pt,
  size1: 14pt,
  body) = {
  // Update States
  TITLE.update((title, short_title))
  AUTHORS.update(authors)
  COLOUR_PALETTE.update(colour_palette)
  SIZE0.update(size0)
  SIZE1.update(size1)
  context {
  // Set the page of the presentation correctly
  set page(paper: "presentation-16-9")
  // Set the default fontsize to the size0
  set text(size: SIZE0.get())
  body
  }
}

#let authors = (
  ("Lyding I", "HU"),
  ("Lyding II", "USU")
)

#setup("FOO", "F", authors)[
  #slide("FOO", "BAR")[
    #list([A], [B], [C], [D])
  ]
]
