class: middle, title-slide, hide-count

## Hybrid quantum-classical circuit optimization with the ZX-calculus

.author[.underline[Agustín Borgna]¹², Simon Perdrix¹, Benoît Valiron³]

.date[23rd September 2020]

.affiliations[
¹ CNRS LORIA, Inria-MOCQUA, Université de Lorraine

² CNRS, LRI, Université Paris-Saclay

³ École CentraleSupélec, LRI, Université Paris-Saclay
]

---

# The setting

.padded[
- Mixed quantum-classical circuits expressed in the circuit model
]

![:vspace 2em]()

.center[
  ![:img 50%](img/tikz/superdenseCoding-circuit.svg)
]

---
layout: true

# ZX-diagrams

.middle.center.font120[
  ![:img 20%](img/tikz/pureZX-circ.svg)
  \\(\; \Rightarrow\\)
  <span style="width: 43%; display: inline-block">{{content}}</span>
]

---

![:scaleSVG 4](img/tikz/pureZX-diag-0.svg)

---
count: false
![:scaleSVG 4](img/tikz/pureZX-diag-0-0.svg)

---
count: false
![:scaleSVG 4](img/tikz/pureZX-diag-1.svg)

---
count: false
![:scaleSVG 4](img/tikz/pureZX-diag-2.svg)

---
count: false
![:scaleSVG 4](img/tikz/pureZX-diag-3.svg)

---
count: false
![:scaleSVG 4](img/tikz/pureZX-diag-4.svg)

---
layout: true

# The \\(\zxGnd\\)-calculus

.padded[
  - \\(\zxGnd\\) adds a discarding *ground generator*
]

.center.padded[
  {{content}}
]

![:vspace 3em]()

.center.font80[
  ![:scaleSVG 3](img/tikz/discard-a.svg)
  \\(\qquad=\qquad\\)
  ![:scaleSVG 3](img/tikz/discard-b.svg)
  ![:hspace 8em]()
  ![:scaleSVG 3](img/tikz/gndConnection-sm-a.svg)
  \\(\qquad=\qquad\\)
  ![:scaleSVG 3](img/tikz/gndConnection-sm-b.svg)
]

---

![:scaleSVG 4](img/tikz/gnd.svg)

---
count: false
![:scaleSVG 4](img/tikz/spiderZgnd.svg)

---
layout: true

# Quantum circuits as \\(\zxGnd\\)-diagrams

![:vspace 3em]()

.center.font110[
  ![:img 45%](img/tikz/superdenseCoding-circuit.svg)
  \\(\; \mapsto \\)
  <span style="width: 43%; display: inline-block">{{content}}</span>
]
![:vspace 2em]()

.padded[
  - The translated diagram is *weakly graph-like*
]

---
![:img 100%](img/tikz/superdenseCoding-zx-full.svg)

---
count: false
![:img 100%](img/tikz/superdenseCoding-zx.svg)

---
count: false
layout: false

# Quantum circuits as \\(\zxGnd\\)-diagrams

![:vspace 3em]()

.center.font110[
  ![:img 45%](img/tikz/superdenseCoding-circuit.svg)
  \\(\; \mapsto \\)
  <span style="width: 43%; display: inline-block">{{content}}
  ![:img 100%](img/tikz/superdenseCoding-zx-strict.svg)
  </span>
]![:vspace 2em]()

.padded[
  - The translated diagram is *~~weakly~~* **strictly** *graph-like*
]

---
layout: true

# Underlying open-graph

![:vspace 2em]()

.center.font110[
  ![:img 35%](img/tikz/superdenseCoding-zx-strict-trim.svg)
  \\(\; \mapsto \;\\)
  <span style="width: 30%; display: inline-block">{{content}}</span>
]

.padded[
- Labeled .blue[input] and .red[output] nodes

- Admits a *focused gFlow*
]

---
![:img 100%](img/superdenseCoding-opengraph-io-strict.svg)

---
layout:false

# ZX diagram optimization rules

.padded[
- gFlow-preserving Clifford optimization
(Duncan et. al. arXiv:1902.03178):
]

.center[
Local complementation: ![:hspace 1em]() ![:img 30%](img/tikz/lc-simp-box.svg)

![:vspace 1em]()

Pivot: ![:hspace 1em]() ![:img 70%](img/tikz/pivot-simp-box.svg)
]

---

# Ground-related optimizations

.center[

![:vspace 2em]()

Discarding: ![:hspace 1em]()
![:img 13%](img/tikz/gndDiscard-a.svg)
\\(\ =\ \\)
![:img 10%](img/tikz/gndDiscard-b.svg)

![:vspace 3em]()

Ground-Pauli pivot: ![:hspace 1em]()
![:img 30%](img/tikz/gndDeletion-a.svg)
\\(\ =\ \\)
![:img 30%](img/tikz/gndDeletion-b.svg)

]

---
layout: true

# Finding optimizations on the ground-cut diagram

![:vspace .3em]()

.hpadded[
- Find optimization opportunities by looking at the ground-cut biadjacency
  matrix
]

![:vspace .3em]()

.center[
  {{content}}
]

![:vspace .3em]()

.hpadded[
- Apply Gauss elimination on the matrix
]

![:vspace .3em]()

.center[
![:img 25%](img/tikz/gnd-row-sum-0.svg)
\\(\ =\ \\)
![:img 25%](img/tikz/gnd-row-sum-4.svg)
]

---

![:img 15%](img/tikz/matrix-example.svg)
\\(\ \mapsto\ 
  \begin{pmatrix}
    1 & 1 \\\\
    0 & 1 \\\\
    0 & 1 \\\\
  \end{pmatrix}
\\)

---
count: false
![:img 15%](img/tikz/matrix-example-1.svg)
\\(\ \mapsto\ 
  \begin{pmatrix}
    1 & 0 \\\\
    0 & 1 \\\\
    0 & 1 \\\\
  \end{pmatrix}
\\)

---
count: false
![:img 15%](img/tikz/matrix-example-2.svg)
\\(\ \mapsto\ 
  \begin{pmatrix}
    1 & 0 \\\\
    0 & 1 \\\\
    0 & 0 \\\\
  \end{pmatrix}
\\)

---
layout: true

# Optimization algorithm

.columns.padded[

.column50[
Simplified algorithm:
1. Run Clifford optimizations  

2. Loop until stable:

  1. Gauss elimination on ground-cut 

  2. Remove disconnected grounds

  3. Apply discard rule

  4. Apply ground-Pauli pivots
]

.column50.center[
![:vspace 5em]()
{{content}}
]

]

---

![:vspace 54px]()
![:scaleSVG 4](img/tikz/optimizationB-0.svg)

---
count: false
![:vspace 54px]()
![:scaleSVG 4](img/tikz/optimizationB-1.svg)

---
count: false
![:vspace 42px]()
![:scaleSVG 4](img/tikz/optimizationB-2.svg)

---
count: false
![:scaleSVG 4](img/tikz/optimizationB-3.svg)

---
layout: true

# Circuit extraction

.padded[
- Based on Duncan et al.'s procedure

- Introduces fan-in and fan-out extractions
]

.center[
  {{content}}
]

---

![:img 50%](img/tikz/extraction-00.svg)
![:vspace 1em]()
![:img 50%](img/tikz/extraction-circ-00.svg)

---
count: false
![:img 50%](img/tikz/extraction-01.svg)
![:vspace 1em]()
![:img 50%](img/tikz/extraction-circ-01.svg)

---
count: false
![:img 50%](img/tikz/extraction-02.svg)
![:vspace 1em]()
![:img 50%](img/tikz/extraction-circ-02.svg)

---
count: false
![:img 50%](img/tikz/extraction-03.svg)
![:vspace 1em]()
![:img 50%](img/tikz/extraction-circ-03.svg)

---
count: false
![:img 50%](img/tikz/extraction-04.svg)
![:vspace 1em]()
![:img 50%](img/tikz/extraction-circ-04.svg)

---
count: false
![:img 50%](img/tikz/extraction-05.svg)
![:vspace 1em]()
![:img 50%](img/tikz/extraction-circ-05.svg)

---
count: false
![:img 50%](img/tikz/extraction-06.svg)
![:vspace 1em]()
![:img 50%](img/tikz/extraction-circ-06.svg)

---
count: false
![:img 50%](img/tikz/extraction-07.svg)
![:vspace 1em]()
![:img 50%](img/tikz/extraction-circ-07.svg)

---
count: false
![:img 50%](img/tikz/extraction-08.svg)
![:vspace 1em]()
![:img 50%](img/tikz/extraction-circ-08.svg)

---
count: false
![:img 50%](img/tikz/extraction-09.svg)
![:vspace 1em]()
![:img 50%](img/tikz/extraction-circ-09.svg)

---
count: false
![:img 50%](img/tikz/extraction-10.svg)
![:vspace 1em]()
![:img 50%](img/tikz/extraction-circ-10.svg)

---
count: false
![:vspace 7px]()
![:img 50%](img/tikz/extraction-11.svg)
![:vspace 1em]()
![:img 50%](img/tikz/extraction-circ-11.svg)

---
count: false
![:vspace 7px]()
![:img 50%](img/tikz/extraction-final.svg)
![:vspace 1em]()
![:img 50%](img/tikz/extraction-circ-final.svg)

---
layout: false

# Detecting classical wires

.padded[
- Label the spiders that can form a classical gate

- Use classical logic where possible
]

.center[
![:vspace 3px]()
![:img 50%](img/extraction-classical.svg)
![:vspace 1em]()
![:img 50%](img/tikz/extraction-circ-classical.svg)
]

---

# Summary

.padded[

![:vspace 1em]()

- Extended a pure-quantum optimization algorithm to mixed circuits using \\(\\zxGnd\\)

![:vspace .5em]()

- Introduced new optimization rules using the discarding operator

![:vspace .5em]()

- Defined an extraction procedure for the optimized diagrams

![:vspace .5em]()

- Implemented and tested on the *pyzx* python library

![:vspace .5em]()
]

---

class: inverse, center, middle, hide-count
count: false

# Thanks!
