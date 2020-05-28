# Applications in Control Theory

Many problems in control theory can be formulated as convex optimization
problems. It is beyond the scope of this text to cover all of them. However, in
the following, you will see an introduction about applications of convex
optimization in control theory.

### Stability

Consider the following autonomous system:

\begin{equation}
\dot x = f(x),\ x(0)=x_0
\end{equation}

with $x\in\mathbb{R}^n$ and $t\geq 0$. A solution of this system with initial
condition $x(0)=x_0$ is denoted by $\phi(t,x_0)$.

$x^\star$ is an equilibrium point of this system if:

\begin{equation}
\forall t \geq 0, \phi(t,x^\star)=x^\star
\end{equation}

*Definition [2]:* An equilibrium point $x^\star$ is:

- *stable* (in the sense of Lyapunov) if for any given $\epsilon>0$,    there
exists $\delta(\epsilon)>0$ such that:
 \begin{equation}
  \|x_0-x^\star\|\leq \delta \Rightarrow \lim_{t\rightarrow
\infty}\|\phi(t,x_0)-x^\star\|=0
  \end{equation}
- *attractive* if there exists $\delta>0$ such that:
  \begin{equation}
  \|x_0-x^\star\|\leq\delta \Rightarrow \lim_{t\rightarrow
\infty}\|\phi(t,x_0)-x^\star\|=0
  \end{equation}
- *asymptotically stable* (in the sense of Lyapunov) if it is both stable and
attractive.

*Theorem [3]:* If there exists a continuous function $V(x)$ defined in a forward
invariant set $\mathcal{X}$ of the autonomous system (*) such that:

$$\begin{align}
V(x^\star)=0,\nonumber\\
V(x) > 0,\ \forall x\in\mathcal{X} \text{ such that } x\neq x^\star\nonumber\\
t_1\leq t_2\Rightarrow V(\phi(t_1,x_0)) \geq V(\phi(t_2,x_0))
\end{align}$$

then $x^\star$ is a stable equilibrium point. Moreover if there exists a
continuous function $Q(x)$ such that:

$$\begin{align}
&Q(x^\star)=0,&\nonumber\\
&Q(x)>0,\ \forall x\in\mathcal{X} \text{ such that } x\neq x^\star&\nonumber\\
&t_1\leq t_2\Rightarrow V(\phi(t_1,x_0)) \geq V(\phi(t_2,x_0))+\int_{t_1}^{t_2}
Q(\phi(\tau,x_0))d\tau&\nonumber\\
&\|x\|\rightarrow\infty \Rightarrow V(x)\rightarrow\infty&
\end{align}$$

then $x^\star$ is an asymptotically stable equilibrium point.

#### Linear Systems

Consider the linear system:

\begin{equation}
\dot x=Ax, x(0)=x_0
\end{equation}

where $x\in\mathbb{R}^n$. The only equilibrium point of this system is
$x^\star=0$. Consider the following candidate Lyapunov function:

\begin{equation}
V(x)=x^\text{T}Px
\end{equation}

where $P\in\mathbb{n\times n}$ is a positive definite matrix and therefore
$V(x)>0$ for $x\neq 0$. The linear system () is stable if there exists a $P$:

\begin{equation}
\dot V(x) = (Ax)^\text{T}Px+x^\text{T}PAx < 0
\end{equation}

In case of linear systems, the existence of a Lyapunov function is a necessary
and sufficient condition for stability. The Lyapunov conditions can be written
as the following linear matrix inequalities:

$$\begin{align}
P>0\nonumber\\
A^\text{T}P+PA<0
\end{align}$$

*Example:* Consider a linear system with:

$$\begin{equation}
A=\left[\begin{matrix}0&1\\-1&-2\end{matrix}\right]
\end{equation}$$

The eigenvalues of $A$ are negative:


    A = np.matrix('0 1; -1 -2')
    np.linalg.eig(A)[0]




    array([-1., -1.])



Therefore, the system is stable. In the following, we now verify the stability
of the system by solving the following LMIs:


    A = cp.Parameter(2,2)
    P = cp.SDPVar(2)
    
    objective = cp.Minimize( 0 )
    prob = cp.Problem(objective, [A.T*P+P*A == -cp.SDPVar(2,2), P == cp.SDPVar(2,2)])
    A.value = co.matrix(np.matrix('0 1; -1 -2'))
    prob.solve()




    0.0



where SDPVar(n,n) is an auxiliary positive semi-definite matrix. Since the
stability LMIs are a feasibility problem as opposed to an optimization problem,
we have set the objective function to be a constant value. The optimal solution
of the above LMIs is:


    print(P.value)

    [ 0.00e+00  0.00e+00]
    [ 0.00e+00  0.00e+00]
    
    

However, this is the trivial answer of these LMIs:

$$\begin{align}
P\geq 0\nonumber\\
A^\text{T}P+PA\leq 0
\end{align}$$

In order to find a feasible answer for strict inequalities using non-strict
inequalities, we can rewrite the inequalities as:

$$\begin{align}
P-\epsilon I\geq 0\nonumber\\
A^\text{T}P+PA+\alpha P\leq 0
\end{align}$$

Let us now solve the following LMIs to find a valid Lyapunov function for the
linear system:


    I = np.identity(2)
    
    prob = cp.Problem(objective, [A.T*P+P*A+0.5*P == -cp.SDPVar(2,2), P - 0.1*I == cp.SDPVar(2,2)])
    prob.solve()




    0.0




    print(P.value)

    [ 1.13e+00  1.88e+00]
    [ 4.93e-02  9.40e-01]
    
    

It is also possible to add an objective function to the LMIs, for example
$\lambda_{max}(P)$, the largest eigenvalue of $P$, to have a better conditioned
$P$ in the solution:


    objective = cp.Minimize( cp.lambda_max(P) )
    prob = cp.Problem(objective, [A.T*P+P*A+0.5*P == -cp.SDPVar(2,2), P - 0.1*I == cp.SDPVar(2,2)])
    prob.solve()




    0.1777777617758615



The optimal solution is now equal to:


    print(P.value)

    [ 1.39e-01  3.89e-02]
    [ 3.89e-02  1.39e-01]
    
    

We can verify the inequalities by computing the eigenvalues:


    np.linalg.eig(P.value)[0]




    array([ 0.17777777,  0.1       ])




    np.linalg.eig( (A.T*P+P*A).value )[0]




    array([-0.06318906, -0.4923496 ])



#### Uncertain Linear Systems

Consider the following linear system:

\begin{equation}
\dot x=A(\alpha)x, x(0)=x_0
\end{equation}

where $A\in\mathbb{R}^{n\times n}$ is an uncertain matrix such that:

\begin{equation}
A(\alpha)=\sum_{i=1}^L \alpha_i A_i
\end{equation}

where $A_i$ for $i=1,\ldots,L$ are known matrices and $\alpha_i$ for
$i=1,\ldots,L$ are unknown scalars such that:

\begin{equation}
\sum_\alpha_{i=1}^L \alpha_i=1
\end{equation}

This system can also be written as a linear differential inclusion:

\begin{equation}
\dot x\in Ax
\end{equation}

where $A\in\text{conv}(\{A_1,\ldots,A_L\})$
Using the Lyapunov theorem, it can be shown that the uncertain linear system is
asymptotically stable if there exists a $P$ such that:

$$\begin{align}
P &> 0\nonumber\\
A_i^\text{T}P+PA_i &< 0, i=1,\ldots,L
\end{align}$$

Note that this condition is stronger than saying all the $A_i$'s have to be
stable. In addition to that, it is required that all the $A_i$'s share the same
$P$.

*Example:* Consider the uncertain linear system () with $L=2$ and:

\begin{equation}
A_1=\left[\begin{matrix}1&-2\\2&-2\end{matrix}\right],\
A_2=\left[\begin{matrix}1&2\\-2&-2\end{matrix}\right]
\end{equation}

The eigenvalues of $A_1$ and $A_2$ are on the left side of the complex plane and
even equal:


    A1 = np.matrix('1 -2; 2 -2')
    np.linalg.eig(A1)[0]




    array([-0.5+1.32287566j, -0.5-1.32287566j])




    A2 = np.matrix('1 2; -2 -2')
    np.linalg.eig(A2)[0]




    array([-0.5+1.32287566j, -0.5-1.32287566j])



However, an uncertain linear system with $A$ in the convex hull of $A_1$ and
$A_2$ is not stable. For example $A=0.5A_1+0.5A_2$ is not stable:


    np.linalg.eig(0.5*A1+0.5*A2)[0]




    array([ 1., -2.])



That is a proof for the following LMIs to be infeasible:


    A1 = cp.Parameter(2,2)
    A2 = cp.Parameter(2,2)
    P = cp.SDPVar(2)
    I = np.identity(2)
    
    objective = cp.Minimize( cp.lambda_max(P) )
    prob = cp.Problem(objective, [P - 0.1*I == cp.SDPVar(2,2), A1.T*P+P*A1+0.5*P == -cp.SDPVar(2,2), A2.T*P+P*A2+0.5*P == -cp.SDPVar(2,2)])
    A1.value = co.matrix(np.matrix('1 -2; 2 -2'))
    A2.value = co.matrix(np.matrix('1 2; -2 -2'))
    prob.solve()




    'infeasible'



#### State Feedback Controller

Consider the following linear system:

\begin{equation}
\dot x=Ax+Bu
\end{equation}

where $x\in\mathbb{R}^n$ and $u\in\mathbb{R}^m$ denote the state and input
vectors. The objective is to design a state feedback of the form:

\begin{equation}
u = Kx
\end{equation}

to stabilize the closed loop system:

\begin{equation}
\dot x = (A+BK)x
\end{equation}

This system is stable if there exists a $P$ such that:

$$\begin{align}
{\color{red}P}>0\nonumber\\
(A+B{\color{red}K})^\text{T}{\color{red}P}+{\color{red}P}(A+B{\color{red}K}) < 0
\end{align}$$

The unknown matrices in these inequalities are shown in red. As you see, this is
not a LMI but it is a bilinear matrix inequality (BMI). BMI's are hard to solve
in general. However, there is a trick for this special BMI to convert it to an
LMI.

We know that the eigenvalues of a matrix and its transpose are the same.
Therefore, the closed loop system () is stable if and only if its dual system is
stable:

\begin{equation}
\dot x = (A+BK)x
\end{equation}

Now, let us write the stability inequalities for the dual system:

$$\begin{align}
{\color{red}Q}>0\nonumber\\
(A+B{\color{red}K}){\color{red}Q}+{\color{red}Q}(A+B{\color{red}K})^\text{T} < 0
\end{align}$$

This is still a BMI. However, if we define $Y=KQ$, we can write the inequalities
as:

$$\begin{align}
{\color{red}Q}>0\nonumber\\
A{\color{red}Q}+{\color{red}Q}A^\text{T}+B{\color{red}Y}+{\color{red}Y}^\text{T}
B^\text{T} < 0
\end{align}$$

Now, this is a LMI. After solving the LMI, if it is feasible, the controller
gain $K$ can be computed as:

\begin{equation}
K = YQ^{-1}
\end{equation}

Another way of converting () to a LMI is to multiply both sides of both
inequalities by $Q=P^{-1}$ and perform the same trick.

*Example:* Consider the following linear system:

\begin{equation}
\dot x = \left[\begin{matrix}1&0.1\\0&-2\end{matrix}\right]x+\left[\begin{matrix
}0\\1\end{matrix}\right]u
\end{equation}

The objective is to find $K$ such that with $u=Kx$ the closed loop system is
stable.


    A = cp.Parameter(2,2)
    B = cp.Parameter(2,1)
    Q = cp.SDPVar(2)
    Y = cp.Variable(1,2)
    I = np.identity(2)
    
    objective = cp.Minimize( cp.lambda_max(Q) )
    prob = cp.Problem(objective, [Q - 0.1*I == cp.SDPVar(2,2), A*Q+Q*A.T+B*Y+Y.T*B.T+0.5*Q == -cp.SDPVar(2,2)])
    A.value = co.matrix(np.matrix('1 0.1; 0 -2'))
    B.value = co.matrix(np.matrix('0; 1'))
    prob.solve()




    62.699830858476346



The controller gain can now be computed as:


    K = np.dot(Y.value,np.linalg.inv(Q.value))
    print(K)

    [[-54.46273825  -1.34901911]]
    

The closed loop system is stable:


    Acl = (A.value+B.value*K)
    np.linalg.eig(Acl)[0]




    array([-1.17450955+0.84722018j, -1.17450955-0.84722018j])



### Dissipativity

Similar to stability for autonomous systems, there is a concept called
dissipativity for dynamic systems with input. Consider the following dynamical
system:

$$\begin{align}
\dot x=&f(x,w)\nonumber\\
z=&g(x,w)
\end{align}$$

where $x\in\mathbb{R}^n$ is the state, $u\in\mathbb{R}^m$ is the input and
$z\in\mathbb{R}^p$ is the output vector.

*Definition:* The system () is said to be dissipative with storage function $V$
and supply rate $W$, if:

\begin{equation}
t_1\leq t_2\Rightarrow V(x(t_1))+\int_{t_1}^{t_2}W(z(\tau),w(\tau))d\tau\geq
V(x(t_2))
\end{equation}

If the storage function and the trajectory of the system are smooth, this
inequality can be written as:

\begin{equation}
\nabla_x V(x).\dot x\leq W(z,w)
\end{equation}

Now, consider the following linear system:

$$\begin{align}
\dot x=&Ax+Bw\nonumber\\
z=&Cx+Dw
\end{align}$$

with $x(0)=0$. It assumed that all the eigenvalues of $A$ have negative real
values. In the followin, we will review a few special cases of dissipativity.

#### QSR Dissipativity

The following statements are equivalent:

- The system is strictly dissipative with the supply rate:
  \begin{equation}
  s(w,z)=\left[\begin{matrix} w\\\\z\end{matrix}\right]^\text{T}
\left[\begin{matrix} Q&S\\\\S^\text{T}& R\end{matrix}\right]
\left[\begin{matrix} w\\\\z \end{matrix}\right]
  \end{equation}
- For all $\omega\in\mathbb{R}\cup\{\infty\}$ there holds:
  \begin{equation}
  \left[\begin{matrix} I\\\\T(j\omega)\end{matrix}\right]^\star
\left[\begin{matrix} Q& S\\\\S^\text{T}&R\end{matrix}\right]\left[\begin{matrix}
I\\\\ T(j\omega)\end{matrix}\right] \gt 0
  \end{equation}
- There exists $P>0$ satisfying the LMI:
  \begin{equation}
  \left[\begin{matrix} A^\TR P+PA & PB\\\\B^\TR P & 0
\end{matrix}\right]-\left[\begin{matrix} 0&I\\\\C&D\end{matrix}\right]^\text{T}
\left[\begin{matrix} Q& S\\\\S^\text{T}&R\end{matrix}\right]\left[\begin{matrix}
0&I\\\\ C&D\end{matrix}\right] \lt 0
  \end{equation}

#### Passivity

The following statements are equivalent:

- System () is strictly dissipative with the supply rate:
  \begin{equation}
  s(w,z)= w^\text{T} z+z^\text{T} w=2w^\text{T} z
  \end{equation}
- For all $\omega\in\mathbb{R}$ with $\det(j\omega I-A)\neq 0$, there holds:
  \begin{equation}
  T(j\omega)^\star+T(j\omega)>0
  \end{equation}
- There exists $P>0$ satisfying the LMI:
  \begin{equation}
  \left[\begin{matrix} A^\text{T} P+PA & PB-C^\text{T}\\\\B^\text{T} P-C &
D+D^\text{T} \end{matrix}\right] < 0
  \end{equation}
- If $D=0$, there exists $P>0$ satisfying:
  $$\begin{align}
  A^\text{T}P+PA<0\nonumber\\
  PB=C^\text{T}
  \end{align}$$
- System () is RLC realizable, i.e. there exists an RLC network with transfer
function $T(j\omega)$.
- For SISO systems:
  \begin{equation}
  |\angle G(j\omega)| < 90^\circ, \text{Re}(G(j\omega))>0
  \end{equation}
- Gain margin of system () is infinite.

One of the properties of passive systems is that the feedback connection of two
passive systems is always stable (the loop phase is less than 180 degrees).

#### $\mathcal{H}_\infty$ Gain (Bounded $L_2\rightarrow$ Bounded $L_2$)

The following statements are equivalent:

- The system is strictly dissipative with the supply rate:
  \begin{equation}
  s(w,z)=\gamma^2 w^\text{T} w-z^\text{T} z
  \end{equation}
- For all $\omega\in\mathbb{R}$:
  \begin{equation}
  \|T(j\omega)\|_\infty=\sup_{0<\|w\|_2<\infty}\frac{\|z\|_2}{\|w\|_2} \lt
\gamma
  \end{equation}
- There exists $P>0$ satisfying the LMI:
  \begin{equation}
  \left[\begin{matrix} A^\text{T} P+PA+C^\text{T} C & PB+C^\text{T}
D\\\\B^\text{T} P+D^\text{T} C & D^\text{T} D-\gamma^2 I \end{matrix}\right]< 0
  \end{equation}
- There exists $P>0$ satisfying the LMI:
  \begin{equation}
  \left[\begin{matrix} A^\text{T} P+PA & PB & C^\text{T}\\B^\text{T} P  &
-\gamma^2 I & D^\text{T}\\C&D&-I \end{matrix}\right]< 0
  \end{equation}

#### $\mathcal{H}_\infty$ State Feedback Controller

Consider the following linear system:

$$\begin{align}
\dot x=&Ax+B_ww+B_uu\nonumber\\
z =&C_zx+D_ww+D_uu
\end{align}$$

where $u$ is the control input. We would like to design a controller of the form
$u=Kx$ such that for the closed loop system:
\begin{equation}
\sup_{\|w\|_2\neq 0}\frac{\|z\|_2}{\|w\|_2}<\gamma
\end{equation}

The design problem can be formulated as the following matrix inequality:

\begin{equation}
Q>0
\end{equation}
\begin{equation}
\left[\begin{matrix} AQ+Qa^\text{T}+B_uY+Y^\text{T}B_u^\text{T}+B_wB_w^\text{T}
&
(C_zQ+D_{zu}Y+D_wB_w^\text{T})^\text{T}\\C_zQ+D_uY+D_wB_w^\text{T} & D_w
D_w^\text{T}-\gamma^2 I \end{matrix}\right]< 0
\end{equation}
where $K=YQ^{-1}$

**Proof:** It can easily be shown that the $\mathcal{H}_\infty$ norm of  the
system is less than $\gamma$ if it is dissipative with the following supply
rate:

\begin{equation}
s(w,z)=w^\text{T} w-\frac{1}{\gamma^2}z^\text{T} z
\end{equation}

Using this supply rate, the LMI's can be written as:

\begin{equation}
P>0
\end{equation}

\begin{equation}
\left[\begin{matrix} A^\text{T} P+PA & PB & C^\text{T}\\B^\text{T} P  & - I &
D^\text{T}\\C&D&-\gamma^2I \end{matrix}\right]< 0
\end{equation}

Now, if we write the same LMI for the closed loop system, we have:

\begin{equation}
P>0
\end{equation}
\begin{equation}
\left[\begin{matrix} (A+B_u{\color{red} K})^\text{T} {\color{red}
P}+{\color{red} P}(A+B_u{\color{red} K}) & {\color{red} P}B_w &
(C+D_u{\color{red} K})^\text{T}\\B_w^\text{T} {\color{red} P}  & - I &
D_w^\text{T}\\C+D_u{\color{red} K}&D_w&-\gamma^2I \end{matrix}\right]< 0
\end{equation}

Again, this is a BMI. To formulate the problem as a LMI, let multiply both sides
of the inequality by:

\begin{equation}
\left[\begin{matrix}Q & 0& 0\\0&I&0\\0&0& I\end{matrix}\right]
\end{equation}

where $Q=P^{-1}$. The result is:

\begin{equation}
\left[\begin{matrix} {\color{red} Q}(A+B_u{\color{red} K})^\text{T}
+(A+B_u{\color{red} K}){\color{red} Q} & B_w & {\color{red} Q}(C+D_u{\color{red}
K})^\text{T}\\B_w^\text{T}  & - I & D_w^\text{T}\\(C+D_u{\color{red}
K}){\color{red} Q}&D_w&-\gamma^2I \end{matrix}\right]< 0
\end{equation}

Now, if we define $Y=KQ$, we have the following LMI:
\begin{equation}
\left[\begin{matrix} {\color{red} Q}A^\text{T} +A{\color{red}
Q}+Y^\text{T}B_u^\text{T}+B_u{\color{red} Y} & B_w & {\color{red}
Q}C^\text{T}+{\color{red} Y}^\text{T}D_u^\text{T}\\B_w^\text{T}  & - I &
D_w^\text{T}\\C{\color{red} Q}+D_u{\color{red} Y}&D_w&-\gamma^2I
\end{matrix}\right]< 0
\end{equation}
This LMI can be rearranged as:
\begin{equation}
\left[\begin{matrix} A{\color{red} Q}+{\color{red} Q}A^\text{T} +B_u{\color{red}
Y}+Y^\text{T}B_u^\text{T} & {\color{red} Q}C^\text{T}+{\color{red}
Y}^\text{T}D_u^\text{T} & B_w \\C{\color{red} Q}+D_u{\color{red}
Y}&-\gamma^2I&D_w\\B_w^\text{T} & D_w^\text{T} & - I \end{matrix}\right]< 0
\end{equation}
Using the Schur complement, we can now write the LMI as:
\begin{equation}
\left[\begin{matrix} A{\color{red} Q}+{\color{red} Q}A^\text{T} +B_u{\color{red}
Y}+{\color{red} Y}^\text{T}B_u^\text{T}+B_wB_w^\text{T} & {\color{red}
Q}C^\text{T}+{\color{red} Y}^\text{T}D_u^\text{T}+B_wD_w^\text{T}
\\C{\color{red} Q}+D_u{\color{red} Y}+D_wB_w^\text{T}&-\gamma^2I+D_wD_w^\text{T}
\end{matrix}\right]< 0
\end{equation}
This LMI is the same as we were looking for and it ends the proof.

#### Generalized $\mathcal{H}_2$ Gain (Bounded $L_2\rightarrow$ Bounded $L_\infty$)

If $D=0$ then the following statements are equivalent:

- System () is strictly dissipative with the supply rate:
  \begin{equation}
  s(w,z)=w^\text{T}w
  \end{equation}
- For all $\omega\in\mathbb{R}$:
  \begin{equation}
  \|T(j\omega)\|_{2,\infty}=\sup_{0 < \|w\|_2 <
\infty}\frac{\|z\|_\infty}{\|w\|_2} < \gamma
  \end{equation}
- There exists $P$ satisfying the LMIs:
  \begin{equation}
  \left[\begin{matrix} A^\text{T} P+PA&PB\\\\B^\text{T} P& -I\end{matrix}\right]
\lt 0\nonumber\\
  \left[\begin{matrix} P&C^\text{T}\\\\C&\gamma^2 I\end{matrix}\right] \gt 0
  \end{equation}

#### Generalized $\mathcal{H}_2$ State Feedback Controller

Consider the following linear system:
\begin{align}
\dot x=&Ax+B_ww+B_uu\nonumber\\
z =&C_zx+D_uu
\end{align}
where $u$ is the control input. We would like to design a controller of the form
$u=Kx$ such that for the closed loop system:
\begin{equation}
\sup_{\|w\|_2\neq 0}\frac{\|z\|_\infty}{\|w\|_2}<\gamma
\end{equation}
The design problem can be formulated as the following matrix inequality:
\begin{equation}
  \left[\begin{matrix}
AQ+QA^\text{T}+B_uY+Y^\text{T}B_u^\text{T}&B_w\\\\B_w^\text{T}&
-I\end{matrix}\right] \lt 0\nonumber\\
  \left[\begin{matrix} Q&QC^\text{T}+Y^\text{T}D_u^\text{T}\\\\CQ+D_uY&\gamma^2
I\end{matrix}\right] \gt 0
\end{equation}
where $K=YQ^{-1}$

