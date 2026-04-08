# Prolog Sudoku Solver Master 🧩

![Version](https://img.shields.io/badge/version-v1.2.0-blue.svg)
![Status](https://img.shields.io/badge/status-Maintained-success.svg)
![Build](https://img.shields.io/badge/build-passing-brightgreen)

## Overview
A high-performance, deterministic logic-based Sudoku puzzle solver built entirely in Prolog. It automatically applies advanced puzzle computation rules dynamically to solve empty fields in linear time bounds based on constraint reductions without arbitrary brute force nesting.

### The Problem It Solves
Traditional brute-force backtracking solvers scale exponentially and provide zero insight into *why* a particular cell logically requires a specific value. This project solves that by algorithmically applying human-level Sudoku deductive strategies natively translated into high-performance declarative logic. 

## 🛠 Tech Stack
* **Language:** SWI-Prolog 🦉 
* **Paradigm:** Declarative & Recursive Logic Programming
* **Constraint Algorithms:** Advanced Heuristic Flow Reduction

## 🌟 Key Features
* **Multi-Tiered Algorithmic Inference:** Leverages specialized algorithms:
    * **Rule 0:** Singular Constraint Elimination.
    * **Rule 1:** Naked Single Reduction across rows, columns, and 3x3 blocks.
    * **Rule 2/3:** Advanced Naked/Hidden Pairs & Triplets pruning sequences.
* **Bi-directional Heuristic Flows:** Tests standard constraint resolution (R0->R3) alongside inverse processing flows (R3->R0) to achieve optimal path stabilization.
* **Automated Telemetry:** Comprehensive analytical toolset reporting on inference steps, cycle stabilization times, and puzzle tractability metrics.
* **ASCII Dashboard:** High contrast, auto-formatting CLI visual grids native to stdout.

## 📂 Project Architecture
```text
C:\SUDOKU
├── src/
│   ├── main.pl            # Engine, definitions, and application point
│   ├── rules.pl           # PlDoc documented solver logic heuristics
│   └── metrics.pl         # Data aggregation & flow evaluation rules
├── docs/                  
│   └── Informe.pdf        # Theoretical breakdown
├── .gitignore             # Environment standardization
└── README.md              # Repository core documentation
```

## 🚀 Setup Guide

### Installation
1. Install [SWI-Prolog](https://www.swi-prolog.org/download/stable) on your system.
2. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/prolog-sudoku-master.git
   cd prolog-sudoku-master
   ```

### Usage
Start your environment by running SWI-Prolog up against the main application module:
```bash
swipl -s src/main.pl
```
Query any puzzle using the embedded analytical functions, e.g., to run the default basic Sudoku and print its progression:
```prolog
?- solve(sudokuBasic1).
```
To run the automated test suite over all complexity tiers to output telemetry data:
```prolog
?- consult('src/metrics.pl').
?- testGlobalMetricsBasics.
```

## 🛣 Future Roadmap
1. **Dancing Links / Algorithm X:** Integrate a fallback heuristic engine employing Knuth's exact cover DLX matrix for entirely irresolvable edge-cases constraint loops.
2. **WebAssembly (WASM) Bridging:** Compile core engine parameters to `wasm32` to serve an interactive web frontend showcasing constraint inference reductions in real time.
3. **Automated Puzzle Generation:** Embed symmetry randomization filters allowing dynamic Sudoku creation depending on target backtracking depth thresholds.

## 👥 Contributors
Proudly engineered and architected by:
* **Andrea Pascual Aguilera**
* **Sergio Alonso Zarcero** 
* **Álvaro Eugenio Fernández**

---
*Tags:* `prolog`, `sudoku-solver`, `constraint-logic-programming`, `artificial-intelligence`, `heuristic-search`
