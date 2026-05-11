#import "taupsi.typ": *

#let authors = (
  ("Lyding Brumm", "HU"),
)

#setup("Title of the Presentation", "Title of presi", authors, default_colours)[
  #generate_table_of_content()

  #section_page("Concepts")
  #generate_slide(list_descriptor((
    ("S", [Content (the stuff which is visible) forms an _associative magma_]),
    ("M", (
      [*Description ::  N x (N -> Content)*],
      [*Description ::  N x (N -> Content)*, _(max_step, inner)_ \ Used to generate slides from ],
      [*Description ::  N x (N -> Content)*, _(max_step, inner)_ \ Used to generate slides from \ Forms an assoc. magma as well],
      [*Description ::  N x (N -> Content)*, _(max_step, inner)_ \ Used to generate slides from \ Forms an assoc. magma as well => Allows for description arithmetic(s)])),
    ("M", (
      [*Descriptors :: Parameters -> Description*],
      [*Descriptors :: Parameters -> Description* \ Used to construct different archetypes of descriptions])),
    ("M", (
      [*Container :: Parameters x Description -> Description*],
      [*Container :: Parameters x Description -> Description* \ Used to add extra 'stuff' to descriptions]))
    )))
  #generate_slide(subsection: "Algebraic Structure",
    list_descriptor((
      ("M", (
        [lift :: Content -> N -> Description], 
        [lift :: Content -> N -> Description \ Used to list content to the structure of descriptions])),
      ("S", [Might be monadic in nature?!]))))
  #generate_slide(subsection: "Arithmetic(s)",
    list_descriptor((
      ("M", (
        [concatenate_descriptors :: description -> description -> description],
        [
          concatenate_descriptors :: description -> description -> description\
          Yields a description which is a simple concatenation
        ])),
      ("M", (
        [componentwise_add_descriptors :: description -> description -> description],
        [
          componentwise_add_descriptors :: description -> description -> description\
          Yields a description which steps through both descriptions (same \$max_step is required)]))
    )))

  #section_page("Descriptors")
  #generate_slide(subsection: "Lists",
    componentwise_add_descriptors(
      list_descriptor((
        ("S", [Single Item 1]),
        ("S", [Single Item 2]),
        ("B", ([Block Item A], [Block Item B], [Block Item C])),
        ("M", ([Gradually], [Gradually Revealing], [Gradually Revealing Item])))),
      Place(bottom, Highlight(
        lift("list_descriptor((\n"+
          "(\"S\", [Single Item 1]),\n"+
          "(\"S\", [Single Item 2]),\n"+
          "(\"B\", ([Block Item A], [Block Item B], [Block Item C])),\n"+
          "(\"M\", ([Gradually], [Gradually Revealing], [Gradually Revealing Item]))))",
          max_step: 6)
      ))
    )
  )
  #generate_slide(subsection: "Images",
    componentwise_add_descriptors(
      image_scatter_descriptor((
        ("image1.jpg", 25%, 25%, 0%, 0%),
        ("image2.jpg", 25%, 25%, 50%, 25%),
        ("image3.jpg", 25%, 25%, 50%, 70%))),
      Place(bottom, clearance: 0pt, Highlight(
        lift("image_scatter_descriptor((\n"+
          "(\"image1.jpg\", 25%, 25%, 0%, 0%)\n"+
          "(\"image2.jpg\", 25%, 25%, 50%, 25%)\n"+
          "(\"image3.jpg\", 25%, 25%, 50%, 60%)))", max_step: 3)
      ))
    )
  )
  #generate_slide(subsection: "Math",
    componentwise_add_descriptors(
      equation_descriptor((
        [$ 1 $],
        [$ 1 + 2 $],
        [$ 1 + 2 + 3 $])),
      Place(center + bottom, clearance: 0pt, Highlight(
        lift("equation_descriptor(([$ 1 $],[$ 1 + 2 $],[$ 1 + 2 + 3 $]))", max_step: 3)
      ))
    )
  )
]
