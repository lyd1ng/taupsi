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
*
* This module contains some hopefully decent looking colour palettes
*/

#let default_colours = (
  foreground: rgb(160, 0, 0),
  background: rgb(255, 255, 255),
  enframed:   rgb(160, 0, 0).lighten(90%),
)
