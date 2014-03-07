## Convex Optimization: A Practical Guide

Behzad Samadi

[www.Mechatronics3D.com][]

February 17, 2014

$\DeclareMathOperator{\sign}{sgn} \newcommand{\CO}{\textbf{\rm conv}} \newcommand{\RR}{{\mathcal R}} \newcommand{\RE}{\mathbb{R}} \newcommand{\TR}{\text{T}} \newcommand{\beq}{\begin{equation}} \newcommand{\eeq}{\end{equation}} \newcommand{\bmat}{\left[\begin{array}} \newcommand{\emat}{\end{array}\right]} \newcommand{\bsmat}{\left[\begin{smallmatrix}} \newcommand{\esmat}{\end{smallmatrix}\right]} \newcommand{\barr}{\begin{array}} \newcommand{\earr}{\end{array}} \newcommand{\bsm}{\begin{smallmatrix}} \newcommand{\esm}{\end{smallmatrix}}$

## Outline

1.  Introduction

2.  Convex sets

3.  Convex functions

4.  Convex optimization

    -   Linear program

    -   Quadratic program

    -   Second order cone program

    -   Semidefinite program

5.  Applications

    -   Stability

    -   Dissipativity

## Disclaimer:

In this presentation, the definitions are taken from the [Convex
Optimization book by Stephen Boyd and Lieven Vandenberghe][] unless
otherwise stated. The reader is referred to the book for a detailed
review of the theory of convex optimization and applications.

# Introduction

## What is convex optimization?

$\begin{align} \text{minimize}&f(x)\nonumber \newline \text{subject to}& x\in C \end{align}$

where $f$ is a convex function and $C$ is a convex set.

## Why is it important?

-   Convex optimization problems:

    -   can be solved numerically with great efficiency

    -   have extensive useful theory

    -   occur often in engineering problems

    -   often go unrecognised

# Convex Sets

## Convex combination

Given $m$ points in $\RR^n$ denoted by $x_i$ for $i=1,\ldots,m$, $x$ is
convex combination of the $m$ points if it can be written as:

$\begin{equation} x = \sum_{i=1}^m \lambda_ix_i \end{equation}$

where $\lambda_i\geq 0$ and

$\begin{equation} \sum_{i=1}^m\lambda_i=1 \end{equation}$

## Convex Set

**Convex set:** A set $C\subseteq\RR^n$ is convex if the convex
combination of any two points in $C$ belongs to $C$.

**Convex hull:** The convex hull of a set $S$, denoted by
$\text{conv}(S)$, is the set of all convex combinations of points in
$S$.

## Affine Set

**Affine combination:** $x$ is an affine combination of $x_1$ and $x_2$
if it can be written as:

**Affine set:** A set $C\subseteq\RR^n$ is affine if the affine
combination of any two points in $C$ belongs to $C$.

## Convex Cone

**Cone (nonnegative) combination:** Cone combination of two points $x_1$
and $x_2$ is a point $x$ that can be written as:

with $\theta_1\geq 0$ and $\theta_2\geq 0$.

**Convex cone:** A set $S$ is a convex cone, if it contains all convex
combinations of points in the set.

## Polyhedron

**Hyperplane:** A hyperplane is a set of the form $\{x|a^\text{T}x=b\}$
with $a\neq 0$.

**Halfspace:** A halfspace is a set of the form
$\{x|a^\text{T}x\leq b\}$ with $a\neq 0$.

**Polyhedron:** A polyhedron is the intersection of finite number of
hyperplanes and halfspaces. A polyhedron can be written as:

where $\preceq$ denotes componentwise inequality.

## Ellipsoid

**Euclidean ball:** A ball with center $x_c$ and radius $r$ is defined
as:

$\begin{equation} B(x_c,r)=\{x| \|x-x_c\|_2\leq r\}=\{x| x=x_c+ru, \|u\|_2\leq r\} \end{equation}$

**Ellipsoid:** An ellipsoid is defined as:
$\begin{equation} \{x | (x-x_c)^\text{T}P^{-1}(x-x_c)\leq 1\} \end{equation}$
where $P$ is a positive definite matrix. It can also be defined as:
$\begin{equation} \{x| x=x_c+Au, \|u\|_2\leq r\} \end{equation}$

## Proper Cone

-   **Proper cone:** A cone is proper if it is:

    -   **closed** (contains its boundary)

    -   **solid** (has nonempty interior)

    -   **pointed** (contains no lines)

-   The nonnegative orthant of $\mathbb{R}^n$,
    $\{x|x\in\mathbb{R}^n,x_i\geq 0, i=1,\ldots,n \}$ is a proper cone.

-   Also the cone of positive semidefinite matrices in
    $\mathbb{R}^{n\times n}$ is a proper cone.

## Generalized Inequality

A **generalized inequality** is defined by a proper cone $K$:

$\begin{equation} x\preceq_K y \Leftrightarrow y-x\in K \end{equation}$ 

$\begin{equation} x\prec_K y \Leftrightarrow y-x\in \text{interior}(K) \end{equation}$

## Generalized Inequality

In this context, we deal with the following inequalities:

1.  The **inequality on real numbers** is defined based on the proper
    cone of nonnegative real numbers $K=\mathbb{R}_+$.

2.  The **componentwise inequality** on real vectors in $\mathbb{R}^n$
    is defined based on the nonnegative orthant $K=\mathbb{R}^n_+$.

3.  The **matrix inequality** is defined based on the proper cone of
    positive semidefinite matrices $K=S^n_+$.

# Convex Function

## Convex Function

**Definition:** A function $f:X_D \rightarrow X_R$ with
$X_D\subseteq\RR^n$ and $X_R\subseteq\RR$ is a convex function if for
any $x_1$ and $x_2$ in $X_D$ and $\lambda_1 \geq 0$, $\lambda_2 \geq 0$
such that $\lambda_1+\lambda_2=1$, we have:
$\begin{equation} f(\lambda_1x_1+\lambda_2x_2)\leq \lambda_1f(x_1)+\lambda_2f(x_2) \end{equation}$

# Convex Optimization

## Convex Optimization

A mathematical optimization is convex if the objective is a convex
function and the feasible set is a convex set. The standard form of a
convex optimization problem is:
$\begin{align} \text{minimize }   & f_0(x) \nonumber\newline \text{subject to } & f_i(x) \leq 0,\ i=1,\ldots,m\nonumber\newline                    & h_i(x) = 0,\ i=1,\ldots,p \end{align}$

where $f_i$'s are convex and $h_i$'s are affine functions.

## Linear Program

Linear programming (LP) is one of the best known forms of convex
optimization.

$\begin{align}\label{LP} \text{minimize }&c^\text{T}x\nonumber\newline \text{subject to }&a_i^\text{T}x\leq b_i,\ i=1,\ldots,m \end{align}$

where $x$, $c$ and $a_i$ for $i=1,\ldots,m$ belong to $\mathbb{R}^n$.

## Linear Program

-   In general, no analytical solution

-   Numerical algorithms

-   Early algorithm, the one developed by Kantorovich in 1940
    [@Kantorovich40]\

-   The simplex method proposed by George Dantzig in 1947 [@Dantzig91]

-   The Russian mathematician L. G. Khachian developed a polynomial-time
    algorithm in 1979 [@Khachian79]

-   The algorithm was an interior method, which was later improved by
    Karmarkar in 1984 [@Karmarkar84]

## Mixed Integer Linear Program

-   If some of the entries of $x$ are required to be integers, we have a
    Mixed Integer Linear Programming (MILP) program.

-   A MILP problem is in general difficult to solve (non-convex and
    NP-complete).

-   In practice, the global optimum can be found for many useful MILP
    problems.

## Linear Program

### Example I

$\begin{align}  \text{maximize: }   & x + y\nonumber\\  \text{Subject to: } & x + y \geq -1 \\  \text{}             & \frac{x}{2}-y \geq -2\nonumber\\  \text{}             & 2x-y  \leq -4\nonumber \end{align}$

## Linear Program

### Example I

        import numpy as np
        from pylab import *
        import matplotlib as mpl
        import cvxopt as co
        import cvxpy as cp

        x = cp.Variable(1)
        y = cp.Variable(1)

        constraints = [     x+y >= -1.,
                        0.5*x-y >= -2.,
                          2.*x-y <= 4.]

        objective = cp.Maximize(x+y)
        p = cp.Problem(objective, constraints)

## Linear Program

### Example I

The solution of the LP problem is computed with the following command:

        result = p.solve()
        print(round(result,5))
        8.0

The optimal solution is now given by:

        x_star = x.value
        print(round(x_star,5))
        4.0
        
        y_star = y.value
        print(round(y_star,5))
        4.0

## Linear Program

### Example II

$\begin{align}  \text{minimize: }   & x + y\nonumber\\  \text{Subject to: } & x + y \geq -1 \\  \text{}             & \frac{x}{2}-y \leq -2\nonumber\\  \text{}             & 2x-y  \leq -4\nonumber \end{align}$

## Linear Program

### Example II

        objective = cp.Minimize(x+y)
        p = cp.Problem(objective, constraints)

        result = p.solve()
        print(round(result,5))
        -1.0

## Linear Program

### Example II

The optimal solution is now given by:

        x_star = x.value
        print(round(x_star,5))
        0.49742

        y_star = y.value
        print(round(y_star,5))
        -1.49742

## Linear Program

### Example II

-   The optimal value of the objective function is unique.

-   Any point on the line connecting the two points (-2,1) and (1,-2) is
    the optimal solution.

-   This LP problem has infinite optimal solutions.

-   The code, however, returns just one of the optimal solutions.

## Linear Program

### Example III: Chebyshev Center

Consider the following polyhedron:

$\begin{equation} \mathcal{P} = \{x | a_i^Tx \leq b_i, i=1,...,m \} \end{equation}$

The Chebyshev center of $\mathcal{P}$ is the center of the largest ball
in $\mathcal{P}$:

$\begin{equation} \mathcal{B}=\{x|\|x-x_c\|\leq r\} \end{equation}$

## Linear Program

### Example III: Chebyshev Center

-   For $\mathcal{B}$ to be inside $\mathcal{P}$, we need to have:

    $a_i^Tx\leq b_i,\ i=1,\ldots,m$ for all $x$ in $\mathcal{B}$

-   For each $i$, the point with the largest value of $a_i^Tx$ is:
    $x^\star=x_c+\frac{r}{\sqrt{a_i^Ta_i}}a_i=x_c+\frac{r}{\|a_i\|_2}a_i$

-   Therefore:

    $a_i^Tx_c+r\|a_i\|_2\leq b_i, i=1,..,m\ \Rightarrow \mathcal{B}$ is
    inside $\mathcal{P}$

## Linear Program

### Example III: Chebyshev Center

Now, we can write the problem as the following LP problem (LP3):

$\begin{align}  \text{maximize: }   & r\nonumber\\  \text{Subject to: } & a_i^Tx_c + r\|a_i\|_2 \leq b_i,\ i=1,..,m \end{align}$

## References

  [www.Mechatronics3D.com]: http://www.mechatronics3d.com
  [Convex Optimization book by Stephen Boyd and Lieven Vandenberghe]: http://www.stanford.edu/~boyd/cvxbook/
  []: cvxguide_files/cvxguide_31_0.png
