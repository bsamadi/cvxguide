# Second order cone program

A second order cone program (SOCP) is defined as:

$$\begin{align}
\text{minimize }& f^\text{T}x\nonumber\\
\text{subject to }&\|A_ix+b_i\|_2\leq c_i^\text{T}x+d_i,\
i=1,\ldots,m\nonumber\\
                  &Fx = g
\end{align}$$

Note that:

- If $c_i=0$ for $i=1,\ldots,m$, the SOCP is equivalent to a QP.
- If $A_i=0$ for $i=1,\ldots,m$, the SOCP is equivalent to a LP.

*Example (robust linear program):* Consider the following LP problem:

$$\begin{align}
\text{minimize }&c^\text{T}x\nonumber\\
\text{subject to }& a_i^\text{T}x \leq b_i,\ i=1,\ldots,m
\end{align}$$

where the parameters are assumed to be uncertain. For simplicity, let us assume
that $c$ and $b_i$ are known and $a_i$ are uncertain and belong to given
ellipsoids:

\begin{equation}
a_i \in \mathcal{E}_i = \{\bar a_i+P_iu|\ \|u\|_2\leq 1\}
\end{equation}

For each constraint $a_i^\text{T}x\leq b_i$, it is sufficient that the suprimum
value of $a_i^\text{T}x$ be less than or equal to $b_i$. The supremum value can
be written as:

$$\begin{align}
\sup\{a_i^\text{T}x|a_i\in\mathcal{E}_i \} =& \bar a_i^\text{T}x+\sup\{
u^\text{T}P_i^\text{T}x |\ \|u\|_2\leq 1\}\nonumber\\
&\bar a_i^\text{T}x+\|P_i^\text{T}x\|_2
\end{align}$$

Therefore, the robust LP problem can be written as the following SOCP problem:

$$\begin{align}
\text{minimize }&c^\text{T}x\nonumber\\
\text{subject to }& \bar a_i^\text{T}x+\|P_i^\text{T}x\|_2 \leq b_i,\
i=1,\ldots,m
\end{align}$$

*Example (stochastic linear program):* The same robust LP problem can be
addressed in a stochastic framework. In this framework, $a_i$ are assumed to be
independent normal random vectors with the distribution $\mathcal{N}(\bar a_i,
\Sigma_i)$. The requirement is that each constraint $a_i^\text{T}x\leq b_i$
should be satisfied with a probability more than $\eta$, where $\eta\geq 0.5$.

Assuming that $x$ is deterministic, $a_i^\text{T}x$ is a scalar normal random
variable with mean $\bar u=\bar a_i^\text{T}x$ and variance
$\sigma=x^\text{T}\Sigma_ix$. The probability of $a_i^\text{T}x$ being less than
$b_i$ is $\Phi((b_i-\bar u)/\sigma)$ where $\Phi(z)$ is the cumulative
distribution function of a zero mean unit variance Gaussian random variable:

\begin{equation}
\Phi(z)=\frac{1}{\sqrt{2\pi}}\int_{-\infty}^ze^{-t^2/2}dt
\end{equation}

Therefore, for the probability of $a_i^\text{T}x\leq b_i$ be larger than $\eta$,
we should have:

\begin{equation}
\Phi\left(\frac{b_i-\bar u}{\sigma}\right)\geq \eta
\end{equation}

This is equivalent to:

$$\begin{align}
\bar a_i^\text{T}x+\Phi^{-1}(\eta)\sigma\leq b_i \nonumber\\
\bar a_i^\text{T}x+\Phi^{-1}(\eta)\|\Sigma^{1/2}x\|_2 \leq b_i
\end{align}$$

Therefore, the stochastic LP problem:

$$\begin{align}
\text{minimize }&c^\text{T}x\nonumber\\
\text{subject to }& \text{prob} (a_i^\text{T}x \leq b_i)\geq \eta,\ i=1,\ldots,m
\end{align}$$

can be reformulated as the following SOCP:

$$\begin{align}
\text{minimize }&c^\text{T}x\nonumber\\
\text{subject to }& \bar a_i^\text{T}x+\Phi^{-1}(\eta)\|\Sigma^{1/2}x\|_2 \leq
b_i,\ i=1,\ldots,m
\end{align}$$

*Example:* Consider the equation $Ax=b$ where $x\in\mathbb{R}^n$,
$A\in\mathbb{R}^{m\times n}$ and $b\in\mathbb{R}^m$. It is assumed that $m>n$.
Let us consider the following optimization problem:

\begin{equation}
\text{minimize }\|Ax-b\|_2+\gamma\|x\|_1
\end{equation}

The objective function is a weighted sum of the 2-norm of equation error and the
1-norm of $x$. The optimization problem can be written as the following SOCP
problem:

$$\begin{align}
\text{minimize }& t\nonumber\\
                & \|Ax-b\|_2+\gamma \sum_{i=1}^n t_i\leq t\nonumber\\
                & -t_i \leq x_i \leq t_i, i=1,\ldots,n
\end{align}$$

As a numerical example, consider:

$$\begin{equation}
A = \bmat{cc} 1 & 1 \\ 2 & 1\\ 3 & 2 \emat,\ b=\bmat{c} 2\\ 3 \\ 4\emat,\ \gamma
= 0.5
\end{equation}$$

The optimization problem can be solved using the following code:


    x = cp.Variable(2)
    t = cp.Variable(1)
    t1 = cp.Variable(1)
    t2 = cp.Variable(1)
    gamma = 0.5
    
    A = co.matrix([[1,2,3],[1,1,2]])
    b = co.matrix([2, 3, 4],(3,1))
    objective = cp.Minimize(t)
    
    constraints = [cp.norm(A*x-b)+gamma*(t1+t2) <= t, -t1 <= x[0] <= t1, -t2 <= x[1] <= t2 ]
    
    p = cp.Problem(objective, constraints)

The optimal value of the objective function is:


    result=p.solve()
    print(result)

    1.36037960817
    

and the optimal solution is:


    print(x.value)

    [ 1.32e+00]
    [ 1.40e-01]
    
    

Thanks to cvxpy, the same problem can be solved using a much shorter code:


    p = cp.Problem(cp.Minimize(cp.norm(A*x-b)+gamma*cp.norm(x,1)), [])
    result=p.solve()
    print(x.value)

    [ 1.32e+00]
    [ 1.40e-01]
