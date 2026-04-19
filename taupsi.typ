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


#let descriptor = list_descriptor((
  ("S", [A]),
  ("S", [B]),
  ("B", ([C], [D], [E])),
  ("M", ([F], [FG], [FGH])),
  ("S", [I])
))

#place_container(top, scope: "column", dx: 0% , dy: 0%, float: false, descriptor).at(1)(2)
#place_container(top, scope: "column", dx: 90%, dy: 0%, float: false, descriptor).at(1)(2)
