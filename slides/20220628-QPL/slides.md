class: middle, title-slide, hide-count

## Encoding High-Level Quantum Programs as SZX-Diagrams

.author[.underline[Agustín Borgna]¹², Rafael Romero³⁴]

.date[28th June 2022]

.affiliations[
¹ CNRS LORIA, Inria-MOCQUA, Université de Lorraine

² CNRS, LMF, Université Paris-Saclay

³ CONICET, Instituto de Ciencias de la Computación, Universidad de Buenos Aires

⁴ PEDECIBA, Universidad de la República-MEC
]

???

**[Intro]**

- Work with Rafael Romero.
- Compiling high-level quantum programs into an
  intermediate representation that can be used for optimization.
- Won't talk much about quantum computing,
  just describe it from an operational level.

**[Metadata]**

- 20 mins long
- Remove types slide
- add initialization boxes
- present ZX and SZX before the fragment (so we can give aSZX )

---

# Quantum programs and circuits

.padded[
- Proto-Quipper-D is a language for describing quantum programs

  ```haskell
  bell00 : ! (Unit -> Qubit * Qubit)
  bell00 u = 
      let x = Init0 ()
          y = Init0 ()
          x' = H x
      in CNot y x'
  ```

- Compiled down to circuits of gates
  .center[
  ![:img 40%](examples/bell.svg)
  ]

]

???
**[Quipper]**

- Chosen as starting language Proto-Quipper-D.
- Formalization of the well-known Quipper language
  with linear dependant types
- By Peter Selinger, with Francisco Rios and many other people
- Interpreter implemented by Peng Fu

**[Use]**

- We describe quantum computations
  as maps between lists of "qubit" elements by composing primitive operations. 
- Here, for example, we have a description of a program
  (in a Haskell-like syntax)
  that takes no input and produces a pair of qubits in a
  special state (called a Bell state).
- For this, the program initializes two new qubits,
  and then applies a series of predefined "quantum gates" to them.
- Important: Qubits are linear resources, this must type check.

**[Circuits]**

- To be able to run on an actual quantum computer,
  the quantum operations are commonly compiled to quantum circuits,
  represented similarly to digital electronic circuits.
- Qubits as wires, predefined set of gates.
- Initialization, Hadamard, CNOT, etc.

**[Cue generics]**
- What if instead of a pair we had a list of qubits?

---

# Dependent types for generic programming

.padded[

- Supports dependent types

  ```haskell
  cnotN : ! forall (n : Nat) -> (Vec n Qubit) * Qubit -> (Vec n Qubit) * Qubit
  cnotN (ctrls, q) = accumap (λ c q -> flip $ CNot q c) q ctrls
  ```

![:vspace .5em]

- Compilation requires instantiation (e.g. `n = 3`)
  .center[
  ![:img 30%](examples/lists.svg)
  ]

]

???
**[Dependent types]**

- Proto-Quipper-D supports dependent types.
- This means that we can have types that depends on values.
- For example, we can have a function that operates with vectors of qubits
  with a parametric size.

**[CNOTs]**
- Here we have a function that takes a list of n "control" qubits and a target,
  and applies the two-qubit CNOT operation once per element of the list.

**[Instantiation]**
- If we want to show this as a circuit,
  we must first instantiate the n parameter to a concrete value.
- Here we see that for `n=3` we produce the desired circuit,
  with list and extra qubit as inputs and the application of a 
  CNOT operation using each element of the list.

---

# The ZX calculus

.padded[
- Alternative representation of quantum circuits
  ![:vspace .5em]

  .center[
  ![:img 40%](examples/bell.svg)
  →
  ![:hspace 1em]
  ![:img 20%](img/tikz/bell-diag.svg)
  ![:hspace 6em]
  ]

  ![:vspace .5em]

- Only topology matters

<!-- - Corresponds to a compact closed category -->

- Formal rewrite system

- Useful for optimization, simulation, and more
]

???

**[ZX]**

- More granular representation of quantum circuits
- Undirected graphs with two-coloured nodes, and yellow generator
- Nodes may be tagged with a phase
- Can translate a quantum circuit directly (CNOT is now two nodes)
- Topology: It's a graph, so nodes and edges can be moved around
- Formally, it corresponds to a compact closed symmetric monoidal category
- Complete formal rewrite system lets us define formally proven optimization procedures

**[Limitations]**

- Edges carry the information of one qubit
- Still restricted to representing concrete circuits

---

# SZX Diagrams

.padded[
- Introduces multi-qubit wires (in bold) and gatherer/splitter nodes
  .center[
  ![:img 20%](img/tikz/gather.svg)
  ]

- Can encode parallel and iterative operations
  .center[
  `CnotN` → ![:img 40%](img/tikz/cnots-szx.svg)
  ]
]

???

**[SZX]**

- The Scalable extension of the ZX calculus (SZX) lifts this restriction,
  by allowing to represent quantum circuits with an arbitrary number qubit in a compact form
- Edges of the graph may carry the information of multiple qubits
- Tag wires in bold
- Introduces a gatherer/splitter node

**[Example]**

- Cnots takes a list of n qubits and a target
- Bold CNOT is n cnots in parallel
- Loops around, applying  target to each of them

---

# Quipper-D calculus

.padded[
- Specification à la lambda

  .font80.center[
  \\(
    \begin{aligned}
    \text{bell00} &: \text{Unit} \multimap \qubit * \qubit \\\\
    \text{bell00} &:=
    \lambda u^{\text{Unit}}. \mathsf{CNot}\ (\mathsf{Init0}\ \star)\ (\mathsf{H} (\mathsf{Init0}\ \star))
    \end{aligned}
  \\)
  ]

- We use a simplified fragment with bounded programs (no explicit recursion)

- Additional list-manipulation operations

- Types split between linear states and parameters

  .center.font80[
  Types \\(A := S \;|\; P \;|\; (n : \nat) \to A[n]\\)

  States \\(S := \text{Qubit} \;|\; \text{Bit} \;|\; \text{Unit} \;|\; S_1 \otimes S_2 \;|\; S_1 \multimap S_2 \;|\; \text{Vec } (n: \nat)\ S \\)

  Parameters \\(P := \nat \;|\; \text{Vec } (n: \nat)\ \nat \\)
  ]

]

???

**[Lambda]**

- Quipper programs can be represented as lambda terms.
- (Example: the bell00 program from before)
- We took a simplified fragment of it with only the relevant operations,
  and disallowing explicit recursion due to our target language.

**[Terms]**
- The simplified types are divided between states
  (lists and tuples of qubits) and parameters (numbers).
- Only Nats as parameters
- A quantum circuit is a map between states, and any parameter needs to have been instantiated before.
- States must be used linearly, we want no discarding nor cloning.

---

# Lambda terms as SZX-diagrams

.padded[
- Translate type judgements to families of diagrams
  .font90.center[

  \\(\Gamma, \Phi \vdash M : S \quad \\)
  →
  \\(|\Phi| \mapsto\\)
  ![:img 20%](img/tikz/judgement-trans.svg)
  ]

- State types translate to number of qubits

  .center.font90[
  \\(\trans{\mathsf{Qubit}} = 1\\)

  \\(\trans{\mathsf{Vec}\ n\ A} = \trans{A} \times n \\)

  \\(\trans{A \multimap B} = \trans{A \otimes B} = \trans{A} + \trans{B}\\)
  ]

- Parameters create generic diagrams
  .font90.center[

  \\(\Gamma, \Phi \vdash M : (n:\nat) \to S[n] \quad \\)
  →
  \\(\quad |\Phi|, n \mapsto\\)
  ![:img 25%](img/tikz/judgement-trans-param.svg)
  ]

]

???

**[Automatization]**

- From quipper, we have defined a translation into SZX
- Recursively on the derivation of the type judgements
- Separate state context and parameter context

**[Types]**

- Diagrams are compact closed, functions are equivalent to products

**[Notation]**

- I will ignore the translation brackets most of the time

---

# Translating λs

.padded[
- State operations are represented diagrammatically

![:vspace 1em]

.font70.center[

\\(
  \begin{prooftree}
    \AxiomC{$\Gamma, x:{S_1},\Phi \vdash M:{S_2}$}
  \RightLabel{ $\multimap_i$}
  \UnaryInfC{$\Gamma, \Phi \vdash \mathbf{\lambda x^{S_1} . M} : {S_2}$}
  \end{prooftree}
  \quad
\\)
→
\\(\quad |\Phi| \mapsto \\)
![:img 25%](img/tikz/translation-lambda.svg)

![:vspace 1em]

\\(
  \begin{prooftree}
    \AxiomC{$\Gamma,\Phi_1 \vdash M:{S_1} \multimap {S_2}$}
    \AxiomC{$\Delta,\Phi_2 \vdash N:{S_1}$}
  \RightLabel{ $\multimap_e$}
  \BinaryInfC{$\Gamma, \Delta, \Phi_1, \Phi_2 \vdash \mathbf{M\ N} : {S_2}$}
  \end{prooftree}
  \quad
\\)
→
\\(\quad |\Phi_1|, |\Phi_2| \mapsto \\)
![:img 25%](img/tikz/translation-apply.svg)

]

]

???

**[Lambda terms]**

- Lambda terms on states are translated as diagrams
- Diagrams are flexible, lambda is moving the variable to the context
- Application is connecting the appropriate wires

---

# Parameter-dependent translations


.padded[

- Instantiate families with lists of parameters

.font80.center[

![:vspace .5em]

\\(
  \begin{prooftree}
    \AxiomC{$n:\nat$}
    \AxiomC{$\Phi\vdash V: \text{Vec } n\ \nat$}
    \AxiomC{$k:\nat, \Phi, \Gamma\vdash M : A$}
  \RightLabel{ for}
  \TrinaryInfC{$\Phi, \Gamma^n \vdash \text{for } k\text{ in }V %
    \text{ do }M : \text{Vec }n\ A$
  }
  \end{prooftree}
  \quad
\\)
→
\\(\quad |\Phi| \mapsto \\)
![:img 20%](img/tikz/translation-for.svg)

]

![:vspace 1em]

- Parameter-dependent branching

.font80.center[

\\(
  \begin{prooftree}
    \AxiomC{$\Phi \vdash L:\nat$}
    \AxiomC{$\Phi,\Gamma\vdash M:A$}
    \AxiomC{$\Phi,\Gamma\vdash N:A$}
  \RightLabel{ $\to_i$}
  \TrinaryInfC{$\Phi, \Gamma \vdash \ifz{L}{M}{N} : A$}
  \end{prooftree}
  \quad
\\)
→
\\(\quad |\Phi| \mapsto \\)
![:img 30%](img/tikz/translation-ifz.svg)

![:vspace .5em]

.font80.align-right[

  with \\(l = \eval{L}(|\Phi|)\\)

]

]

]

???

**[Instantiation]**

When we instantiate the diagram family some of the wires end up having size
zero, depending on the value of the parameters.

---

# Example: Quantum Fourier transform for N qubits

.hpadded[

- Encoded as a lambda term
  
  .font70[
  
  \\(
  \definecolor{grey}{RGB}{200,200,200}
  \begin{aligned}
    \text{qft} &: (n:\nat) \to \vec{\ \qubit}{n}\multimap\vec{\qubit}{n} \\\\
    \cgrey{\text{qft}} & \cgrey{:= \lambda' n^\nat.\lambda qs^{\vec{\qubit}{n}}.
        \Qcompose} \\\\
        & \cgrey{(\Qfor{k}{\text{reverse\_vec } (0..n)}
        {\lambda qs'^{\vec{\qubit}{n}}.\text{apply\_crot } n\ k\ qs'})\ qs}
  \end{aligned}
  \\)
  
  \\(
  \begin{aligned}
    \text{apply\_crot}&: (n:\nat) \to (k:\nat) \to \vec{\qubit}{n} \multimap \vec{\qubit}{n} \\\\
    \cgrey{\text{apply\_crot}}& \cgrey{:= \lambda' n^\nat.\ \lambda' k^\nat.\ \lambda qs^{\vec{\qubit}{n}}.
    \ifz{n-k}{qs}{}}\\\\
    & \cgrey{\Qlet{h^{\vec{\qubit}{k}}\otimes qs'^{\vec{\qubit}{n-k}}}
    {\Qsplit\ k\ (n-k)\ qs}{}}\\\\
    & \cgrey{\Qlet{q^\qubit \otimes cs^{\vec{\qubit}{n-k-1}}}
    {\text{chop } qs'}{}}\\\\
    & \cgrey{\Qlet{fs^{\vec{(\qubit\otimes\qubit\multimap\qubit\otimes\qubit)}{(n-k-1)}}}
    {\Qfor{m^\nat}{2..(n-k+1)}{\text{crot }m}}{}}\\\\
    & \cgrey{\Qlet{cs'^{\vec{\qubit}{n-k-1}}\otimes q'} 
    {\Qaccumap\ fs\ (H\ q)\ cs}{}}\\\\
    & \cgrey{\text{concat } h\ (q':: cs')}
  \end{aligned}
  \\)
  
  \\(
  \begin{aligned}
    \text{crot}&: (n:\nat)\to (\qubit\otimes\qubit)\multimap (\qubit\otimes\qubit)\\\\
    \cgrey{\text{crot}}& \cgrey{:= \lambda' n^{\nat}.\lambda qs^{\qubit \otimes \qubit}.\ \Qlet{c^\qubit \otimes q^\qubit}{qs}{flip\ (R\ n\ q\ c)}}
  \end{aligned}
  \\)
  
  ]

- Compiled quantum circuit contains \\(\\mathcal{O}(n^2)\\) gates

]

???

**[Example]**

- Let's finish with a concrete example of a complex algorithm
- The exists a quantum version of the Fourier Transform for lists of qubits
- (do not look to deeply into this definition)
- Here we have shown that it can be encode it in the fragment of Proto-Quipper-D
- Normally a compilation into a quantum circuit requires a quadratic number of gates
- We can do a constant size encoding

- Let's go by parts

---

# Example: QFT translation

.padded[

- crot: ![:hspace 5.4em]() \\(n \mapsto\\) ![:img 35%](img/tikz/qft-crot.svg)

- apply_crot: ![:hspace 1.25em]() \\(n,k \mapsto\\) ![:img 70%](img/tikz/qft-applycrot.svg)

- qft: ![:hspace 5.75em]() \\(n \mapsto\\) ![:img 50%](img/tikz/qft-main.svg)

]

---
name: last
class: inverse, noheader

![:vspace 10em]()

.center.bold[
  Thanks!
]

---

# Extra: Translating the 'accumap' primitive


.padded.font80.center[

\\(
  \vdash \mathtt{accuMap}:
  (n:\nat) \to \text{Vec } A\ n
  \multimap \text{Vec } (A \multimap C \multimap B \otimes C)\ n
  \multimap C \multimap \text{Vec } B\ n \otimes C
  \quad
\\)
→

![:vspace 1em]()

\\(n \mapsto \\)
![:img 70%](img/tikz/translation-accumap.svg)

]

---

# Example: QFT translation (1)

.padded[

\\(
\begin{aligned}
  \text{crot}&: (n:\nat)\to (\qubit\otimes\qubit)\multimap (\qubit\otimes\qubit)\\\\
\end{aligned}
\\)

![:vspace 2em]()

.center[
  \\(n \mapsto \\)
  ![:img 50%](img/tikz/qft-crot.svg)
]

]

???

**[C-Rot]**

- First, the crot term takes a pair of qubits a rotation gate over them
- This is parametrized with an int for the rotation angle
- We have a straightforward translation of this into SZX
- Splitting the pair, applying the rotation, and bundling them again

---

# Example: QFT translation (2)

.padded[

\\(
\begin{aligned}
  \text{apply\_crot}&: (n:\nat) \to (k:\nat) \to \vec{\qubit}{n} \multimap \vec{\qubit}{n} \\\\
\end{aligned}
\\)

![:vspace 2em]()

.center[
  \\(n,k \mapsto \\)
  ![:img 80%](img/tikz/qft-applycrot.svg)
]

![:vspace 2em]()

.font70[*Omitting the ifz translation]

]

???

**[apply crot]**

- The apply_crot uses the previous term
- Does an operation similar to the CNOTs function we saw before on a portion of the list
- I don't show the check that n>k but it's just a bypass

---
# Example: QFT translation (3)

.padded[

\\(
\begin{aligned}
  \text{qft} &: (n:\nat) \to \vec{\ \qubit}{n}\multimap\vec{\qubit}{n} \\\\
\end{aligned}
\\)

![:vspace 2em]()

.center[
  \\(n \mapsto \\)
  ![:img 70%](img/tikz/qft-main.svg)
]

]

???

**[qft]**

- Finally, qft applies the previous term n times, varying the value of k
- If we compose these translations, we obtain a compact diagram
  that represents the QFT operation over any arbitrary number of qubits
- No need for quadratic number of gates, we have a constant size encoding
- In general, linear for the size of the program and independent of the parameters

