------------------------------------------------------------------
G C R O - D R
------------------------------------------------------------------
Latest update : March 30, 2004
------------------------------------------------------------------
Problems? Questions?

Contact:

Michael L. Parks  
parks@cse.uiuc.edu   
http://www.cse.uiuc.edu/~parks 

Eric de Sturler   
sturler@cs.uiuc.edu  
http://www-faculty.cs.uiuc.edu/~sturler/
------------------------------------------------------------------
Usage Guide:

Run the driver to see GCRO-DR solve a sequence of 10 linear 
systems from a finite element fracture mechanics problem developed 
by Philippe H. Geubelle (AAE-UIUC) and Spandan Maiti (AAE-UIUC)

In matlab, do 'help gcrodr' for parameter choices. 
------------------------------------------------------------------
Cautionary warning:

GCRO-DR implements Krylov subspace recycling in Matlab throught 
the use of persistent variables. In consecutive calls to GCRO-DR, 
the solver will always recycle a subspace unless the Matlab 
command "clear all" is executed between calls, or the 'name' 
arguments are different. 

Example:

The second GCRO-DR call below runs WITH a recycled subspace:

clear all;
x1 = gcrodr(A1,b1,m,k);
x2 = gcrodr(A2,b2,m,k);

The second GCRO-DR call below runs WITHOUT a recycled subspace:

clear all;
x1 = gcrodr(A1,b1,m,k);
clear all;
z1 = gcrodr(B1,f1,m,k);

To avoid unnecessarily calling "clear all", GCRO-DR allows you 
to associate names to recycled subspaces. 

Consider the following four calls to GCRO-DR:

clear all;
[L,U] = luinc(A1,'0');
x1 = gcrodr(A1,b1,m,k,x0,tol,[],[],'NoPreconditioner');
x1 = gcrodr(A1,b1,m,k,x0,tol,L,U,'ILU0');
[L,U] = luinc(A2,'0');
x1 = gcrodr(A2,b2,m,k,x0,tol,[],[],'NoPreconditioner');
x1 = gcrodr(A2,b2,m,k,x0,tol,L,U,'ILU0');

The first and second calls to GCRO-DR run without a recycled 
subspace. The third call to GCRO-DR runs with a subspace recycled 
from the first GCRO-DR call. The fourth call to GCRO-DR runs with 
a subspace recycled from the second GCRO-DR call. 