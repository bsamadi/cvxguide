# Semidefinite program

Generalized inequalities can be defined based on propoer cones. Till now we have
seen inequalities for real numbers and elementwise inequalities real vectors.
The former type of inequality is defined by the propoer cone of nonnegative real
numbers. The later type is defined by the proper cone of the nonnegative orthant
($\mathbb{R}^n_+$) in $\mathbb{R}^n$. One natural extension of the optimization
problems we have seen so far is to define the inequalities by the proper cone of
positive semidefinite matrices. For example, consider the following linear
optimization problem:
\begin{align}
\text{minimize}  & c^\text{T}x\nonumber\\
\text{subject to}& Fx+g\preccurlyeq_{\mathcal{S}^n_+} 0\nonumber\\
                 & Ax=b
\end{align}
where $\mathcal{S}^n_+$ is the cone of positive semidefinite matrices in
$\mathcal{R}^{n\times n}$. In other words, the first constraint of the above
optimization problem says that $Fx+g$ is positive semidefinite. This is an
extension of linear programming.

A semidefinite program (SDP) is defined as:
\begin{align}
\text{minimize}  & c^\text{T}x\nonumber\\
\text{subject to}& x_1F_1+x_2F_2+\cdots+x_nF_n+G \leq 0\nonumber\\
                 & Ax=b
\end{align}
where $x =\left[\begin{matrix}x_1&x_2&\cdots&x_n\end{matrix}\right]^\text{T}$ is
a vector in $\mathbb{R}^n$ and $F_i, i=1,\ldots,m$ and $G$ are symetric matrices
in $\mathcal{R}^{m\times m}$.

Note that the standard LP problem:
\begin{align}
\text{minimize}&c^\text{T}x\nonumber\\
               &Ax\preccurlyeq b
\end{align}
can be written as the following SDP problem:
\begin{align}
\text{minimize}&c^\text{T}x\nonumber\\
               &\text{diag}(Ax) \leq b
\end{align}
where $\text{diag}(v)$ for $v\in\mathbb{R}^n$ is a diagonal matrix in
$\mathbb{R}^{n\times n}$ with $v$ as the main diagonal.

Also the standard SOCP problem:
\begin{align}
\text{minimize}&c^\text{T}x\nonumber\\
               &\|A_ix+b_i\|_2 \leq c_i^\text{T}x+d_i,\ i=1,\ldots,m
\end{align}
can be written as the following SDP problem:
\begin{align}
\text{minimize}&c^\text{T}x\nonumber\\
               & \left[\begin{matrix} (c_i^\text{T}x+d_i)I & A_ix+b_i\\ A_ix+b_i
& c_i^\text{T}x+d_i\end{matrix}\right] \geq 0,\ i=1,\ldots,m
\end{align}

*Example (eigenvalue minimization):* Consider minimizing the maximum eigenvalue
of matrix $A(x)$:
\begin{align}
\text{minimize}& \lambda_\max(A(x))
\end{align}
where $A(x)=A_0+x_1A_1+\cdots+x_nA_n$ where $A_i$'s are symmetric matrices. This
problem can be written as the following SDP problem:
\begin{align}
\text{minimize}&t\nonumber\\
               & A(x)\leq tI
\end{align}
As a numerical example, consider:
\begin{equation}
A(x) = \left[\begin{matrix} x_3 & 0 & 0 & x_1+x_2-2\\ 0 & x_3 & 0 &
2x_1+x_2-3\\0 & 0 & x_3 & 3x_1+2x_2-4\\ x_1+x_2-2 & 2x_1+x_2-3 & 3x_1+2x_2-4 &
x_3 \end{matrix}\right]
\end{equation}
We would like to minimize the largest eigenvalue of $A$ subject to $A$ being a
positive semidefinite matrix. The following code solves this problem:


    x1 = cp.Variable()
    x2 = cp.Variable()
    x3 = cp.Variable()
    t = cp.Variable()
    X = cp.SDPVar(4)
    Y = cp.SDPVar(4)
    
    A0 = co.matrix([[0,0,0,-2],[0,0,0,-3],[0,0,0,-4],[-2,-3,-4,0]])
    A1 = co.matrix([[0,0,0,1],[0,0,0,2],[0,0,0,3],[1,2,3,0]])
    A2 = co.matrix([[0,0,0,1],[0,0,0,1],[0,0,0,2],[1,1,2,0]])
    A3 = co.matrix([[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]])
    I = co.matrix(np.identity(4))
    
    objective = cp.Minimize(t)
    
    Ax = A0+A1*x1+A2*x2+A3*x3
    constraints = [ Ax == X, t*I-Ax == Y ]
    p = cp.Problem(objective, constraints)

The optimal largest eigenvalue of $A(x)$ is equal to:


    result=p.solve()
    print(result)

    1.15470050608
    

The optimal solution for $x$ is:


    print([x1.value,x2.value,x3.value])

    [1.0000000000000004, 0.6666666666666659, 0.5773502530380881]
    

The value of $A(x)$ for the optimal solution is equal to:


    print(Ax.value)

    [ 5.77e-01  0.00e+00  0.00e+00 -3.33e-01]
    [ 0.00e+00  5.77e-01  0.00e+00 -3.33e-01]
    [ 0.00e+00  0.00e+00  5.77e-01  3.33e-01]
    [-3.33e-01 -3.33e-01  3.33e-01  5.77e-01]
    
    

In this case, eigenvalues of $A(x)$ are equal to:


    EigenValues = np.linalg.eig(Ax.value)[0]
    print(EigenValues)

    [ -1.61515377e-08   5.77350253e-01   1.15470052e+00   5.77350253e-01]
