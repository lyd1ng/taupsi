// Draws an event in a time line
#let event(x, pos, label, reference, offset, color) = context {
  // Ugly fix
  if (offset == 0 or x == 2013) {
    line(length: 10pt, angle: 90deg)
    place(left, rotate(90deg, origin: left, text(str(x))))
  }
  place(right, dy: -15pt, rotate(45deg, origin: right, text(label + cite(reference), fill: color, size: 9pt)))
}

// Draws all elements until $counter
#let timeline(
  min,
  max,
  entries,
  counter: 0,
  legend: none,
  cite_start: 0,
  cite_end: 0,
) = context {
  rect(width: 100%, height: 100%, stroke: none)[
    #if (legend != none) {
      place(top + center, legend)
    }
    #place(horizon, line(length: 100%))
    #for (x, label, reference, offset, color) in entries.slice(0, counter) {
      let pos = (x + offset - min) / (max - min)
      place(horizon, dx: pos * 100%, event(x, pos, label, reference, offset, color))
    }
    #for counter in range(cite_start, cite_end) {
      place(left, dy: 75% +15pt * (counter - cite_start), text(size: 11pt, cite(form: "full", entries.at(counter).at(2))))
    }
  ]
}

// Generate a series of slides where each slide shows one more
// event within the timeline
#let c = 0
#let black= rgb(0, 0, 0)
#let re2= rgb(163, 0, 0)
#let blue = rgb(50, 20, 200)
#let green = rgb(20, 200, 80)
#let purple = rgb(163, 20, 200)
#let events = (
  (1985, "Optical Molasses", <cstm:ashk85>, 0, black),
  (1987, "MOT", <cstm:prit87>, 0, black),
  (1995, "BEC Verified", <cold:ande95>, 0, black),
  (1998, "2d MOT Source", <cstm:walr98>, 0, black),
  (2018, "Space-born BEC", <cstm:beck18>, 0, black),

  (2002, "Efimov Trimer Verified", <cstm:krae06>, 0, green),
  (2010, "Confinement Induces Resonances", <cstm:naeg10>, 0, green),

  (2000, "Rydberg Qbits", <cstm:zoll00>, 0, blue),
  (2012, "Spatial Wave Functions as Qbits", <cstm:schn12>, 0, blue),

  (1981, "QSim. Proposed", <cstm:feyn82>, 0, red),
  (2002, "QSim. Mott Insulator", <cstm:bloch02>, 1, red),
  (2012, "QSim. Higgs", <cstm:endr12>, 1, red),
  (2017, "QSim. Atto", <cstm:sala17>, 0, red),
  (2018, "QSim. Nuc. Phys.", <cstm:rico18>, 1, red),
  (2010, "QSim. Dirac Eq.", <cstm:roos10>, 0.5, red),
  (2025, "QSim. Rel. Phys.", <cstm:schu25>, 0, red),

  (2012, "Inelastic CIR", <cstm:sala12>, 2, purple),
  (2013, "Harmonic Molecule Formation", <cstm:sala13>, 2, purple),
  (2025, "Quantum Chemistry Approach", <cstm:rehm25>, 1, purple))

#let legend = [
  #text(size: 12pt, fill: black, "black: General,")
  #text(size: 12pt, fill: red, "red: Quantum Simulator,")
  #text(size: 12pt, fill: blue, "blue: Quantum Computer,")
  #text(size: 12pt, fill: green, "green: Few Body Physics,")
  #text(size: 12pt, fill: purple, "purple: Numerics")
]

#let timeline_descriptor(start, end, events, legend, steps, citation_steps) = {
  let inner(step) = {
    timeline(start, end, events, counter: steps.at(step), legend: legend, cite_start: citation_steps.at(step).at(0), cite_end: citation_steps.at(step).at(1))
  }
  return (steps.len(), inner)
}
