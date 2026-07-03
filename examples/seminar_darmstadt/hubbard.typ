#import "@preview/cetz:0.4.2"
#import "@preview/suiji:0.5.1": *

#let hubbard_hamiltonian() =[
  #v(0.5em)
  #align(top + center)[
      #rect(inset: 10% + 10pt)[
      $H = -J sum_(<i,j>)a_i^dagger a_j + sum_i e_i n_i + 1/2U sum_i n_i (n_i - 1)$
    ]
  ]
]

#let hubbard_1to3() =[
  #place(top + left, dx: 0%, dy: 25%,
  figure(
  cetz.canvas({
    import cetz.draw: *
    circle(radius: (50pt, 20pt), (0, 0))
    let rng = gen-rng-f(42)
    let radii = ()
    let angles = ()
    (rng, radii) = uniform-f(rng, low: -1, high: 1, size: 20)
    (rng, angles) = uniform-f(rng, low: 0, high: 3.16, size: 20)
    for (radius, angle) in radii.zip(angles) {
      circle(stroke: red, fill: red, radius: (1pt, 1pt), (20pt * radius * calc.cos(angle), 20pt * radius * calc.sin(angle)))
    }
  }),
  numbering: none,
  //numbering: (..nums) => "1",
  caption: "Step 1: Load atoms into cigar shaped trap"))
  #place(top + left, dx: 40%, dy: 22%,
  figure(
  cetz.canvas({
    import cetz.draw: *
    circle(radius: (50pt, 20pt), (0, 0))
    let rng = gen-rng-f(42)
    let radii = ()
    let angles = ()
    (rng, radii) = uniform-f(rng, low: -1, high: 1, size: 20)
    (rng, angles) = uniform-f(rng, low: 0, high: 3.16, size: 20)
    for (radius, angle) in radii.zip(angles) {
      circle(stroke: red, fill: red, radius: (1pt, 1pt), (20pt * radius * calc.cos(angle), 30pt * radius * calc.sin(angle)))
    }
  }),
  numbering: none,
  //numbering: (..nums) => "2",
  caption: "Step 2: Evaporative cooling"))
  #place(top + left, dx: 80%, dy: 25%,
  figure(
  cetz.canvas({
    import cetz.draw: *
    circle(radius: (50pt, 20pt), (0, 0pt))
    for r in range(-10, 9) {
      line(fill: red, stroke: red, (r * 5pt + 2pt, 15pt * calc.exp(-(r/5 * r/5))), ((r + 1) * 5pt + 2pt, 15pt * calc.exp(-((r + 1)/5 * (r + 1)/5))))
    }
  }),
  numbering: none,
  //numbering: (..nums) => "3",
  caption: "Step 3: BEC Formation"))
]

#let hubbard_4to5() = [
  #place(top + left, dx: 0%, dy: 50%,
  figure(
  cetz.canvas({
    import cetz.draw: *
    circle(radius: (50pt, 50pt), (0, 0pt))
    for r in range(-10, 9) {
      line(fill: red, stroke: red, (r * 5pt + 2pt, 15pt * calc.exp(-(r/5 * r/5))), ((r + 1) * 5pt + 2pt, 15pt * calc.exp(-((r + 1)/5 * (r + 1)/5))))
    }
  }),
  numbering: none,
  //numbering: (..nums) => "4",
  caption: "Step 4: Relax trap to isotropic trap"))
  #place(top + left, dx: 40%, dy: 50%,
  figure(
  cetz.canvas({
    import cetz.draw: *
    grid(stroke: rgb(150, 150, 150), (-50pt, -50pt), (51pt, 51pt), step: 20pt)
    circle(radius: (50pt, 50pt), (0, 0pt))
    for r in range(-10, 9) {
      line(fill: red, stroke: red, (r * 5pt + 2pt, 15pt * calc.exp(-(r/5 * r/5))), ((r + 1) * 5pt + 2pt, 15pt * calc.exp(-((r + 1)/5 * (r + 1)/5))))
    }
  }),
  numbering: none,
  //numbering: (..nums) => "5",
  caption: "Step 5: Add optical lattice"))
]

#let hubbard_6() = [
  #place(top + left, dx: 77%, dy: 50%,
  figure(
  cetz.canvas({
    import cetz.draw: *
    let rng = gen-rng-f(42)
    let radii = ()
    circle(stroke: white, radius: (50pt, 50pt), (0, 0pt))
    line(stoke: black, (-20pt, 9pt), (-50pt, 9pt), mark: (end: ">"))
    line(stoke: black, (+23pt, 9pt), (+53pt, 9pt), mark: (end: ">"))
    for r in range(-10, 9) {
      line(fill: red, stroke: red, (r * 5pt + 2pt, 15pt * calc.exp(-(r/5 * r/5))), ((r + 1) * 5pt + 2pt, 15pt * calc.exp(-((r + 1)/5 * (r + 1)/5))))
    }
  }),
  numbering: none,
  caption: "Step 6: Analyse interference pattern"))
]

#let hubbard() = {
  let inner(step) = {
    if (step == 0) {
      return hubbard_hamiltonian() + hubbard_1to3()
    }
    if (step == 1) {
      return hubbard_hamiltonian() + hubbard_1to3() + hubbard_4to5()
    }
    if (step == 2) {
      return hubbard_hamiltonian() + hubbard_1to3() + hubbard_4to5() + hubbard_6()
    }
  }
  return (3, inner)
}
