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
#import "state.typ": *

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
    if (subsection != none and subsection != "") {
      place(horizon + right, text(section + ", " + subsection, fill: COLOUR_PALETTE.get().at("background")))
    }
    else {
      place(horizon + right, text(section, fill: COLOUR_PALETTE.get().at("background")))
    }
  }
}

#let slide_counter() = {
  set text(
    fill: COLOUR_PALETTE.get().at("background"),
    size: SIZE1.get())
  text(SLIDE_COUNTER.display()) + "/" + [#SLIDE_COUNTER.final().at(0)]
}

#let slide(section, subsection, colour_palette: default_colours, body) = {
  set page(
    background:
      place(top + left)[
        #block(
          width: 100%,
          height: auto,
          fill: COLOUR_PALETTE.get().at("foreground"),
          inset: (x: 0.25em, y: 20%))[#title_and_section(section, subsection)]
      ] + 
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
  )
  body
}

/*
#let generate_slide(descriptor, section: "", subsection: "") = context{
  SLIDE_COUNTER.step()
  for i in range(descriptor.at(0)) {
    if (section != "") {
      slide(section, subsection, descriptor.at(1)(i))
    }
    else {
      slide(SECTIONS.get().last(), subsection, descriptor.at(1)(i))
    }
  }
*/

#let generate_slide(descriptor, section: "", subsection: "", title: none) = context{
  SLIDE_COUNTER.step()
  let final_descriptor = if title != none {
    componentwise_add_descriptors(
      Place(top + center, mreturn(
        block(below: 0.4em, align(center)[#text(weight: "bold")[#title]])
        + rect(width: 80%, height: 1pt, fill: gradient.linear((luma(0%).transparentize(100%),0%),(luma(0%),20%),(luma(0%),80%),(luma(0%).transparentize(100%),100%))),
        max_step: descriptor.at(0))),
      mbind(element => v(2.5em) + element, descriptor)
    )
  } else {
    descriptor
  }
  for i in range(final_descriptor.at(0)) {
    slide(section, subsection, final_descriptor.at(1)(i))
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

#let section_page(section) = context{
  SLIDE_COUNTER.step()
  SECTIONS.update(arr => arr + (section,))
  page(
    background:
      place(top + left)[
        #block(
          width: 100%,
          height: auto,
          fill: COLOUR_PALETTE.get().at("foreground"),
          inset: (x: 0.25em, y: 20%))[#title_and_section(section, "")]
      ] + 
      place(bottom + left)[
        #block(
          width: 100%,
          height: auto,
          fill: COLOUR_PALETTE.get().at("foreground"),
          inset: (x: 0.25em, y: 20%))[
            #authors_and_affiliations()
            #place(horizon + right)[#slide_counter()]
          ]
      ] + 
      align(center + horizon,
      block(width: 61.8%, height: 33%,
      fill: COLOUR_PALETTE.get().at("foreground"),
      text(SIZE0.get(), fill: COLOUR_PALETTE.get().at("background"), section)))
  )[]
}

#let generate_table_of_content() = context{
  let entries = ()
  for section in SECTIONS.final() {
    entries.push(("S", section))
  }
  generate_slide(section: "Table of Content",
    Entitle("Table of Content", SIZE0.get(), 0.5em, list_descriptor(entries)))
}

#let setup(
  title,
  short_title,
  authors,
  colour_palette,
  size0: 24pt,
  size1: 18pt,
  body) = {
  // Update States
  TITLE.update((title, short_title))
  AUTHORS.update(authors)
  COLOUR_PALETTE.update(colour_palette)
  SIZE0.update(size0)
  SIZE1.update(size1)
  // Set the page of the presentation correctly
  set page(paper: "presentation-16-9")
  // Set the default fontsize to the size0
  set text(size: size1)
  context{ titlepage() }
  body
}
