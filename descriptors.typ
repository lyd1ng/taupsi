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
* In this module various descriptors are (going to be) implemented
* as well as some operators on descriptors like concatenation and componentwise
* addition.
*/

// Generate a list of items.
// The items parameter is not simply a list of contents but
// also specify certain behavioural characteristics
// The first entry specifies if the data is either to be interpreted
// as single entry, multiple entries or an entry which is built incrementally
// i.e. revealed incrementally over multiple steps
#let list_descriptor(items) = {
  let max_step = 0
  for item in items {
    let modifier = item.at(0)
    let data = item.at(1)
    if (modifier == "S" or modifier == "B") {
      max_step += 1
    }
    if (modifier == "M") {
      max_step += data.len()
    }
  }
  let inner(step) = {
    step += 1
    let content = ()
    if (step >= max_step + 1) {
      return none
    }
    let index = 0
    let outer_step = 0
    while (index < step) {
      let modifier = items.at(outer_step).at(0)
      let data = items.at(outer_step).at(1)
      if (modifier == "S") {
        content.push(data)
        outer_step += 1
        index += 1
      }
      if (modifier == "B") {
        content += data
        outer_step += 1
        index += 1
      }
      if (modifier == "M") {
        if (index + data.len() >= step) {
          content.push(data.at(step - index - 1))
          break;
        }
        else {
          content.push(data.at(data.len() - 1))
          index += data.len()
          outer_step += 1
        }
      }
    }
    return list(..content)
  }
  return (max_step, inner)
}

// The image_scatter descriptor describes a set of images placed arbitrarily
// on the slide. The images are described as a list of tuples of the
// form (path, width, height, x, y)
#let image_scatter_descriptor(images) = {
  let max_step = images.len()
  let inner(step) = {
    step += 1
    let content = []
    for i in range(step){
      if (images.at(i) == none) { continue }
      let path = images.at(i).at(0)
      let width = images.at(i).at(1)
      let height = images.at(i).at(2)
      let x = images.at(i).at(3)
      let y = images.at(i).at(4)
      content += place(dx: x, dy: y, image(path, width: width, height: height),)
    }
    return content
  }
  return (max_step, inner)
}

// The equation descriptor describes an equation which can be shown gradually
// The equation is described as a simple list of mathematical content
#let equation_descriptor(equation) = {
  let inner(step) = { return equation.at(step) }
  return (equation.len(), inner)
}

// The concatenate_descriptors function is the canonical way to add
// descriptors.
#let concatenate_descriptors(descriptor1, descriptor2) = {
  let max_step1 = descriptor1.at(0)
  let max_step2 = descriptor2.at(0)
  let inner(step) = {
    if (step < max_step1) {
      return descriptor1.at(1)(step)
    }
    return descriptor1.at(1)(max_step1 - 1) + descriptor2.at(1)(step - max_step1)
  }
  return (max_step1 + max_step2, inner)
}

// descriptors of the same length can be added componentwise to
// combine different descriptors and compose more complex descriptors
#let componentwise_add_descriptors(descriptor1, descriptor2) = {
  let max_step1 = descriptor1.at(0)
  let max_step2 = descriptor2.at(0)
  assert(max_step1 == max_step2)
  let inner(step) = {
    return descriptor1.at(1)(step) + descriptor2.at(1)(step)
  }
  return (max_step1, inner)
}

// Monadic return: Puts content into the context of being a description
#let mreturn(content, max_step: 1) = {
  let inner(step) = {
    return content
  }
  return (max_step, inner)
}

// Monadic bind: Maps fn overeach element of the description
#let mbind(fn, descriptor) = {
  let inner(step) = {
    fn(descriptor.at(1)(step))
  }
  return (descriptor.at(0), inner)
}

// =============================================================================
// TEST CODE
// =============================================================================

// #let descriptor1 = list_descriptor((
//   ("S", [Cute Cat I]),
//   ("S", [Invisible Cat]),
//   ("S", [Cute Cate II]),
//   ("S", [Cute Cate III])))
// 
// #let descriptor2 = image_scatter_descriptor((
//   ("image1.jpg", 70%, 50%, 0pt, 0pt),
//   none,
//   ("image2.jpg", 60%, 50%, 0pt, 0pt),
//   ("image3.jpg", 50%, 50%, 0pt, 0pt)))

// #let descriptor = list_descriptor((
//   ("S", [A]),
//   ("S", [B]),
//   ("B", ([C], [D], [E])),
//   ("M", ([F], [FG], [FGH])),
//   ("S", [I])
// )
// #let larger_desciption = concatenate_descriptors(descriptor, descriptor)
// #let even_larger_desciption = concatenate_descriptors(larger_desciption, descriptor)
// #even_larger_desciption.at(1)(20)
//
//
// #let added_descriptor = componentwise_add_descriptors(descriptor, descriptor)
// #added_descriptor.at(1)(1)

// #componentwise_add_descriptors(descriptor1, descriptor2).at(1)(3)
//

#let equation1 = (
  [$1$],
  [$1 + 2$],
  [$1 + 2 + 3$],
  [$1 + 2 + 3 + 4$]
)

#let equation2 = (
  [$1$],
  [$+2$],
  [$+3$],
  [$+4$]
)
