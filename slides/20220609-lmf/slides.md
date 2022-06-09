class: middle, title-slide, hide-count

## ZX diagrams as IR for quantum compilers

.author[Agustín Borgna]

.author[Advisors: Simon Perdrix, Benoît Valiron]

.date[9th June 2022]

---

# The lifecycle of quantum programs

.center[
![:img 90%](img/overview-circ.svg)
]

---
count: false

# The lifecycle of quantum programs

.center[
![:img 90%](img/overview-zx.svg)
]

---

# Circuit optimization

.padded[
- Optimization procedure by Duncan et. al. (arXiv:1902.03178)
]

.center.font80[
  ![:scaleSVG 1](img/tikz/overview-pure-circ.svg)
  \\(\; \xrightarrow{Translate}\\)
  ![:scaleSVG 1](img/tikz/overview-pure-graphlike.svg)

  ![:vspace 1em]()

  \\(\; \xrightarrow{Optimize}\\)
  ![:scaleSVG 1](img/tikz/overview-pure-optimized.svg)
  \\(\; \xrightarrow{Extract}\\)
  ![:scaleSVG 1](img/tikz/overview-pure-extracted.svg)
]

.padded[
- Extended support to hybrid quantum-classical circuits
]

---
layout: false

# Hybrid circuit classicalization

.padded[
- Detect classical sections in quantum circuits
]

.center[
![:img 30%](img/tikz/extraction-circ-final.svg)
![:hspace 1em]()
→
![:vspace 2em]()
![:img 30%](img/extraction-classical.svg)
![:hspace 1em]()
→
![:hspace 1em]()
![:img 30%](img/tikz/extraction-circ-classical.svg)
]

---

# The lifecycle of quantum programs

.center[
![:img 90%](img/overview-zx.svg)
]

---
count: false

# The lifecycle of quantum programs

.center[
![:img 90%](img/overview-szx.svg)
]

---

# Compiling high-level programs

.padded[
- Encode dependently typed programs directly
]

.center[

  .font70[

  \\(
  \begin{aligned}
    \text{apply\_crot}&: (n:\nat) \to (k:\nat) \to \vec{\qubit}{n} \multimap \vec{\qubit}{n} \\\\
    \text{apply\_crot}&:= \lambda' n^\nat.\ \lambda' k^\nat.\ \lambda qs^{\vec{\qubit}{n}}.
    \ifz{n-k}{qs}{}\\\\
    & \Qlet{h^{\vec{\qubit}{k}}\otimes qs'^{\vec{\qubit}{n-k}}}
    {\Qsplit\ k\ (n-k)\ qs}{}\\\\
    & \Qlet{q^\qubit \otimes cs^{\vec{\qubit}{n-k-1}}}
    {\text{chop } qs'}{}\\\\
    & \Qlet{fs^{\vec{(\qubit\otimes\qubit\multimap\qubit\otimes\qubit)}{(n-k-1)}}}
    {\Qfor{m^\nat}{2..(n-k+1)}{\text{crot }m}}{}\\\\
    & \Qlet{cs'^{\vec{\qubit}{n-k-1}}\otimes q'} 
    {\Qaccumap\ fs\ (H\ q)\ cs}{}\\\\
    & \text{concat } h\ (q': cs')
  \end{aligned}
  \\)

  ]

  n,k ↦ ![:img 50%](img/tikz/qft-applycrot.svg)
]

---
class: inverse, noheader


![:vspace 10em]()

.center.bold[
  Thanks!
]