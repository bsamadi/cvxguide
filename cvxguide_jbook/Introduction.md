# Introduction

Optimization problems happen in many fields including engineering, economics and
medicine.
The objective of many engineering problems is to design "the best" product.
"The best" needs a formal definition that is not subject to personal judgement
as much as possible. In a mathematical optimization, the objective function
defines "the best". The objective function can be the description of a cost
function we want to minimize or it can be a quantified description of the
product's fitness, which is required to be maximized.
We live in a real world with lots of constraints. The energy is not free. The
time we can spend to design the product is limited. The computation power we
have is limited. The size, weight and price of the product is limited.
Therefore, the optimization problems are usually defined as minimizing or
maximizing an objective function considering a set of constraints. In this text,
we focus on a certain class of optimization problems: convex optimization. The
main importance of convex optimization problems is that there is no locally
optimum point. If a given point is locally optimal then it is globally optimal.
In addition, there exist effective numerical methods to solve convex
optimization problems. In addition, it is possible to convert many nonconvex
optimization problems to convex problems by changing the variables or
introducing new variables. In this text, we will review what convex sets,
functions and optimization problems are. Also, we show you numerical examples
and applications of convex optimization in control systems. Also, there are many
examples with the corresponding code in Python to help the reader understand how
the problems are solved in practive. The Python code is based on
[cvxpy](https://github.com/cvxgrp/cvxpy).

In the following, the definitions are taken from [1] unless otherwise stated.
The reader is referred to the [Convex Optimization book by
Stephen Boyd and Lieven Vandenberghe](http://www.stanford.edu/~boyd/cvxbook/)
for a detailed review of the theory of convex optimization and applications.
