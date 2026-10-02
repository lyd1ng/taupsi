/*
* Author: Lyding
*
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
*
* In this module containers are implemented.
* Containers are a way to add additional context to descriptors.
* They can be understood as a way to organize the slide into different sections.
* Each section can be described by their own descriptor. This e.g. makes
* it possible have multiple lists at different places on the slide or
* have a list acompanied by a diashow of figures etc...
*/

#import "colours.typ": *
#import "state.typ": *

#let Place(
  alignment,
  descriptor,
  float: false,
  clearance: 0pt,
  dx: 0% + 0pt,
  dy: 0% + 0pt) = {
    let inner(step) = {
      return place(
        alignment,
        float: float,
        clearance: clearance,
        dx: dx,
        dy: dy,
        descriptor.at(1)(step))
    }
    return (descriptor.at(0), inner)
}

#let Entitle(title, size, spacing, descriptor) = {
  let inner(step) = {
    underline(text(size: size, title + ":"))
    v(spacing)
    descriptor.at(1)(step)
  }
  return (descriptor.at(0), inner)
}

#let Highlight(descriptor) = {
  let inner(step) = {
    box(
      inset: 0.25em,
      outset: 0.25em,
      stroke: (
        paint: COLOUR_PALETTE.get().at("foreground"),
        thickness: 0.125em),
      fill: COLOUR_PALETTE.get().at("enframed"))[
        #descriptor.at(1)(step)]
  }
  return (descriptor.at(0), inner)
}

#let Center(descriptor) = {
  let inner(step) = {
    align(center + horizon)[
      #descriptor.at(1)(step)
    ]
  }
  return (descriptor.at(0), inner)
}

#let Grid(
  columns: (),
  rows: (),
  gutter: (),
  column-gutter: (),
  row-gutter: (),
  inset: (:),
  align: auto,
  fill: none,
  stroke: (:),
  sequence: (),
  ..children
) = {
  // If the sequence is empty all descriptors are stepped through
  // in parallel. If descriptors are of unequal length the shorter
  // descriptors will simply remain static while the longer descriptors
  // are still stepped through
  // Otherwise the different descriptors are stepped through in the 
  // order specified by sequence.
  if (sequence.len() == 0) {
    let inner(step) = {
      // Evaluate the descriptors in the children list to content
      contents = map(d => d.at(1)(max(step, d.at(0))))
      // Build the grid using the evaluated descriptors
      return grid(columns, rows, gutter, column-gutter, row-gutter,
                  inset, align, fill, stroke, contents)
    }
    return (max(map(d => d.at(0), children)), inner)
  }
  else {
    assert(sequence.len() == children.len(), message: "Incomplete sequence")
    let max_step = children.reduce((x, y) => x.at(0) + y.at(0), 0)
    let inner(step) = {
      // TODO: Implement the sequential grid container
      // step has to be broken down to such that always the current
      // descriptor gets stepped throuh while all previous descriptors
      // remain at their last respective step and all following descriptors
      // are not stepped already
      return []
    }
    return (max_step, inner)
  }
}
