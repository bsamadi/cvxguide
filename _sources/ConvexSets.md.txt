# Convex Sets

*Definition. Convex combination:* Given $m$ points in $\RR^n$ denoted by $x_i$
for $i=1,\ldots,m$, $x$ is a convex combination of the $m$ points if it can be
written as:
\begin{equation}
x = \sum_{i=1}^m \lambda_ix_i
\end{equation}
where $\lambda_i\geq 0$ and
\begin{equation}
\sum_{i=1}^m\lambda_i=1
\end{equation}

*Definition. Convex set:* A set $C\subseteq\RR^n$ is convex if the convex
combination of any two points in $C$ belongs to $C$.

*Definition. Convex hull:* The convex hull of a set $S$, denoted by
$\text{conv}(S)$, is the set of all convex combinations of points in $S$.

*Definition. Affine combination:* $x$ is an affine combination of $x_1$ and
$x_2$ if it can be written as:
\begin{equation}
x=\lambda_1x_1+\lambda_2x_2
\end{equation}

*Definition. Affine set:* A set $C\subseteq\RR^n$ is affine if the affine
combination of any two points in $C$ belongs to $C$.

*Definition. Cone (nonnegative) combination:* Cone combination of two points
$x_1$ and $x_2$ is a point $x$ that can be written as:
\begin{equation}
x=\theta_1x_1+\theta_2x_2
\end{equation}
with $\theta_1\geq 0$ and $\theta_2\geq 0$.

*Definition. Convex cone:* A set $S$ is a convex cone, if it contains all convex
combinations of points in the set.

*Definition. Hyperplane:* A hyperplane is a set of the form
$\{x|a^\text{T}x=b\}$ with $a\neq 0$.

*Definition. Halfspace:* A halfspace is a set of the form $\{x|a^\text{T}x\leq
b\}$ with $a\neq 0$.

*Definition. Polyhedron:* A polyhedron is the intersection of finite number of
hyperplanes and halfspaces. A polyhedron can be written as:
\begin{equation}
\mathcal{P}=\{x| Ax \preceq b, Cx=d \}
\end{equation}
where $\preceq$ denotes componentwise inequality.

*Definition. Euclidean ball:* A ball with center $x_c$ and radius $r$ is defined
as:
\begin{equation}
B(x_c,r)=\{x| \|x-x_c\|_2\leq r\}=\{x| x=x_c+ru, \|u\|_2\leq r\}
\end{equation}

*Definition. Ellipsoid:* An ellipsoid is defined as:
\begin{equation}
\{x | (x-x_c)^\text{T}P^{-1}(x-x_c)\leq 1\}
\end{equation}
where $P$ is a positive definite matrix. It can also be defined as:
\begin{equation}
\{x| x=x_c+Au, \|u\|_2\leq r\}
\end{equation}

# Generalized inequalities

*Definition. Proper code:* A cone is proper if it is closed (contains its
boundary), solid (has nonempty interior) and pointed (contains no lines).

The nonnegative orthant of $\mathbb{R}^n$, $\{x|x\in\mathbb{R}^n,x_i\geq 0,
i=1,\ldots,n \}$ is a proper cone. Also the cone of positive semidefinite
matrices in $\mathbb{R}^{n\times n}$ is a proper cone.

*Definition. Generalized inequality:* A generalized inequality is defined by a
proper cone $K$:
\begin{equation}
x\preceq_K y \Leftrightarrow y-x\in K
\end{equation}
\begin{equation}
x\prec_K y \Leftrightarrow y-x\in \text{interior}(K)
\end{equation}

In this context, we deal with the following inequalities:

- The inequality on real numbers is defined based on the proper cone of
nonnegative real numbers $K=\mathbb{R}_+$.
- The componentwise inequality on real vectors in $\mathbb{R}^n$ is defined
based on the nonnegative orthant $K=\mathbb{R}^n_+$.
- The matrix inequality is defined based on the proper cone of positive
semidefinite matrices $K=S^n_+$.
