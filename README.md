# GCRO-DR

Many problems in engineering and physics require the solution of a large sequence of linear systems. We can reduce the cost of solving subsequent systems in the sequence by recycling information from previous systems. I develop a family of solvers based upon a technique known as "Krylov Subspace Recycling". Trilinos' (https://trilinos.github.io/) Belos package (https://trilinos.github.io/belos.html) currently contains a recycling GMRES solver (GCRO-DR) and a recycling CG solver (RCG). For some problems, the iteration count required to solve a linear system can be cut by a factor of two.

## More about GCRO-DR

Michael L. Parks, Eric de Sturler, Greg Mackey, Duane Johnson, and Spandan Maiti, _Recycling Krylov Subspaces for Sequences of Linear Systems_, SIAM Journal on Scientific Computing, 28(5), pp. 1651-1674, 2006, https://doi.org/10.1137/040607277. Also available as University of Illinois Department of Computer Science Technical Report UIUCDCS-R-2004-2421.

## In this repository - Recycling GMRES (GCRO-DR) Matlab implementation
- Matlab code developed by Michael L. Parks for the above paper and as a part of his PhD work
- Includes example sequence of linear systems from a finite element fracture mechanics problem constructed by Philippe H. Geubelle and Spandan Maiti
- Warning : This is a research code, not a production code! Should you notice any "strange behavior" (abnormal termination, extremely poor convergence, etc.) please contact Michael Parks.
