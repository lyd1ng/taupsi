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
#let SECTIONS = state("sections",()) // A list of sections from which the table
                                     // of content will be generated
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

#let generate_slide(section, subsection, descriptor) = {
  for i in range(descriptor.at(0)) {
    SLIDE_COUNTER.step()
    slide(section, subsection, descriptor.at(1)(i))
  }
}

#let titlepage() = {
  page(
    background: context{
      place(top + left)[
        #block(
          width: 100%,
          height: 1em,
          fill: COLOUR_PALETTE.get().at("foreground"),
          inset: (x: 0.25em, y: 20%))
      ]
      place(bottom + left)[
        #block(
          width: 100%,
          height: 1em,
          fill: COLOUR_PALETTE.get().at("foreground"),
          inset: (x: 0.25em, y: 20%))
      ]
    }
  )[
    #align(center + horizon)[
      #block(
        height: 33%,
        width:100%,
        fill: COLOUR_PALETTE.get().at("foreground"))[
          #text(fill: COLOUR_PALETTE.get().at("background"), TITLE.get().at(0))
          #v(5%)
          #authors_and_affiliations()
        ]
      ]
    ]
}

#let setup(
  title,
  short_title,
  authors,
  colour_palette,
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
  titlepage()
  body
  }
}

#let authors = (
  ("Lyding I", "HU"),
)

#let example_list = (
  ("S", [A]),
  ("S", [B]),
  ("S", [C]),
)

#setup("FOO", "", authors, default_colours)[
  // Set the default color of the highlight_container
  #let Highlight = Highlight.with(colour_palette: default_colours)
  #generate_slide("Section I", "Subsection I.I",
    Center(Highlight(list_descriptor(example_list))))
]
