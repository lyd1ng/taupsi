#import "@preview/leonux:1.1.0": *
#import "@preview/cetz:0.4.2"
#import "@preview/suiji:0.5.1": *
#import "@preview/physica:0.9.8": *
#show footnote.entry: set text(size: 10pt)
#show figure.caption: set text(size: 10pt)
#show list: set list(tight: false)
#show list: set list(marker: "-")
#show cite: set cite(style: "ieee-short.csl")

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

// Typeset the Hamiltonian
#let hamiltonian(counter) = [
  #if (counter == 0) {
    $
    H = & sum_i^cal(N)_B sum_(n=1)^(N_i) h_i (r_(i,n)) + sum_i^cal(N)_F sum_(n=1)^(N_i) h_i (r_(i,n)) \
    $
  }
  #if (counter == 1) {
    $
    H = & sum_i^cal(N)_B sum_(n=1)^(N_i) h_i (r_(i,n)) + sum_i^cal(N)_F sum_(n=1)^(N_i) h_i (r_(i,n)) \
        & - 1/2 sum_i^cal(N)_B sum_(n != m)^(N_i) w^((i i))(r_(i,n), r_(i,m))
          - 1/2 sum_i^cal(N)_F sum_(n != m)^(N_i) w^((i i))(r_(i,n), r_(i,m))
    $
  }
  #if (counter == 2) {
    $
    H = & sum_i^cal(N)_B sum_(n=1)^(N_i) h_i (r_(i,n)) + sum_i^cal(N)_F sum_(n=1)^(N_i) h_i (r_(i,n)) \
        & - 1/2 sum_i^cal(N)_B sum_(n != m)^(N_i) w^((i i))(r_(i,n), r_(i,m))
          - 1/2 sum_i^cal(N)_F sum_(n != m)^(N_i) w^((i i))(r_(i,n), r_(i,m)) \
        & - 1/2 sum_(i,j)^cal(N)_B sum_(n,m)^(N_i,N_j) w^((i j))(r_(i,n), r_(j,m))
          - 1/2 sum_(i,j)^cal(N)_F sum_(n,m)^(N_i,N_j) w^((i j))(r_(i,n), r_(j,m))
    $
  }
  #if (counter == 3) {
    $
    H = & sum_i^cal(N)_B sum_(n=1)^(N_i) h_i (r_(i,n)) + sum_i^cal(N)_F sum_(n=1)^(N_i) h_i (r_(i,n)) \
        & - 1/2 sum_i^cal(N)_B sum_(n != m)^(N_i) w^((i i))(r_(i,n), r_(i,m))
          - 1/2 sum_i^cal(N)_F sum_(n != m)^(N_i) w^((i i))(r_(i,n), r_(i,m)) \
        & - 1/2 sum_(i,j)^cal(N)_B sum_(n,m)^(N_i,N_j) w^((i j))(r_(i,n), r_(j,m))
          - 1/2 sum_(i,j)^cal(N)_F sum_(n,m)^(N_i,N_j) w^((i j))(r_(i,n), r_(j,m)) \
        & - sum_i^cal(N)_B sum_j^cal(N)_F sum_(n,m)^(N_i,N_j) w^((i j))(r_(i,n), r_(j,m)
    )
    $
  }
  $cal(N)_B, cal(N)_F$: number of bosonic and fermionic species#h(0.5em)
  $N_i$: number of particles in $i$th species\ 
]

#let sumbos(i) = $sum_i^(cal(N)_B)$
#let ssumbos(i, j) = $sum_(i!=j)^(cal(N)_B)$
#let sumfer(i) = $sum_(i=cal(N)_B + 1)^(cal(N))$
#let ssumfer(i, j) = $sum_(i,j=cal(N)_B + 1\ i!=j)^(cal(N)_B)$
#let ds = math.bb
#let energy_functional(counter) = [
  #if (counter == 0) {
    $ E[Psi] =
    & sumbos(i) N_i bra(phi_i(r_(i,n))) h_i(r_(i,n)) ket(phi_i(r_(i,n)))
    + sumfer(i) sum_(n=1)^(N_i) braket(phi_(i,n), h_i(r_(i,n)), phi_(i,n))
$
}
  #if (counter == 1) {
    $ E[Psi] =
    & sumbos(i) N_i bra(phi_i(r_(i,n))) h_i(r_(i,n)) ket(phi_i(r_(i,n)))
    + sumfer(i) sum_(n=1)^(N_i) braket(phi_(i,n), h_i(r_(i,n)), phi_(i,n))\ 
    & + 1/2 sumbos(i) N_i (N_i - 1)
        braket(
          phi_i(r_(i,n)) phi_i(r_(i,m)),
          w^(i i)(r_(i,n), r_(i,m)),
          phi_i(r_(i,n)) phi_i(r_(i,m))
        )
$
}
  #if (counter == 2) {
    $ E[Psi] =
    & sumbos(i) N_i bra(phi_i(r_(i,n))) h_i(r_(i,n)) ket(phi_i(r_(i,n)))
    + sumfer(i) sum_(n=1)^(N_i) braket(phi_(i,n), h_i(r_(i,n)), phi_(i,n))\ 
    & + 1/2 sumbos(i) N_i (N_i - 1)
        braket(
          phi_i(r_(i,n)) phi_i(r_(i,m)),
          w^(i i)(r_(i,n), r_(i,m)),
          phi_i(r_(i,n)) phi_i(r_(i,m))
        ) \
    & + 1/2 sumfer(i) sum_(n != m)^(N_i) (
          braket(
            phi_(i,n) phi_(i,m),
            w^(i i)(r_(i,n), r_(i,m)),
            phi_(i,n) phi_(i,m)
          ) - text("ex.")
        )
$
}
  #if (counter == 3) {
    $ E[Psi] =
    & sumbos(i) N_i bra(phi_i(r_(i,n))) h_i(r_(i,n)) ket(phi_i(r_(i,n)))
    + sumfer(i) sum_(n=1)^(N_i) braket(phi_(i,n), h_i(r_(i,n)), phi_(i,n))\ 
    & + 1/2 sumbos(i) N_i (N_i - 1)
        braket(
          phi_i(r_(i,n)) phi_i(r_(i,m)),
          w^(i i)(r_(i,n), r_(i,m)),
          phi_i(r_(i,n)) phi_i(r_(i,m))
        ) \
    & + 1/2 sumfer(i) sum_(n != m)^(N_i) (
          braket(
            phi_(i,n) phi_(i,m),
            w^(i i)(r_(i,n), r_(i,m)),
            phi_(i,n) phi_(i,m)
          ) - text("ex.")
        ) \
    & + 1/2 ssumbos(N_i, N_j)
        braket(
          phi_i(r_(i,n)) phi_j(r_(j,m)),
          w^(i j)(r_(i,n), r_(j,m)),
          phi_i(r_(i,n)) phi_j(r_(j,m))
        )
$
}
  #if (counter == 4) {
    $ E[Psi] =
    & sumbos(i) N_i bra(phi_i(r_(i,n))) h_i(r_(i,n)) ket(phi_i(r_(i,n)))
    + sumfer(i) sum_(n=1)^(N_i) braket(phi_(i,n), h_i(r_(i,n)), phi_(i,n))\ 
    & + 1/2 sumbos(i) N_i (N_i - 1)
        braket(
          phi_i(r_(i,n)) phi_i(r_(i,m)),
          w^(i i)(r_(i,n), r_(i,m)),
          phi_i(r_(i,n)) phi_i(r_(i,m))
        ) \
    & + 1/2 sumfer(i) sum_(n != m)^(N_i) (
          braket(
            phi_(i,n) phi_(i,m),
            w^(i i)(r_(i,n), r_(i,m)),
            phi_(i,n) phi_(i,m)
          ) - text("ex.")
        ) \
    & + 1/2 ssumbos(N_i, N_j)
        braket(
          phi_i(r_(i,n)) phi_j(r_(j,m)),
          w^(i j)(r_(i,n), r_(j,m)),
          phi_i(r_(i,n)) phi_j(r_(j,m))
        ) \
    & + 1/2 ssumfer(N_i, N_j) sum_(n,m=1)^(N_i)
        braket(
          phi_(i,n)(r_(i,n)) phi_(j,m)(r_(j,m)),
          w^(i j)(r_(i,n), r_(j,m)),
          phi_(i,n)(r_(i,n)) phi_(j,m)
        )
$
}
#if (counter == 5) {
    $ E[Psi] =
    & sumbos(i) N_i bra(phi_i(r_(i,n))) h_i(r_(i,n)) ket(phi_i(r_(i,n)))
    + sumfer(i) sum_(n=1)^(N_i) braket(phi_(i,n), h_i(r_(i,n)), phi_(i,n))\ 
    & + 1/2 sumbos(i) N_i (N_i - 1)
        braket(
          phi_i(r_(i,n)) phi_i(r_(i,m)),
          w^(i i)(r_(i,n), r_(i,m)),
          phi_i(r_(i,n)) phi_i(r_(i,m))
        ) \
    & + 1/2 sumfer(i) sum_(n != m)^(N_i) (
          braket(
            phi_(i,n) phi_(i,m),
            w^(i i)(r_(i,n), r_(i,m)),
            phi_(i,n) phi_(i,m)
          ) - text("ex.")
        ) \
    & + 1/2 ssumbos(N_i, N_j)
        braket(
          phi_i(r_(i,n)) phi_j(r_(j,m)),
          w^(i j)(r_(i,n), r_(j,m)),
          phi_i(r_(i,n)) phi_j(r_(j,m))
        ) \
    & + 1/2 ssumfer(N_i, N_j) sum_(n,m=1)^(N_i)
        braket(
          phi_(i,n)(r_(i,n)) phi_(j,m)(r_(j,m)),
          w^(i j)(r_(i,n), r_(j,m)),
          phi_(i,n)(r_(i,n)) phi_(j,m)
        ) \
    & + sumbos(i) sumfer(j) sum_(m=1)^(N_j) N_i
        braket(
          phi_i(r_i) phi_(j,m)(r_(j,m)),
          w^(i j)(r_i, r_(j,m)),
          phi_i(r_i) phi_(j,m)(r_(j,m))
        )
$
}
]

#let bfock() = [
  $
    ds(F)^kappa_("bos")(c^1,..,c^cal(N)) = &ds(h)^kappa_(k m)
    + (N_kappa - 1) sum_(l,n) ds(w)^(kappa kappa)_(k l m n) c^kappa_l c^kappa_n\ 
    &+ sum^(cal(N)_B)_(i != kappa) N_i sum_(l,n) ds(w)^(i kappa)_(k l m n) c^i_l c^i_n\ 
    &+ sumfer(j) sum_(z=1)^(N_j) sum_(l,n)
        ds(w)^(j kappa)_(k l m n) c^(j,z)_l c^(j,z)_n
  $
]

#let ffock() = [
  $
    ds(F)^kappa_("fer")(c^1,..,c^cal(N)) = &ds(h)^kappa_(k m)
    + sum_(l,n) (
        ds(w)^(kappa kappa)_(k l m n)
        - ds(w)^(kappa kappa)_(k l n m)
      ) c^(kappa,z)_l c^(kappa,z)_n \
    & + sumfer(i=cal(N)_b+1\ i != kappa)
        sum_(z=1)^(N_i)
        sum_(l,n)
        ds(w)^(i kappa)_(k l m n)
        c^(i,z)_l c^(i,z)_n \
    & + sum_(i=1)^(cal(N)_b)
        N_i sum_(l,n)
        ds(w)^(i kappa)_(k l m n)
        c^i_l c^i_n
  $
]

#let comparing_lists(
  titleA,
  titleB,
  entriesA: (),
  entriesB: (),
  counter: 0,
  m: [-],
  row_len: 90%
) = [
  #assert(entriesA.len() == entriesB.len(), message: "Both lists must have the same number of elements")
  #grid(
    columns: (49%, 1pt, 49%),
    rows: (auto, row_len),
    stroke: (x, y) => if (x == 1) { 1pt },
    align: (top + left, auto, top + left),
    inset: (10pt, 0pt, 10pt),
    [#underline(titleA)],
    [], // The separator is its own column
    [#underline(titleB)],
    [#list(..entriesA.slice(0, counter), marker: m)],
    [], // The separator is its own column
    [#list(..entriesB.slice(0, counter), marker: m)]
  )
]

#show: setup.with(
	ratio: "16-9",
	primary: rgb(160, 0, 0),
	title: "Quantum-Chemistry Approach to Multi-Species Ultra-Cold Atoms in Optical Tweezer Arrays",
	subtitle: "",
	date: "March 20, 2026",
	author: "L. A. Brumm",
	institute: "Humboldt-Universit\u{00e4}t zu Berlin"
)

#titlepage()
#section(title: "History")

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
  #text(size: 12pt, fill: black, "black") #text(size: 12pt, ": General,")
  #text(size: 12pt, fill: red, "red") #text(size: 12pt, ": Quantum Simulator,")
  #text(size: 12pt, fill: blue, "blue") #text(size: 12pt, ": Quantum Computer,")
  #text(size: 12pt, fill: green, "green") #text(size: 12pt, ": Few Body Physics")
  #text(size: 12pt, fill: purple, "purple") #text(size: 12pt, ": Numerics")
]

#slide-ctr.step()
#slide(title: "History")[
  #align(center)[
    #timeline(1980, 2027, events, counter: 5, legend:legend, cite_start:0, cite_end: 5)
  ]
]
#slide(title: "History")[
  #align(center)[
    #timeline(1980, 2027, events, counter: 7, legend:legend, cite_start: 5, cite_end: 7)
  ]
]
#slide(title: "History")[
  #align(center)[
    #timeline(1980, 2027, events, counter: 9, legend:legend, cite_start: 7, cite_end: 9)
  ]
]
#slide(title: "History")[
  #align(center)[
    #timeline(1980, 2027, events, counter: 16, legend:legend, cite_start: 9, cite_end: 16)
  ]
]
#slide-ctr.step()
#section(title: "Quantum Simulator")

/*
#let entries = (
  [Classical Approach: Hilbert space "explosion"\ 
  #h(1em)\- $N^3$ for one particle\ 
  #h(1em)\- $(N^3)^2$ for two particles\ 
  #h(1em)\- $(N^3)^m$ for $m$ particles],
  [Proposed by R. Feynman "Simulating physics with computers" (1981)],
  [Feynman: "That is against the rules."
      ,#h(0.25em)Reality: Strong computational limitation],
  [Workaround: "Nature knows best"],
  [Modell the Hamiltonian using *more controllable* (quantum) particles])

#let index = 1
#for i in range(entries.len()) {
  slide(title: "Quantum Simulator: General")[
    #list(..entries.slice(0, index))
  ]
  index = index + 1
}
#slide-ctr.step()
*/


#let entries = (
  [Optical Lattices, #h(0.5em) Orthogonal (reflected) Laser Beams],
  [Optical Tweezer Arrays, #h(0.5em) Highly focused Laser Beam],
  [Single-site manipulation],
  [Feshbach Resonances $->$ Tunable (effective) interaction-strength])

#let index = 1
#for i in range(entries.len()) {
  slide(title: "Quantum Simulator: Controllable Ultra-cold Atoms")[
    #place(top, dy: 2.5em)[
      #list(..entries.slice(0, index))
    ]
  ]
  index = index + 1
}
#slide-ctr.step()

#slide(title: "Quantum Simulator: Hubbard-Modell (2002)")[
  #let cw = 1/3 * 100%
  #let ch = 1/3 * 100%
  #v(0.5em)
  #align(top + center)[
      #rect(inset: 10% + 10pt)[
      $H = -J sum_(<i,j>)a_i^dagger a_j + sum_i e_i n_i + 1/2U sum_i n_i (n_i - 1)$
    ]
  ]
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
  #show: later
  #place(top + left, dx: 0%, dy: 60%,
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
  #place(top + left, dx: 40%, dy: 60%,
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
  #show: later
  #place(top + left, dx: 77%, dy: 60%,
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
  //numbering: (..nums) => "6",
  caption: "Step 6: Analyse interference pattern"))
]
#slide-ctr.step()
#slide(title: "History")[
  #align(center)[
    #timeline(1980, 2027, events, counter: 19, legend:legend, cite_start: 16, cite_end: 19)
  ]
]
#slide-ctr.step()

#section(title: "Quantum Chemistry Approach")
#let entriesA = (
  [Few Body],
  [Non-relativistic => Schr\u{00f6}dinger Equation],
  [Variable Geometry],
  [#text(fill: red, "Inter-atomic Potential")],
  [#text(fill: red, "Bosons and Fermions")],
)

#let entriesB = (
  [Few Body],
  [Non-relativistic => Schr\u{00f6}dinger Equation],
  [Variable Geometry],
  [#text(fill: red, "Coulomb Interaction")],
  [#text(fill: red, "Indistinguishable Fermions")],
)

#for i in range(entriesA.len() + 1) {
slide(title: "Quantum-Chemistry Approach: Justification")[
  #comparing_lists("Ultra-Cold Atoms", "Quantum-Chemistry", entriesA: entriesA, entriesB: entriesB, counter: i)
]
}
#slide-ctr.step()

#slide(title: "Quantum-Chemistry Approach: Cartesian Gaussian Type Orbitals (CGTOs)")[
  #v(0.5em)
  #align(top + center)[
      #rect(inset: 10% + 10pt)[
        $phi_"gto"^(sigma, R, alpha) = N product_(j=1)^3 (x_j - R_j)^(sigma_j) exp(-alpha(x_j - R_j)^2)$
    ]
  ]
  #show: later
  #grid(
    columns: (49%, 1pt, 49%),
    rows: (5%, auto),
    stroke: (x, y) => if (x == 1) { 1pt },
    align: (center, auto, center),
    [#place(top + left, dy: -25pt, underline("Ultra-Cold Atoms (red: traps)"))],
    [],
    [#place(top + left, dy: -25pt, underline("Quantum-Chemistry (red: cores)"))],
    [
      #cetz.canvas({
        import cetz.draw: *
        // Draw the cores
        for r in range(-20, 9) {
          let x = r / 5
          let x2 = (r + 1) / 5
          line(fill: red, stroke: red, (r * 5pt, -15pt * calc.exp(-(x * x))), ((r + 1) * 5pt, -15pt * calc.exp(-(x2 * x2))))
        }
        for r in range(-9, 19) {
          let ox = 90pt
          let oy = 0pt
          let x = r / 5
          let x2 = (r + 1) / 5
          line(fill: red, stroke: red, (r * 5pt + ox, -15pt * calc.exp(-(x * x)) + oy), ((r + 1) * 5pt + ox, -15pt * calc.exp(-(x2 * x2)) + oy))
        }
        for r in range(-20, 19) {
          let ox = -55pt
          let oy = 60pt
          let x = r / 5
          let x2 = (r + 1) / 5
          line(fill: red, stroke: red, (r * 5pt + ox, -15pt * calc.exp(-(x * x)) + oy), ((r + 1) * 5pt + ox, -15pt * calc.exp(-(x2 * x2)) + oy))
        }
        // Draw the orbitals
        circle(radius: (30pt, 30pt), (0, 0))
        circle(radius: (60pt, 60pt), (0, 0))
        circle(radius: (30pt, 30pt), (-2, 2))
        circle(radius: (60pt, 60pt), (-2, 2))
        circle(radius: (30pt, 30pt), (3.2, 0))
        circle(radius: (60pt, 60pt), (3.2, 0))
      })
    ],
    [],
    [
      #cetz.canvas({
        import cetz.draw: *
        // Draw the cores
        circle(fill: red, stroke: red, radius: (5pt, 5pt), (0, 0))
        circle(fill: red, stroke: red, radius: (5pt, 5pt), (-2, 2))
        circle(fill: red, stroke: red, radius: (5pt, 5pt), (3.2, 0))
        for r in range(-20, 9) {
          let x = r / 3
          let x2 = (r + 1) / 3
          if (x != 0 and x2 != 0) {
            line(fill: red, stroke: red, (r * 5pt, -15pt * 1/calc.abs(x)), ((r + 1) * 5pt, -15pt * 1/calc.abs(x2)))
          }
        }
        for r in range(-9, 19) {
          let ox = 90pt
          let oy = 0pt
          let x = r / 3
          let x2 = (r + 1) / 3
          if (x != 0 and x2 != 0) {
            line(fill: red, stroke: red, (r * 5pt + ox, -15pt * 1/calc.abs(x) + oy), ((r + 1) * 5pt + ox, -15pt * 1/calc.abs(x2) + oy))
          }
        }
        for r in range(-20, 19) {
          let ox = -55pt
          let oy = 60pt
          let x = r / 3
          let x2 = (r + 1) / 3
          // if (calc.abs(x) > 1/5 and calc.abs(x2) > 1/5) {
          if (x != 0 and x2 != 0) {
            line(fill: red, stroke: red, (r * 5pt + ox, -15pt * 1/calc.abs(x) + oy), ((r + 1) * 5pt + ox, -15pt * 1/calc.abs(x2) + oy))
          }
        }
        // Draw the orbitals
        circle(radius: (30pt, 30pt), (0, 0))
        circle(radius: (60pt, 60pt), (0, 0))
        circle(radius: (30pt, 30pt), (-2, 2))
        circle(radius: (60pt, 60pt), (-2, 2))
        circle(radius: (30pt, 30pt), (3.2, 0))
        circle(radius: (60pt, 60pt), (3.2, 0))
      })
    ],
  )
  #show: later
  #align(center)[
  Traps $<->$ Cores\ 
  Atoms $<->$ Electrons]
  #show: later
  #place(left, dy: -25pt)[
    CGTOs are #text(fill: red, "") phys. motivated
  ]
  #place(right, dy: -25pt)[
    CGTOs are #text(fill: red, "not") phys. motivated
  ]
]
#slide-ctr.step()

#section(title: "Multi-Species Self-Consistent-Field Theory (MSSCF)")
#let entries = (
  [Use product wave ansatz],
  [Construct energy funcional $E[Psi] = braket(Psi, H, Psi)$],
  [Minimize energy functional w.r.t single-particle wave function],
  [Coupled Fock equation for every species],
  [(Extended) Pople-Nesbet equation]
)
#let index = 1
#for i in range(entries.len()) {
  slide(title: "MSSCF Concept")[
    // #list(..entries.slice(0, index))
    #place(top, dy: 2.5em)[
      #list(..entries.slice(0, index))
    ]
  ]
  index = index + 1
}
#for i in range(4) {
  slide(title: "MSSCF: Hamiltonian")[
    #hamiltonian(i)
  ]
}
#slide-ctr.step()

#let entries = (
  [Fermions: Well known Hartree-Fock ansatz\ \ 
  $ket(cal(F)^(i)) = sum_(sigma in cal(S)_N) (-1)^(\# sigma) phi_(sigma(1))(r_1)..phi_(sigma(N))(r_N)$\ \ 
  ],
  [Bosons: All Bosons are in ground-state\ \ 
  $ket(cal(B)^(i)) = phi_1(r_1) phi_1(r_2)...phi_1(r_N)$\ 
  ]
)
#let index = 1
#for i in range(entries.len()) {
  slide(title: "MSSCF Wave Function Ansatz")[
    // #list(..entries.slice(0, index))
    #place(top, dy: 2.5em)[
      #list(..entries.slice(0, index))
    ]
  ]
  index = index + 1
}
#slide-ctr.step()

/*
#for i in range(6) {
  slide(title: "MSSCF: Energy Functional")[
    #scale(x: 80%, y: 80%)[
      #energy_functional(i)
    ]
  ]
}
#slide-ctr.step()
*/

#let entriesA = (
  [#scale(x: 80%, y: 80%)[#bfock()]],
  [$ds(F)^kappa_("bos")(c^1..,c^cal(N))c^kappa = epsilon c^kappa$]
)
#let entriesB = (
  [#scale(x: 80%, y: 80%)[#ffock()]],
  [$ds(F)^kappa_("fer")(c^1..,c^cal(N))c^kappa = epsilon c^kappa$]
)
#for i in range(entriesA.len()) {
slide(title: "MSSCF: SCF Equations")[
  #comparing_lists("Bosonic Species", "Fermionic Species", entriesA: entriesA, entriesB: entriesB, counter: i + 1, m: [])
]
}
#slide-ctr.step()

#section(title: "Multi-Species Full Configuration Interaction (MSFCI)")
#let entriesA = (
  [$
  ket(cal(B)^(i))=sum_(sigma in cal(S)_N) (+1)^(\# sigma) phi_(sigma(1))(r_1)..phi_(sigma(N))(r_N)
  $],
  [No Pauli exclusion principle],
  [/*$N_i$ out of $M$ */Draw #text(fill: red, "with") repetition $binom(M + N_i - 1, N_i)$],
  [Encoding e.g. $000$, $001$, $555$],
  [#text(fill: red, "Non-trivial") point group $cal(G)$]
)
#let entriesB = (
  [$
  ket(cal(F)^(i)) = sum_(sigma in cal(S)_N) (-1)^(\# sigma) phi_(sigma(1))(r_1)..phi_(sigma(N))(r_N)
  $],
  [Pauli exclusion principle],
  [/*$N_i$ out of $M$ */Draw #text(fill: red, "without") repetition $binom(M, N_i)$],
  [Encoding e.g. $123$, $124$, $345$],
  [#text(fill: red, "Trivial") point group]
)
#for i in range(entriesA.len()) {
slide(title: "MSFCI: Basis Generation")[
  #align(top)[
    #comparing_lists("Bosonic Species", "Fermionic Species", entriesA: entriesA, entriesB: entriesB, counter: i + 1, m: [], row_len: 70%)]
]
}
#slide(title: "MSFCI: Basis Generation")[
  #align(top)[
    #comparing_lists("Bosonic Species", "Fermionic Species", entriesA: entriesA, entriesB: entriesB, counter: entriesA.len(), m: [], row_len: 70%)]
  #show: later
  #place(left)[
    #line(length:100%)
    $ket(cal(B)^i)=sum_(sigma in cal(S)_n / cal(G))sum_(rho in cal(G))phi((sigma\.rho)(1))...phi((sigma\.rho)(N_i))$
    ,#h(0.5em)$frak(B) = product_i^cal(N) frak(B^i)$
    ,#h(0.5em)$"Fermions" subset "Bosons"$
  ]
]
#slide-ctr.step()

/*
#slide(title: "MSFCI: Basis Generation Continuation")[
  #figure(
    image("indexing_overview.pdf", width: 55%),
    caption: ["MSFCI Indexing Overview"]
  )
]
#slide-ctr.step()
*/

#let entriesA = (
  [$H_1$],
  [$H_2$],
  [$H_3$],
  [$H_4$],
  [$H_5$],
  [$H_6$],
  [$H_7$]
)
#let entriesB = (
  [Up to one diff. in a bosonic species],
  [Up to one diff. in a fermionic species],
  [Up to two diff. in bosonic species],
  [Up to two diff. in fermionic species],
  [Up to one diff in two bosonic species],
  [Up to one diff. in two fermionic species],
  [Up to one diff. in bosonic and fermionic species]
)
#let entriesC = (
  [DIAG, BFON],
  [DIAG, FFON],
  [DIAG, BFON, BSON],
  [DIAG, FFON, FSON],
  [DIAG, BFON, BBSON],
  [DIAG, FFON, FFSON],
  [DIAG, BFON, FFON, BFSON],
)
/*
#for i in range(entriesA.len()) {
  slide(title: "MSFCI: Sparsity, Equation Matrix")[
    #grid(
      columns: (10%, 50%, 33%),
      rows: (10%, 90%),
      [#underline("Terms")],
      [#underline("Sparsity Rules")],
      [#underline("Neighbours")],
      [
        #place(top, list(marker: [], ..entriesA.slice(0, i)))
      ],
      [
        #place(top, list(marker: [], ..entriesB.slice(0, i)))
      ],
      []
    )
  ]
}
#slide(title: "MSFCI: Sparsity, Equation Matrix")[
    #grid(
      columns: (10%, 50%, 33%),
      rows: (10%, 90%),
      [#underline("Terms")],
      [#underline("Sparsity Rules")],
      [#underline("Neighbours")],
      [
        #place(top, list(marker: [], ..entriesA))
      ],
      [
        #place(top, list(marker: [], ..entriesB))
      ],
      [
        #place(top, list(marker: [], ..entriesC))
      ]
    )
]
#slide-ctr.step()

#slide(title: "MSFCI: Sparsity, Equation Matrix Continuation")[
  #figure(
    image("msfci_equation_matrix.png", width: 80%),
    caption: ["MSFCI equation matrix"]
  )
]
#slide-ctr.step()
*/

#slide(title: "MSFCI: Algorithm")[
  #figure(
    image("msfci_algo_loop.pdf", width: 55%),
    caption: ["MSFCI algorithm"]
  )
]
#slide-ctr.step()



#section(title: "Multi-Species Complete Active Space Configuration Interaction (MSCASCI)")
#let entries = (
  [Separate space: Core, Active, Virtual],
  [Core Orbitals : Occupied],
  [Virtual Orbitals: Unoccupied],
  [Active Orbitals: *Complete CI*],
  [Reduced CI space $=>$ Drastically improved performance],
  [CASCI Basis $<->$ FCI Basis]
)
#let index = 1
#for i in range(entries.len()) {
  slide(title: "MSCASCI")[
    // #list(..entries.slice(0, index))
    #place(top, dy: 2.5em)[
      #list(..entries.slice(0, index))
    ]
  ]
  index = index + 1
}
#slide-ctr.step()

#slide(title: "MSCASCI")[
  #list(..entries.slice(0, entries.len()))
  #figure(
    image("mscasci_algo_loop.pdf", width: 55%),
    caption: ["MSCASCI as a modified MSFCI algorithm"]
  )
]
#slide-ctr.step()


#section(title: "Verification & Preliminary Results")

#slide(title: "Verification and Results: 2 Boson MSFCI")[
  #figure(
    image("2boson_harm_reproduced_fixed.png", height:95%),
    caption: [2 Boson data (from #cite(form: "full", <cstm:rehm25>) ) reproduced. *Solid: Literature data. Dashed: MSFCI data*]
  )
]
#slide-ctr.step()

#slide(title: "Verification and Results: MSSCF / MSFCI Comparison")[
  #grid(
    columns: (50%, 50%),
    rows: (auto),
    figure(
      image("msscf_msfci_comparison_2particles.png"),
      caption: [2 Body MSSCF / MSFCI Comparison]
    ),
    figure(
      image("msscf_msfci_comparison_4particles.png"),
      caption: [4 Body MSSCF / MSFCI Comparison]
    )
  )
]
#slide-ctr.step()

#slide(title: "Verification and Results: 3 Boson MSFCI")[
  #figure(
    image("3boson_2boson_comparison.png", height:95%),
    caption: [2 Boson / 3 Boson Comparison]
  )
]
#slide-ctr.step()

#slide(title: "MSFCI: Benchmark")[
  #figure(
    image("3boson_msfci_benchmark.png", height:95%),
    caption: [2 Boson / 3 Boson Comparison]
  )
]
#slide-ctr.step()

#let entriesA = (
  [CIR for more than $2$ particles],
  [Efimov-Trimers],
  [$n$-body resonances],
  [Fermionization of Bosons in (quasi) $1$d confinement],
)
#let entriesB = (
  [Angular interaction potentials],
  [DFT],
  [TDSE]
)
#let entriesC = (
  [Convergence accelerator],
  [Arbitrary ext. potential],
  [Fine control over active space],
  [gto_int]
)
#slide(title: "Outlook")[
  #grid(
    columns: (33%, 33%, 33%),
    rows: (10%, 90%),
    [#underline("Computations")],
    [],
    [],

    [#place(top, dy: 10pt, [#list(..entriesA)])],
    [],
    []
  )
]
#slide(title: "Outlook")[
  #grid(
    columns: (33%, 33%, 33%),
    rows: (10%, 90%),
    [#underline("Computations")],
    [],
    [#underline("Extensions to the Code")],

    [#place(top, dy: 10pt, [#list(..entriesA)])],
    [],
    [#place(top, dy: 10pt, [#list(..entriesC)])],
  )
]
#slide(title: "Outlook")[
  #grid(
    columns: (33%, 33%, 33%),
    rows: (10%, 90%),
    [#underline("Computations")],
    [#underline("Further Developments")],
    [#underline("Extensions to the Code")],

    [#place(top, dy: 10pt, [#list(..entriesA)])],
    [#place(top, dy: 10pt, [#list(..entriesB)])],
    [#place(top, dy: 10pt, [#list(..entriesC)])],
  )
]


// Create bibliography
#show bibliography: none
#bibliography("custom.bib", style: "ieee-short.csl")
