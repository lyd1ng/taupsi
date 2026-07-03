#import "@preview/cetz:0.5.1": angle, canvas, draw
#import draw: circle, content, line, group, rotate

#set page(width: auto, height: auto, margin: 8pt)

#let thetaimg() = canvas({
  // Helper coordinates
  let rad = 4
  let vec-a = (rad / 3, rad / 2)
  let phi-point = (rad / 3, -rad / 5)
  let mark = (end: "stealth", fill: black)

  // Bloch vector
  line((0, 0), vec-a, mark: (start: "circle", end: "circle", fill: black, scale: .5, anchor: "center"))

  // Dashed line forming angle
line(
  (0, 0),
  phi-point,
  stroke: (paint: gray, dash: "dotted")
)

line(
  phi-point,
  vec-a,
  stroke: (paint: gray, dash: "dotted")
)
  // Axes
  let arrow-extend = 1.15
  line((0, 0), (-rad / 5 * 1.2, -rad / 3 * 1.2), mark: mark, name: "x1")
  content("x1.end", [], anchor: "north")

  line((0, 0), (arrow-extend * rad, 0), mark: mark, name: "x2")
  content("x2.end", [], anchor: "west")

  line((0, 0), (0, arrow-extend * rad), mark: mark, name: "x3")
  content("x3.end", [], anchor: "south")

  // Angles
  angle.angle(
    (0, 0),
    (-1, -calc.tan(60deg)),
    (1, -calc.tan(30deg)),
    radius: 0.6,
    label: text(10pt, [$phi_a$]),
    stroke: (paint: gray, thickness: .5pt),
    mark: (end: "stealth", fill: gray, scale: .5),
  )

  angle.angle(
    (0, 0),
    (1, calc.tan(60deg)),
    (1, calc.tan(90deg)),
    radius: 0.6,
    label: text(10pt, [$theta$]),
    stroke: (paint: gray, thickness: .5pt),
    mark: (start: "stealth", fill: gray, scale: .5),
    label-radius: 0.8,
  )

angle.angle(
  (0, 0),
  (1, -calc.tan(30deg)),
  (1, calc.tan(56.3deg)),
  radius: 0.8,
  label: text(10pt, [$phi_c$]),
  label-radius: 1.1,
  label-anchor: "east",
  stroke: (paint: gray, thickness: .5pt),
  mark: (end: "stealth", fill: gray, scale: .5),
)

  // Sphere
  circle((0, 0), radius: rad)
  //circle((0, 0), radius: (rad, rad / 3), stroke: (dash: "dashed"), fill: rgb(160, 0, 0).transparentize(80%))

content(vec-a, text(10pt,[$p$]), anchor: "south-west")
circle(phi-point, radius: 1.5pt, fill: black, stroke: none)
content(phi-point, text(10pt, [$p'$]), anchor: "north")
//fill: black, scale: .5, anchor: "center"
content((-2.5,0), text(12pt,rgb(160,0,0), [$theta=pi/2$]))

circle((0, 0), radius: (rad, rad / 3), stroke: (paint: rgb(160,0,0).transparentize(50%),dash: "densely-dashed"), fill: rgb(160, 0, 0).transparentize(80%))
  group({
    rotate(56.3deg)
    circle((0, 0), radius: (rad, rad / 3), stroke: (paint: rgb("#259f0a").transparentize(50%),dash: "densely-dashed"), fill: rgb("#259f0a").transparentize(80%))
  })

circle((rad, 0), radius: 1.5pt, fill: black, stroke: none)
content((rad+0.1, 0.2), text(10pt,[$s$]), anchor: "west")

circle(phi-point, radius: 1.5pt, fill: black, stroke: none)
  line((0, 0), vec-a, mark: (start: "circle", end: "circle", fill: black, scale: .5, anchor: "center"))


})
