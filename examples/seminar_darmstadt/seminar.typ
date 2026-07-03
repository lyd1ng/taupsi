#import "taupsi.typ": *
#import "timeline.typ": *
#import "hubbard.typ": *
#import "@preview/physica:0.9.8": *
#show list: set list(tight: false)
#show figure.caption: set text(size: 10pt)
#show cite: set cite(style: "ieee-short.csl")

#let authors = (
  ("Lyding Brumm", "Humboldt-Universitaet zu Berlin"),
)

#let sumbos(i) = $sum_i^(cal(N)_B)$
#let ssumbos(i, j) = $sum_(i!=j)^(cal(N)_B)$
#let sumfer(i) = $sum_(i=cal(N)_B + 1)^(cal(N))$
#let ssumfer(i, j) = $sum_(i,j=cal(N)_B + 1\ i!=j)^(cal(N)_B)$
#let ds = math.bb
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
    + sum_(z=1)^(N_kappa) sum_(l,n) (
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
  entriesA,
  entriesB,
  m: [-],
  row_len: 90%
) = {
  let inner(counter) = [
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
  return (entriesA.len() + 1, inner)
}

#setup(
  "Quantum-Chemistry Inspired Approach to Ultra-Cold Atoms in Tweezer Arrays\n(Multi-Species Generalisation of SCF, FCI, CASCI)",
  "Quantum-Chemistry for Ultra-Cold Atoms",
  authors,
  default_colours,
  size0: 22pt,
  size1: 18pt)[
  #section_page("About Me")
  #generate_slide(chain(
    list_descriptor((
    ("S", [B. Eng. in Telecommunication Engineering (2019)]),
    ("M", (
      [Preparing Studies in Mathematics and Physics at Humboldt-Universitaet zu Berlin],
      [
        Preparing Studies in Mathematics and Physics at Humboldt-Universitaet zu Berlin\
        #list(
          "Student Assistant for Analogue Electronics",
          "Docent for Digital Signal Processing",
          [$Sigma$-Spectrum of Hydrogen-Antihydrogen (Phys.Rev.A)])
      ],
    )),
    ("S", [M. Sci. in Physics (2026)]),
    ("S", [Received the Lise-Meitner Price]))),
    image_scatter_descriptor((
      ("./res/asimov.jpg", 10em, 10em, 0%, 0%),
      ("./res/star-trek.jpg", 10em, 10em, 25%, 1%),
      ("./res/babylon5.jpg", 10em, 10em, 50%, 0%),
      ("./res/feuerpoi.jpg", 10em, 10em, 65%, -45%))
    )), section: "About Me")
  #section_page("History and Motivation of Ultra-Cold Atoms")
  #generate_slide(timeline_descriptor(1980, 2027, events, legend, (5, 7, 9, 16, 19), ((0, 5), (5, 7), (7, 9), (9, 16), (16, 19))), section:"History and Motivation")
  #section_page("Quantum Simulator")
  #generate_slide(
    concatenate_descriptors(
      list_descriptor((
        ("S", [Optical Lattices, #h(0.5em) Orthogonal (reflected) Laser Beams]),
        ("S", [Optical Tweezer Arrays, #h(0.5em) Highly focused Laser Beam]),
        ("S", [Single-site manipulation]),
        ("S", [Feshbach Resonances $->$ Tunable (effective) interaction-strength]))),
      componentwise_add_descriptors(
        image_scatter_descriptor((("./res/feshbach1.png", 15em, 15em, 0em, 2em),)),
        image_scatter_descriptor((("./res/feshbach2.png", 15em, 15em, 20em, 2em),)))),
    section: "Quantum Simulator")
  #generate_slide(
    chain(
      hubbard(),
      Place(bottom + center, Highlight(mreturn([
        #cite(form: "full", <cstm:rico18>)
      ])))),
      section: "Quantum Simulator: Hubbard Model")
  #generate_slide(comparing_lists("Ultra-Cold Atoms", "Quantum-Chemistry",
    (
      [Few Body],
      [Non-relativistic => Schr\u{00f6}dinger Equation],
      [Variable Geometry],
      [#text(fill: red, "Inter-atomic Potential")],
      [#text(fill: red, "Bosons and Fermions")],
    ),
    (
      [Few Body],
      [Non-relativistic => Schr\u{00f6}dinger Equation],
      [Variable Geometry],
      [#text(fill: red, "Coulomb Interaction")],
      [#text(fill: red, "Indistinguishable Fermions")],
    )
  ), section: "Justification")
  #generate_slide(chain(
    mreturn([
      #v(0.5em)
      #align(top + center)[
          #rect(inset: 10% + 10pt)[
            $phi_"gto"^(sigma, R, alpha) = N product_(j=1)^3 (x_j - R_j)^(sigma_j) exp(-alpha(x_j - R_j)^2)$
        ]
      ]
    ]),
    comparing_lists(
      "Ultra-Cold Atoms (red: traps)",
      "Quantum-Chemistry (red: cores)",
      row_len: 50%,
      m: none,
      ([#cetz.canvas({
          import cetz.draw: *
          // Draw the cores
          for r in range(-20, 9) {
            let x = r / 5
            let x2 = (r + 1) / 5
            line(fill: red, stroke: red, (r * 5pt, -15pt * calc.exp(-(x * x))), ((r + 1) * 5pt, -15pt * calc.exp(-(x2 * x2))))
          }
          for r in range(-9, 15) {
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
        })],
        [#v(1.5em)CGTOs are phys. motivated]
      ),([#cetz.canvas({
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
        })],
        [#v(1.5em)#h(3.5em)CGTOs are #text(fill: red, "not") phys. motivated])),
      Place(bottom + center, dx: -1em, Highlight(mreturn([Traps $<->$ Cores\ Atoms $<->$ Electrons])))
    ))
    #section_page("Where we started & What we focus on")
    #context{[
    #generate_slide(chain(list_descriptor((
      ("S", [$2$-Boson FCI (B-splines, CGTOs)]),
      ("S", [Spectrum as a function of\ the s-wave scattering length $a$]),
      ("S", [Spectrum as a function of\ the tweezer positions]),
      ("S", [Confinement induced resonances\ (molecule formation $=>$ recombination losses)]))),
      join(
        Place(top, image_scatter_descriptor((("./res/2boson_rehm25.png", 100%, 100%, 7.5em, -1.5em),))),
        Place(bottom, mreturn([#text(cite(form: "full", <cstm:rehm25>), size:12pt)])),
        Place(top + right, Entitle("Morse", 12pt, -0.5em, mreturn([
            #text("Depth: [0.5, 15]", size:12pt)\ 
            #text("Minimum at: 0.3", size:12pt)\ 
            #text("Dampening^2: 10", size:12pt)]
          )))
    )), section: "Where we started & What we focus on")]}
    #section_page("Multi-Species Generalisation\n(MSSCF, MSFCI)")
    #generate_slide(list_descriptor((
      ("S", [Use product wave ansatz]), 
      ("S", [Construct energy funcional $E[Psi] = braket(Psi, H, Psi)$]), 
      ("S", [Minimize energy functional w.r.t single-particle wave function]), 
      ("S", [Coupled Fock equation for every species]), 
      ("M", (
        [Extended Pople-Nesbet equation],
        [Extended Pople-Nesbet equation $=>$ Internal consistency check of the theory]),
      ))),
      section: "MSSCF")
    #generate_slide(equation_descriptor((
      [
        $
        H = & sum_i^cal(N)_B sum_(n=1)^(N_i) h_i (r_(i,n)) + sum_i^cal(N)_F sum_(n=1)^(N_i) h_i (r_(i,n)) \
        $
        $cal(N)_B, cal(N)_F$: number of bosonic and fermionic species#h(0.5em)
        $N_i$: number of particles in $i$th species\ 
      ],
      [
        $
        H = & sum_i^cal(N)_B sum_(n=1)^(N_i) h_i (r_(i,n)) + sum_i^cal(N)_F sum_(n=1)^(N_i) h_i (r_(i,n)) \
            & - 1/2 sum_i^cal(N)_B sum_(n != m)^(N_i) w^((i i))(r_(i,n), r_(i,m))
              - 1/2 sum_i^cal(N)_F sum_(n != m)^(N_i) w^((i i))(r_(i,n), r_(i,m))
        $
        $cal(N)_B, cal(N)_F$: number of bosonic and fermionic species#h(0.5em)
        $N_i$: number of particles in $i$th species\ 
      ],
      [
        $
        H = & sum_i^cal(N)_B sum_(n=1)^(N_i) h_i (r_(i,n)) + sum_i^cal(N)_F sum_(n=1)^(N_i) h_i (r_(i,n)) \
            & - 1/2 sum_i^cal(N)_B sum_(n != m)^(N_i) w^((i i))(r_(i,n), r_(i,m))
              - 1/2 sum_i^cal(N)_F sum_(n != m)^(N_i) w^((i i))(r_(i,n), r_(i,m)) \
            & - 1/2 sum_(i,j)^cal(N)_B sum_(n,m)^(N_i,N_j) w^((i j))(r_(i,n), r_(j,m))
              - 1/2 sum_(i,j)^cal(N)_F sum_(n,m)^(N_i,N_j) w^((i j))(r_(i,n), r_(j,m))
        $
        $cal(N)_B, cal(N)_F$: number of bosonic and fermionic species#h(0.5em)
        $N_i$: number of particles in $i$th species\ 
      ],
      [
        $
        H = & sum_i^cal(N)_B sum_(n=1)^(N_i) h_i (r_(i,n)) + sum_i^cal(N)_F sum_(n=1)^(N_i) h_i (r_(i,n)) \
            & - 1/2 sum_i^cal(N)_B sum_(n != m)^(N_i) w^((i i))(r_(i,n), r_(i,m))
              - 1/2 sum_i^cal(N)_F sum_(n != m)^(N_i) w^((i i))(r_(i,n), r_(i,m)) \
            & - 1/2 sum_(i,j)^cal(N)_B sum_(n,m)^(N_i,N_j) w^((i j))(r_(i,n), r_(j,m))
              - 1/2 sum_(i,j)^cal(N)_F sum_(n,m)^(N_i,N_j) w^((i j))(r_(i,n), r_(j,m)) \
            & - sum_i^cal(N)_B sum_j^cal(N)_F sum_(n,m)^(N_i,N_j) w^((i j))(r_(i,n), r_(j,m)
        )
        $
        $cal(N)_B, cal(N)_F$: number of bosonic and fermionic species#h(0.5em)
        $N_i$: number of particles in $i$th species\ 
      ])), section: "MSSCF Hamiltonian")
      #generate_slide(list_descriptor((
        ("S", [Fermions: Well known Hartree-Fock ansatz\ \ $ket(cal(F)^(i)) = sum_(sigma in cal(S)_N) (-1)^(\# sigma) phi_(sigma(1))(r_1)..phi_(sigma(N))(r_N)$\ \ ]),
        ("S", [Bosons: All Bosons are in ground-state\ \ $ket(cal(B)^(i)) = phi_1(r_1) phi_1(r_2)...phi_1(r_N)$\ ]))),
        section: "MSSCF Wave Function Ansatz")
      #generate_slide(comparing_lists(
        "Bosonic Species",
        "Fermionic Species",
        m: none,
        (
          [#scale(x: 80%, y: 80%)[#bfock()]],
        ),
        (
          [#scale(x: 80%, y: 80%)[#ffock()]],
        )), section: "MSSCF Equations")
      #generate_slide(chain(comparing_lists(
        "Bosonic Species",
        "Fermionic Species",
        m: none,
        row_len: 70%,
        (
          [$
          ket(cal(B)^(i))=sum_(sigma in cal(S)_N) (+1)^(\# sigma) phi_(sigma(1))(r_1)..phi_(sigma(N))(r_N)
          $],
          [No Pauli exclusion principle],
          [/*$N_i$ out of $M$ */Draw #text(fill: red, "with") repetition $binom(M + N_i - 1, N_i)$],
          [Encoding e.g. $000$, $001$, $555$],
          [#text(fill: red, "Non-trivial") point group $cal(G)$]
        ),
        (
          [$
          ket(cal(F)^(i)) = sum_(sigma in cal(S)_N) (-1)^(\# sigma) phi_(sigma(1))(r_1)..phi_(sigma(N))(r_N)
          $],
          [Pauli exclusion principle],
          [/*$N_i$ out of $M$ */Draw #text(fill: red, "without") repetition $binom(M, N_i)$],
          [Encoding e.g. $123$, $124$, $345$],
          [#text(fill: red, "Trivial") point group]
        )),
        mreturn(
          place(left)[
          #line(length:100%)
          $ket(cal(B)^i)=sum_(sigma in (cal(S)_n \/ cal(G)))sum_(rho in cal(G))phi((sigma\.rho)(1))...phi((sigma\.rho)(N_i))$
          ,#h(0.5em)$frak(B) = product_i^cal(N) frak(B^i)$
          ,#h(0.5em)$"Fermions" subset "Bosons"$
        ])), section: "MSFCI Basis Generation")
      #generate_slide(chain(
        image_scatter_descriptor((("./res/msfci_neighbourship_classes.pdf", 33%, 33%, 0%, 0%),)),
        Place(top, dx: 5%, dy: 35%, mreturn(text(size: 12pt, fill: red, "Similar to Slater-Condon rules"))),
        image_scatter_descriptor((("./res/msfci_equation_matrix.pdf", 33%, 33%, 0%, 50%),)),
        Place(top, dx: 2.5%, dy: 85%, mreturn(text(size: 12pt, fill: red, "20 cases of brakets which have to be derived\n"))),
        image_scatter_descriptor((("./res/msfci_algo_loop.pdf", 75%, 90%, 33%, 0%),))),
        section: "MSFCI Algorithm")
      #section_page("Verification and Preliminary Results")
      #generate_slide(
        mreturn([
          #figure(
            image("./res/2boson_harm_reproduced_fixed.png", height:95%, fit: "contain"),
            caption: [2 Boson data (from #cite(form: "full", <cstm:rehm25>) ) reproduced. *Solid: Literature data. Dashed: MSFCI data*]
          )
        ]), section: "Verification and Preliminary Results")
      #generate_slide(
        mreturn([
        #figure(
          image("./res/3boson_2boson_comparison.png", height:95%, fit: "contain"),
          caption: [2 Boson / 3 Boson Comparison]
        )
      ]), section: "Verification and Preliminary Results")
      #generate_slide(
        mreturn([
        #figure(
          image("./res/3boson_msfci_benchmark.png", height:95%),
          caption: [2 Boson / 3 Boson Comparison]
        )
      ]), section: "Verification and Preliminary Results")
      #context{
      generate_slide(
        chain(
          Place(top, dx: 0%,
          Entitle("Next steps", SIZE0.get(), -0.5em, list_descriptor((
            ("S", [Confinement induced resonances for\ more than $2$ particles]),
            ("S", [Efimov Trimers]),
            ("S", [$n$-body recombinations]),
            ("S", [Fermionization of Bosons in\ (quasi) $1$d confinement]),
            ("S", [Mean-Field computations of densly\ occupied lattices]),
            ("S", [Exotic quantum-chemistry]),
          )))),
          Place(top, dx: 50%,
          Entitle("Further Developments", SIZE0.get(), -0.5em, list_descriptor((
            ("S", [Further generalise quantum-chemistry\ algorithms, DFT?]),
            ("S", [Angular interaction potentials $=>$ Rydberg-Atoms,\ molecules]),
            ("S", [TDSE]),
          )))),
          Place(top, dx: 50%, dy: 50%,
          Entitle("Applications to Nuclear Physics?", SIZE0.get(), -0.5em, list_descriptor((
            ("S", [Low energy nuclear reactions]),
            ("M", (
              [Multi-Species theory is basis #text(fill: red, "independent")],
              [Multi-Species theory is basis #text(fill: red, "independent")\ $=>$ Applicable to shell-models],
              [Multi-Species theory is basis #text(fill: red, "independent")\ $=>$ Applicable to shell-models])),
            ("S", [Exotic nuclei]),
            ("S", [Further ideas?]),
          )))),
          Place(top, dx: 50%, dy: 50%,
          Highlight(
          Entitle("Applications to Nuclear Physics?", SIZE0.get(), -0.5em, list_descriptor((
            ("B", (
              [Low energy nuclear reactions],
              [Multi-Species theory is basis #text(fill: red, "independent")\ $=>$ Applicable to shell-models],
              [Exotic nuclei],
              [Further ideas?])),
          ))))),
        ), section: "Outlook"
      )
    }
]

// Create bibliography
#show bibliography: none
#bibliography("custom.bib", style: "ieee-short.csl")
