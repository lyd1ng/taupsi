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

#let place_container(
  alignment,
  descriptor,
  scope: "parent",
  float: true,
  clearance: 1.5em,
  dx: 0% + 0pt,
  dy: 0% + 0pt) = {
    let inner(step) = {
      return place(
        alignment,
        scope: scope,
        float: float,
        clearance: clearance,
        dx: dx,
        dy: dy,
        descriptor.at(1)(step))
    }
    return (descriptor.at(0), inner)
}
