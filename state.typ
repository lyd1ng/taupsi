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
#let SECTIONS = state("sections", ()) // Used for table of content
#let SLIDE_COUNTER = counter("slide_counter")
