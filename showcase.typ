#import "taupsi.typ": *

#let authors = (
  ("Lyding I", "HU"),
)

#let sections = ("Descriptors",)

#setup("Title of the Presentation", "Title of presi", authors, default_colours)[
  // Set the default color of the highlight_container
  #let Highlight = Highlight.with(colour_palette: default_colours)
  #generate_table_of_content(sections, 24pt)
  #section_page("Descriptors")
  #generate_slide("Descriptors", "Lists",
    componentwise_add_descriptors(
      list_descriptor((
        ("S", [Single Item 1]),
        ("S", [Single Item 2]),
        ("B", ([Block Item A], [Block Item B], [Block Item C])),
        ("M", ([Gradually], [Gradually Revealing], [Gradually Revealing Item])))),
      Place(bottom, Highlight(
        lift("
          list_descriptor((
          (\"S\", [Single Item 1]),
          (\"S\", [Single Item 2]),
          (\"B\", ([Block Item A], [Block Item B], [Block Item C])),
          (\"M\", ([Gradually], [Gradually Revealing], [Gradually Revealing Item]))))",
          max_step: 6)
      ))
    )
  )
  #generate_slide("Descriptors", "Images",
    componentwise_add_descriptors(
      image_scatter_descriptor((
        ("image1.jpg", 25%, 25%, 0%, 0%),
        ("image2.jpg", 25%, 25%, 50%, 25%),
        ("image3.jpg", 25%, 25%, 50%, 70%))),
      Place(bottom, clearance: 0pt, Highlight(
        lift("
          image_scatter_descriptor((
          (\"image1.jpg\", 25%, 25%, 0%, 0%),
          (\"image2.jpg\", 25%, 25%, 50%, 25%),
          (\"image3.jpg\", 25%, 25%, 50%, 60%)))", max_step: 3)
      ))
    )
  )

  #generate_slide("Descriptors", "Math",
    componentwise_add_descriptors(
      equation_descriptor((
        [$1 $],
        [$1 + 2$],
        [$1 + 2 + 3$])),
      Place(bottom, clearance: 0pt, Highlight(
        lift("equation_descriptor((
        [$ 1 $],
        [$ 1 + 2 $],
        [$ 1 + 2 + 3 $]))", max_step: 3)

      ))
    )
  )

  #generate_slide("Descriptors", "Math",
    componentwise_add_descriptors(
      equation_descriptor2((
        [$1$],
        [$+ 2$],
        [$+ 3$])),
      Place(bottom, clearance: 0pt, Highlight(
        lift("equation_descriptor2((
        [$ 1 $],
        [$ + 2 $],
        [$ + 3 $]))", max_step: 3)
      ))
    )
  )
]

