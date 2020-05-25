# Generalized linear fractional program

A linear fractional program is defined as (LFP):
\begin{align}
\text{minimize }&f_0(x)\nonumber\\
\text{subject to }&a_i^\text{T}x\leq b_i,\ i=1,\ldots,m\nonumber\\
                  &h_i^\text{T}x = g_i,\ i=1,\ldots,p
\end{align}
with $f_0(x)=\frac{c^\text{T}x+d}{e^\text{T}x+f}$ and
$\text{dom}f_0(x)=\{x|e^\text{T}x+f > 0\}$. The problem (ref{LFP}) can be
rewritten as:
\begin{align}
\text{minimize }&\frac{c^\text{T}x+d}{e^\text{T}x+f}\nonumber\\
\text{subject to }&e^\text{T}x+f > 0\nonumber\\
                  &a_i^\text{T}x\leq b_i,\ i=1,\ldots,m\nonumber\\
                  &h_i^\text{T}x = g_i,\ i=1,\ldots,p
\end{align}
is a quasilinear (both quasiconvex and quasiconcave) optimization problem. To
solve the problem using the bisection method, we need to write it as:
\begin{align}
\text{minimize }&t\nonumber\\
\text{subject to }&c^\text{T}x+d\leq t(e^\text{T}x+f)\nonumber\\
                  &e^\text{T}x+f > 0\nonumber\\
                  &a_i^\text{T}x\leq b_i,\ i=1,\ldots,m\nonumber\\
                  &h_i^\text{T}x = g_i,\ i=1,\ldots,p
\end{align}
For a fixed $t$, the above problem is a LP feasibility problem. Therefore, the
bisection method can be used to find the smallest possible $t$ within acceptable
accuracy.

Another approach is introduce auxiliary variables $y$ and $z$:
\begin{align}
y =& \frac{x}{e^\text{T}x+f}\nonumber\\
z =& \frac{1}{e^\text{T}x+f}
\end{align}
Then the optimization problem (ref{LFP}) can be written as the following LP
problem:
\begin{align}
\text{minimize }&c^\text{T}y+dz\nonumber\\
\text{subject to }&z > 0\nonumber\\
                  &e^\text{T}y+fz=1\nonumber\\
                  &a_i^\text{T}y\leq b_iz,\ i=1,\ldots,m\nonumber\\
                  &h_i^\text{T}y = g_iz,\ i=1,\ldots,p
\end{align}
Therefore, linear fractional programs can be converted to convex optimization
problems.

A closely related class of optimization problems is the generalized linear
fraction problems formulated as (GLFP):
\begin{align}
\text{minimize }&f_0(x)\nonumber\\
\text{subject to }&a_i^\text{T}x\leq b_i,\ i=1,\ldots,m\nonumber\\
                  &h_i^\text{T}x = g_i,\ i=1,\ldots,p
\end{align}
where:
\begin{equation}
f_0(x)=\max_{i=1,\ldots,r} \frac{c_i^\text{T}x+d_i}{e_i^\text{T}x+f_i}
\end{equation}
and the domain of $f_0(x)$ is defined as:
\begin{equation}
\text{dom}f_0(x)=\{x|e_i^\text{T}x+f_i > 0, \text{for }i=1,\ldots,r\}
\end{equation}


