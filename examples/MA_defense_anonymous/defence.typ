#import "taupsi.typ": *
#import "thetaimg.typ": thetaimg
#import "structure.typ": *
#show footnote.entry: set text(size: 10pt)
//#show cite: set cite(style: "ieee-short.csl")
#set cite(style: "chicago-notes")

#let authors = (
  ("Anonymous Author", "Humboldt Universität"),
)

#setup("Regularity of the Lorentzian Distance and Length Function at the Singular Boundary in the Kruskal Spacetime", "Kruskal Singularity", authors, default_colours)[
  // Set the default color of the highlight_container
  #let Highlight = Highlight.with(colour_palette: default_colours)

#generate_slide("Introduction","Schwarzschild",
  lift(grid(
  columns: (2fr, 1fr),
  [
    #v(2em)
    #align(left)[#text(weight: "bold")[\ What happens at the singularity? \ \ ]]

    #text[$ d s^2 = -(1 - r_s/r) d t^2 + (1 - r_s/r)^(-1) d r^2 + r^2 d Omega^2 $]
    #v(1em)
    #list([Singularities at $r=r_s$ and $r=0$],[$M_"int":=(0,r_s) times RR times S^2 => partial_t$ is spacelike],[$M_"ext":=(r_s,oo) times RR times S^2 => partial_t$ is timelike])
  ],
  align(center+horizon, image("blackhole.png", width: 130%)),
))
)

#generate_slide("Introduction", "Kruskal-Szekeres Extension", title: [Kruskal Coordinates],
  lift([#list(
    [For $r gt.eq r_s$: $ T : = (- 1 + r/(r_s))^(1/2) e^(r/(2 r_s)) sinh (t/(2 r_s)), quad X : = (- 1 + r/(r_s))^(1/2) e^(r/(2 r_s)) cosh (t/(2 r_s)) $]+v(1em), [For $r lt.eq r_s$: $ T : = (1 - r/(r_s))^(1/2) e^(r/(2 r_s)) cosh (t/(2 r_s)), quad X : = (1 - r/(r_s))^(1/2) e^(r/(2 r_s)) sinh (t/(2 r_s)) $]+v(1em), [Metric: $ d s^2=(4 r_s^3)/r e^(-r/r_s)(-d T^2+d X^2)+r^2(d theta^2+ sin^2 theta d phi^2)$]
  )])
)

#generate_slide("Introduction", "Kruskal-Szekeres Extension", 
//title: [Kruskal Coordinates],
  lift([
    #theorem[Kruskal spacetime is isometrically inextendable.]
    #grid(columns: (1fr, 2fr,0.01fr),
      [#firsthalfproofsk[ \ \
        Isometric inextendability follows from the divergence of tidal forces along all finite causal geodesics.]],
      [#align(center, image("maximality.png", width: 56%))],
      [#align(bottom, $square$)]
    )
  ])
)

#generate_slide("Introduction", "Kruskal-Szekeres Extension", //#title: [Penrose diagram],
  lift(
    grid(rows: (2fr, 1fr),
    [#align(center, image("penrose.png", width: 60%))],
    [#definition(title: "Lorentzian Lenght and Distance")[#text(size: 15pt)[$ ell(gamma) = lambda(p,q) : = integral_p^q sqrt(-g(dot(gamma)(t), dot(gamma)(t))) med d t \ tau(p, q) : = sup {ell(gamma) med bar.v med gamma " is a future-directed causal curve from " p " to " q} $]]]
  )
))

#generate_slide("Foundation", "Methodology", title: [Geometric & Causal Foundation],
  lift([
    #definition(title: "Global Hyperbolicity")[
      A time-oriented Lorentzian manifold $(M,g)$ is called *globally hyperbolic* (g.h.) if it satisfies the following two conditions:
      1. $(M,g)$ is causal;
      2. $forall p,q in M$, the set $J^+(p) inter J^-(q)$ is compact.
    ]
    #text[*Causal ladder*: chronological $->$ causal $->$ strongly causal $->$ _globally hyperbolic_]

    #text[- $M_"ext"$ and $M_"int"$ are globally hyperbolic when considered separately
    - In a g.h. spacetime, for $p<<q$ there exists a maximizing geodesic realising $tau(p,q)$
    - Killing vectors $partial_t$ and $partial_phi ->$ conserved quantities $E$ an $L$
    $->$ Restriction to future-directed timelike geodesics in $M_"int"$, with $r$ arbitrarily close to $0$
    ]
  ])
)

#generate_slide("Foundation", "Methodology", title: [Reduction to 1D integrals],
  lift([
    #text(size: 16pt)[$ E^2 = ((d r)/(d lambda))^2 + cal(h)(r)(1 + L^2/r^2), quad cal(h)(r) = 1 - r_s/r $
    - Reduction to $theta=pi/2$ (by $S O 3$-symmetry)
    - On $M_"int"$, $r$ is timelike, so $(d r)/(d lambda)<0$ along every future-directed timelike curve
    $-> r$ strictly monotonic and can be used as a curve parameter $->$ 1D Integral@oneill]
    #v(1em)
    #grid(
    columns: (1fr, 1fr),
    stroke: (x, y) => if x > 0 { (left: 1pt + black) },
    text(size: 16pt)[$ L=r^2 med (d phi)/(d lambda) \ phi(p,q) = integral_(r_q)^(r_p) L/(r^2) (d r)/sqrt(E^2 - (1 - (r_s)/r) (1 + (L^2)/(r^2))) $],
    text(size: 16pt)[$ E=cal(h)(r) med (d t)/(d lambda) \ t(p,q) = integral_(r_q)^(r_p) E/(1 - (r_s)/r) (d r)/sqrt(E^2 -(1 - (r_s)/r)(1 + (L^2)/(r^2))) $],
    )
  ])
)

#generate_slide("Foundadtion", "Methodology", title: [The Future Completion],
  lift([
    #theorem[The interior $M_"int"=(r_s,0) times  RR times S^2$ admits a future completion that is chronological homeomorphic to $overline(M)_"int"=(r_s,0] times RR times S^2$ which includes ideal boundary points. ]
    #grid(columns: (1fr,1fr,0.1fr),
    [#firsthalfproof[The proof can be found in 
    
    _Topologies on the future causal completion_@müllertopologies

    by Dr. Olaf Müller.
    ]],
    [#image("IPs.png", width: 68%)],
    [#align(bottom, $square$)]
    )
  ])
)

#generate_slide("Foundation", "Methodology", title: [Model Integral],
  lift([
    #proposition[Let $P(x)=a x+b x^2+c x^3$ with $c eq.not 0$. On every interval on which $abs(P(x))<1$, the integral #v(-2em) $ I_alpha (x)=integral d x med x^alpha med (1+P(x))^(-1/2) $ admits a convergent power series representation of the form $ I_alpha (x)= sum_(n,i,j in Z) binom(-1/2,n)binom(n,i) binom(n,j)med c^n med(-x_1)^(n-i) med (-x _2)^(n-j) med (x^(alpha+n+i+j+1))/(alpha+n+i+j+1) $ with #v(-2em) $ x_(1,2)=(-b +- sqrt(b^2-4a c))/(2c). $]
  ])  
)

#generate_slide("Foundation", "Methodology", 
//title: [Model Integral],
  lift([
    #grid(columns: (2fr, 1fr),
    [#firsthalfproofsk[
      1. Series expansion: $ (1 + u)^(-1/2) = sum_(n = 0)^infinity binom(-1/2, n)med u^n => "convergence radius:" abs(u)<1 $
      #v(0.65em)
      2. Factorisation by roots: $ a x+b x^2+c x^3=c(x-x_1)(x-x_2)x $
      #v(0.65em)
      3. Expansion of the roots: $ (x - x_y)^n = sum_(i = 0)^n binom(n, i) x^i (- x_y)^(n - i) $]],
    [#align(bottom+right)[$square$]])
  ])  
)

#generate_slide("Calculations", "Radial Case", title: [Radial Geodesics ($L=0$)],
  lift(
    grid(columns: (1fr, 2fr),
    align(center)[ Energy conditions:
    $ E^2 = ((d r)/(d lambda))^2 + (1 - (r_s)/r) $#v(3.42em) #line(length: 100%)\
    $ E = (1 - (r_s)/r) space.nobreak (d t)/(d lambda) $  
  ],
  align(center)[ Lorentzian length:
    $ lambda(p,s) = (R^(3/2))/(2 sqrt(r_s)) (pi - eta(p) - sin eta(p)) $
    $ eta(x) = arccos ((2 r_x)/R - 1) $ #line(length: 100%) Time function:
    $ t(p,s) = - E sum_(n, m = 0)^infinity binom(-1/2, n) med (r_s^(-n - m - 3/2) med k^n)/(n + m + 5/2) med r_p^(n + m + 5/2) $]
  ))
)

#generate_slide("Calculations", "Non-Radial Case", title: [Non-Radial Geodesics ($L eq.not 0$)],
  lift([$ lambda(p,s) = 1/L sum_(n, i, j) binom(-1/2, n) binom(n, i) binom(n, j) (1/(r_s))^(n - 1/2) ((- r_1)^(-i) med(- r_2)^(-j))/(n + i + j + 5/2) med r_p^(n + i + j + 5/2) $ \ $ phi(p, s) = sum_(n, i, j) binom(-1/2, n) binom(n, i) binom(n, j) (1/(r_s))^(n + 1/2) med ((- r_1)^(-i) med(- r_2)^(-j))/(n + i + j + 1/2) med r_p^(n + i + j + 5/2) $ \ $ t(p, s) = - E/L sum_(m, n, i, j) binom(-1/2, n) binom(n, i) binom(n, j) (1/(r_s))^(m + n + 3/2) med ((- r_1)^(-i) med(- r_2)^(-j))/(m + n + i + j + 7/2) med r_p^(m + n + i + j + 7/2) $])
)

#generate_slide("Calculations", "Non-Radial Case", title: [Hypergeometric Function],
  lift(align(center)[$ F_1 (a ; b_1 , b_2 ; c ; x, y) = sum_(m, n = 0)^infinity ((a)^overline(m + n) med(b_1)^overline(m) med(b_2)^overline(n))/((c)^overline(m + n) med m! med n!) med x^m med y^n $ \ $ G_1 (alpha ; r) := sum_(n = 0)^infinity binom(-1/2, n) (1/(r_s))^(n + 1/2) (r^(alpha + n))/(alpha + n) med F_1 (alpha + n ; - n, - n ; alpha + n + 1 ; r/(r_1) , r/(r_2)) $ \ $ lambda(p,s) = 1/L med G_1 (5/2 ; r_p) quad abs(quad phi(p,s) = G_1 (1/2 ; r_p)quad) quad t(p,s) = - E/L sum_(m = 0)^infinity r_s^(-m - 1) med G_1 (m + 7/2 ; r_p) $])
)


#generate_slide("Calculations", "Regularity", title: [Regularity at the Singular Boundary],
  chain(
    lift([$ xi :(r_p , E, L) |->(r_p , t(r_p , E, L), phi(r_p , E, L)) $]+v(2em)),
    lift(proposition[For $r>0$ satisfying $ abs(-r/r_s+r^2/L^2+ (k r^3)/(r_s L^2))<1, $ and $E eq.not 0$ the Jacobian determinant is non zero, i.e. $ det(d xi) eq.not 0. $]),
  )
)

#generate_slide("Calculations", "Regularity", title: [Regularity at the Singular Boundary],
  chain(
    lift(proofsk[

    1. Differentiate explicit power series expressions.

    2. Calculate $J=partial_E phi partial_L t - partial_L phi partial_E t$

    3. Start setting the first five coefficients to be zero and analyze the resulting condition.

    4. Result: $r_s=0$ or $r_1=r_2=> Delta=0$.]
  ))
)

#generate_slide("Calculations", "Regularity", title: [Regularity at the Singular Boundary],
  chain(
    lift(proposition[Differentiability of $lambda$ is ensured also for $L->0$ and fixed $r_p$.]),
    lift(firsthalfproofsk[ Rescale $(r,r_p,L)|->r_s (ep,kappa,delta)$: 

    1. Differentiate the integral representation and express in relation to: $ K_alpha = r_s^(1 - alpha) integral_0^kappa d ep (ep^(9/2 - alpha))/((k ep^3 + ep^2 - delta^2 ep + delta^2)^(3/2)), quad alpha in {0,2,3}. $
    
    2. Evaluate $0 lt.eq ep lt.eq delta$ and $delta lt.eq ep lt.eq kappa$ separately.
    ])
  )
)

#generate_slide2("Calculations", "Regularity", 
//title: [Regularity at the Singular Boundary],
  lift(sechalfproof[
    3. Use the notation $ f(x, y) limits(prop)_x x^a : <=> forall y: f(x, y) in cal(O)(x^a), $ to find #v(-2em) $ K_alpha dprop delta^(min(5/2-alpha,0)). $

    4. Use the chain rule with $A=mat(partial_E phi,partial_E t;partial_L phi, partial_L t)$, and $y^T=(partial_r phi,partial_r t).$ Inverte it to find no divergence: #v(-1em)$ mat(partial_E lambda; partial_L lambda; partial_r lambda) = overbrace(mat(A, 0; v^T, 1), = d xi) mat(partial_phi lambda; partial_t lambda; partial_r lambda)=> mat(partial_phi lambda; partial_t lambda; partial_r lambda) = mat(A^(-1), 0; -v^T A^(-1), 1) mat(partial_E lambda; partial_L lambda; partial_r lambda) dprop mat(delta^1; delta^0; delta^0). $
  ])
)

#generate_slide("Calculations", "Regularity", title: [Regularity at the Singular Boundary],
  chain(
    lift(proposition[Differentiability of $lambda$ is ensured also for $(r_p,L)=r_s (kappa,delta)|->(0,0).$]),
    lift(firsthalfproofsk[ 
      1. Consider the generalized integral $ K_alpha = r_s^(1 - alpha) integral_0^kappa d ep (ep^(9/2 - alpha))/((k ep^3 + ep^2 - delta^2 ep + delta^2)^(3/2)), $ but this time separatly evaluate $kappa lt delta$ and $delta lt kappa$.
    ])
  )
)

#generate_slide2("Calculations", "Regularity", 
//title: [Regularity at the Singular Boundary],
  lift(sechalfproof[
    2. Same leading order $->$ introduce $chi:= max(kappa,delta)$ and find $ K_alpha cprop chi^(5/2-alpha) $ by treating $sigma:=delta/kappa$ and $chi$ as independant variables.

    3. Explicitally determine $chi$-proportionality of each differential.

    4. Use the chain rule again, which takes the form:
    $ mat(partial_phi lambda; partial_t lambda) = A^(-1) mat(partial_E lambda; partial_L lambda) = 1/(K_0 K_3 + L^2 K_2 K_3) mat(-E^2 L K_2 K_0 - L K_0 K_3 - L^3 K_2 K_3; E K_0 K_3 + E L^2 K_2 K_3) + Xi, $ 
      where $Xi$ are higher order terms vanishing in the limit. The divergence cancels out.
  ])    
)

#generate_slide("Calculations", "Regularity", title: [Differentiability at the Singular Boundary],
      lift([#proposition[
      $lambda$ is not differentiable with respect to $r$.
    ]
    #firsthalfproofsk[
      
      Let $L gt 0$ be fixed and $r_p->0$. Looking at the integral we know $K_alpha kprop kappa^(11/2-alpha).$

      Using the chain rule introduced earlier yields $ mat(partial_phi lambda; partial_t lambda) kprop kappa^(-6) mat(kappa^(-1/2), kappa^(5/2)) mat( kappa^(7/2), kappa^(7/2); kappa^(5/2), kappa^(7/2)) mat(kappa^(11/2);  kappa^(5/2)) kprop mat(#text(fill: rgb(160,0,0))[$kappa^(-1/2)$] ;kappa^(5/2)). $
    ]#v(-2em)#align(right)[$square$]]
  )
)

#generate_slide("Calculations", "Regularity", title: [Differentiability at the Singular Boundary],
  chain(
    lift(proposition[Differentiability of $lambda$ is also assured with respect to $theta$.]),
    lift(firsthalfproofsk[ The angle so far denoted as $phi$ is now $phi_c$ and the actual one is $phi_a$. The relation between them is given by $ cos phi_c = hat(e)_p dot hat(e)_s = cos phi_a sin theta. $

    By using the chain rule as before, every divergence cancels out.
    ])
  )
)

#generate_slide("Calculations", "Regularity", 
//title: [Differentiability with respect to $theta$],
  lift(sechalfproof[The geometric idea:
      #align(center, scale(150%, thetaimg()))
    ])
)

#generate_slide("Outlook", "", //title: [Outlook],
  lift([
    #note(title: "Conclusion")[We found non-trivial regularity properties at the singular boundaries along $partial_phi$ and $partial_t$.]
    
    *Next step:* Formulate a more generalized statement on the Differentiability of $tau$ with respect to $phi$ and $t$ for any neighbourhood $U$ of $q in cal(S)$.
    #v(0.5em)
    $->$ Investigate other solutions of the Einstein field equations (i.e. Kerr or Kerr-Newman@ONeillKerr).
    #thanks[This presentation was created using the typst template "taupsi". Credit and thanks to Lyding Brumm for creating it.]
    #grid(columns: (5fr,1fr),
    [#v(2em)#note(title: "Goal")[Find a Synthetic extension to the Kruskal spacetime at $r=0$.]],
    [#align(right, image("kerr.png", width: 90%))]
    )
  ])
)

#generate_slide2("Proof", "Kruskal maximality", //title: "Kruskal Maximality",
  lift(firsthalfproof[
    #note(title: "Goal")[$K_m$ admits no $C^2$ isometric extension.]
    *Idea*: Follow $C^0$-inextendible future timelike geodesic curves!
    #v(1em)
    Does the geodesic curve $c:(a,b)->K_m$ cross the horizon $r=r_s$?
    
    *Case 1* - yes: $r compose c(s)-->_(s->b)0$
    
    *Case 2* - no: $t compose c(s)->oo => ell(c)=oo$
    #v(1em)
    Kretschmann Scalar#v(-3em) $ cal(K)=R_(i j k l)R^(i j k l)=(12r_s^2)/r^6-->_(r->0)oo $
    #v(-2em)#align(right)[$square$]
  ])
)
#generate_slide2("Proof", "Kruskal maximality",
  lift(firsthalfproof[
    #note(title: "Goal")[$K_m$ admits no $C^2$ isometric extension.]
    *Idea*: Follow $C^0$-inextendible future timelike geodesic curves!
    #v(1em)
    Does the geodesic curve $c:(a,b)->K_m$ cross the horizon $r=r_s$?
    
    *Case 1* - yes: $r compose c(s)-->_(s->b)0$
    
    *Case 2* - no: $t compose c(s)->oo => ell(c)=oo$
    #v(1em)
    Kretschmann Scalar#v(-3em) $ cal(K)=R_(i j k l)R^(i j k l)=(12r_s^2)/r^6-->_(r->0)oo $
    #v(-2em)#align(right)[$square$]
  ])
)
#generate_slide2("Proof", "Kruskal maximality",
  lift(firsthalfproof[
    #note(title: "Goal")[$K_m$ admits no $C^2$ isometric extension.]
    *Idea*: Follow $C^0$-inextendible future timelike geodesic curves!
    #v(1em)
    Does the geodesic curve $c:(a,b)->K_m$ cross the horizon $r=r_s$?
    
    *Case 1* - yes: $r compose c(s)-->_(s->b)0$
    
    *Case 2* - no: $t compose c(s)->oo => ell(c)=oo$
    #v(1em)
    Kretschmann Scalar#v(-3em) $ cal(K)=R_(i j k l)R^(i j k l)=(12r_s^2)/r^6-->_(r->0)oo $
    #v(-2em)#align(right)[$square$]
  ])
)

#generate_slide2("Information", "Future Completion",
  lift([
    #definition(title: "Chronological Homeomorphism")[A chronological homeomorphism between two spacetimes $M$ and $N$ is a homeomorphism $f:M->N.$ that preserves the chronological relation: $ p<<q <=> f(p)<<f(q). $]
  ])
)

#generate_slide2("Information", "Hypergeometric Function",
  lift([
    *Definition*#v(-0.5em)
    The Appell series $F_1$ is defined for $abs(x)<1$ and $abs(y)<1$ by $ F_1 (a ; b_1 , b_2 ; c ; x, y) = sum_(m, n = 0)^infinity ((a)^overline(m + n) med(b_1)^overline(m) med(b_2)^overline(n))/((c)^overline(m + n) med m! med n!) med x^m med y^n. $ #v(-0.5em)
    *Derivatives*#v(-0.5em)
    $ partial^n/(partial x^n) F_1(a,b_1,b_2,c;x,y)=((a)^(overline(n))(b_1)^(overline(n)))/((c)^(overline(n))) F_1(a+n,b_1+n,b_2,c+n;x,y) $ 
    //partial^n/(partial y^n) F_1(a,b_1,b_2,c;x,y)=((a)^(overline(n))(b_2)^(overline(n)))/((c)^(overline(n))) F_1(a+n,b_1,b_2+n,c+n;x,y) $ 
    *Integral representation*#v(-0.5em)
    $ F_1(a,b_1,b_2,c;x,y)=(Gamma(c))/(Gamma(a)Gamma(c-a)) integral_0^1 t^(a-1)(1-t)^(c-a-1)(1-x t)^(-b_1)(1-y t)^(-b_2) d t $ with $Re c > Re a> 0$
  ])
)

#generate_slide2("Information", "Finiteness", title: "Finiteness",
  lift([
    If we consider Radial geodesics starting from $r_p=r_s$ at rest, we find: $lambda(p,s)=(pi r_s)/2. $
    
    Metric: $g =-(1- r_s/r) d t^2+(1- r_s/r)^(-1)d r^2+r^2d Omega $
    
    For a future-directed causal curve $gamma:[r_p,r_q)->M$ starting at a point $p$ with $gamma(r_p)=p,$ one finds:
    #v(-1.5em)
    $ lambda(p,q)=integral_(r_q)^(r_p) sqrt(-g(dot(gamma)(r),dot(gamma)(r)))d r lt.eq integral_(r_q)^(r_p) sqrt((r_s/r-1)^(-1))d r. $

    Assume $r<r_s/2=>lambda(p,q)<r_p-r_q lt.eq r_p.$

    *Continuity*: $M_"int"$ is g.h., let $s=(0,phi,theta,t)in cal(S) "and" ep>0.$ 
    - $U:=I^+(ep,phi,theta,t)$ open nbh. of $s$ 
    - $abs(tau(p,x)-tau(p,s))lt.eq ep med forall x in U$
  ])
)

#generate_slide2("Proof", "Regularity", 
//title: [Regularity at the Singular Boundary],
  chain(
    lift(proofsk[The Jacobi-determinant: $J = partial_E phi partial_L t - partial_L phi partial_E t $
    $ = #h(-0.5cm) sum_(n, i, j, u, v, k, ell) binom(-1/2, n) binom(n, i) binom(n, j) binom(-1/2, u) binom(u, k) binom(u, ell) E/L (1/(r_s))^(u + v + n + 2) #h(-2.3cm) (r_p^(n + i + j + u + v + k + ell + 4))/((n + 1/2 + i + j)(u + 7/2 + v + k + ell)) \
    quad dot.op [(i ell - j k)((-2 E^2 r_s)/(L E(E^2 - 1) Delta)) - i dot.op (r_s - 2 E^2 r_s + 2 Delta)/(2 L E(E^2 - 1) Delta) - j dot.op (-r_s + 2 E^2 r_s + 2 Delta)/(2 L E(E^2 - 1) Delta)] $
    This is not well-defined for $Delta->0$, but if we take a closer look at its origin:
    $ partial_L (r_1^i med r_2^j) = [(i - j) (r_s)/(2 Delta) + (i + j)] 2/L med k^(i + j - 1)dot (Delta - (r_s)/2)^(-i) (- Delta - (r_s)/2)^(-j) $
  ]
  ))
)

#generate_slide2("Proof", $"Differentiability w.r.t." theta$,
  lift(proof[ To get the actual $phi_a$ from the formerly calculated $phi_c$, we must look at the projection of the point $p$ into the $(theta=pi/2)$-plane. #v(1em) Consider
  $ cos phi_c = hat(e)_p dot hat(e)_s = mat(cos phi_a sin theta; sin phi_a sin theta; cos theta) dot mat(1;0;0)=cos phi_a sin theta, $ to find $ (partial phi_a)/(partial phi_c)=(sin phi_c)/(sin phi_a sin theta). $ 

  Now use the chain rule $ mat(partial_theta lambda; partial_E lambda; partial_L lambda; partial_r lambda) = underbrace(mat(1, partial_theta phi_a, 0, 0;
  0, partial_E phi_a, partial_E t, 0;
  0, partial_L phi_a, partial_L t, 0;
  0, partial_r phi_a, partial_r t, 1), = : B) mat(partial_theta lambda; partial_(phi_a) lambda; partial_t lambda; partial_r lambda), $ and invert $B$ with $x^T:=(partial_theta phi_a,0)$ to find $ B^(-1)=mat(1,-x^T A^(-1),0;0,A^(-1),0;0,-v^T A^(-1),1). $ Explicit calculation yields $ A^(-1)=1/J_c mat(xi med partial_L t, -xi med partial_E t;-partial_L phi_c,partial_E phi_c) " with " xi:=(sin phi_a sin theta)/(sin phi_c) \ #v(4em) -x^T A^(-1)=(partial_L t,-partial_E t)/J_c dot (cos phi_a cos theta)/(sin phi_c), $ where $phi_c=0=>theta=pi/2<=>phi_c=phi_a $
  ])
)]

#show bibliography: none
#bibliography("ref.bib", style: "ieee-short.csl")
