#import "@preview/cetz:0.3.4": canvas, draw

#canvas({
  import draw: *

  // ── parameters ───────────────────────────────────────────────
  let r-rings   = 9        // number of constant-r rings
  let phi-lines = 16       // number of constant-φ radial lines
  let r-max     = 4.5      // outer radius in 3D units
  let depth     = 7.0      // singularity depth
  let sharpness = 0.55     // how steeply the funnel curves (0=flat, 1=sharp)
  let pts-ring  = 80       // points per ring (smoothness)
  let pts-rad   = 40       // points per radial line

  // ── Schwarzschild-like z depression ──────────────────────────
  // z = -depth * (1 - r/r-max)^sharpness  (smooth, zero at rim)
  let z-of-r(r) = {
    if r >= r-max { 0.0 }
    else {
      let t = 1 - r / r-max
      -depth * calc.pow(t, sharpness)
    }
  }

  // ── isometric projection (hand-rolled) ───────────────────────
  let iso(x, y, z) = {
    let sx =  (x - y) * 0.866   // cos 30°
    let sy =  (x + y) * 0.30 + z * 0.72
    (sx, sy)
  }

  // ── convert polar → iso ───────────────────────────────────────
  let pt(r, phi) = {
    let x = r * calc.cos(phi)
    let y = r * calc.sin(phi)
    iso(x, y, z-of-r(r))
  }

  // ── draw constant-r rings ─────────────────────────────────────
  for i in range(1, r-rings + 1) {
    let r = r-max * i / r-rings
    let coords = range(pts-ring + 1).map(k => {
      let phi = k / pts-ring * 360deg
      pt(r, phi)
    })
    hobby(..coords, stroke: gray.darken(15%) + 0.45pt, fill: none)
  }

  // ── draw constant-φ radial lines ──────────────────────────────
  for j in range(phi-lines) {
    let phi = j / phi-lines * 360deg
    let coords = range(pts-rad + 1).map(k => {
      let r = r-max * k / pts-rad
      pt(r, phi)
    })
    hobby(..coords, stroke: gray.darken(15%) + 0.45pt, fill: none)
  }

  // ── singularity: lines from inner ring down to tip ────────────
  let tip-3d = (0.0, 0.0, z-of-r(0) - 2.5)
  let tip    = iso(tip-3d.at(0), tip-3d.at(1), tip-3d.at(2))

  for j in range(phi-lines) {
    let phi  = j / phi-lines * 360deg
    let edge = pt(r-max * 1 / r-rings, phi)  // innermost ring
    line(edge, tip, stroke: gray.darken(25%) + 0.35pt)
  }
  circle(tip, radius: 0.07, fill: black, stroke: none)

  // ── axis arrows ───────────────────────────────────────────────
  let o  = iso(-r-max - 0.3, -r-max - 0.3, 0)
  let ax = iso(-r-max - 0.3 + 2.0, -r-max - 0.3, 0)
  let ay = iso(-r-max - 0.3, -r-max - 0.3 + 2.0, 0)
  let az = iso(-r-max - 0.3, -r-max - 0.3, 2.0)

  line(o, ax, mark: (end: ">"), stroke: black + 0.7pt)
  line(o, ay, mark: (end: ">"), stroke: black + 0.7pt)
  line(o, az, mark: (end: ">"), stroke: black + 0.7pt)
  content(ax, [x], anchor: "west",  padding: 0.12)
  content(ay, [y], anchor: "south", padding: 0.12)
  content(az, [z], anchor: "south", padding: 0.12)

  // ── labels ────────────────────────────────────────────────────
  let bh  = iso(r-max * 0.55, -r-max * 0.95, 0.1)
  content(bh,  [Black hole],  anchor: "west")
  content(tip, [Singularity], anchor: "north", padding: 0.3)
})