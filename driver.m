%**************************************************************************************
% AUTHOR      : Michael L. Parks, University of Illinois at Urbana-Champaign
% DATE        : 3/30/04
% DESCRIPTION : Solve a sequence of 10 linear systems with GCRODR, 
%               using Krylov subspace recycling (on systems 2-10)
% NOTES       : Developed by Michael L. Parks and Eric de Sturler, University of Illinois
%               Contact: parks@cse.uiuc.edu,  http://www.cse.uiuc.edu/~parks 
%                        sturler@cs.uiuc.edu, http://www-faculty.cs.uiuc.edu/~sturler/
%               See UIUC CS tech report UIUCDCS-R-2004-2421
% ACK         : Example linear systems arise from finite element analysis of crack propogation.
%               Problem courtesy of Philippe H. Geubelle (AAE-UIUC, geubelle@uiuc.edu) 
%               and Spandan Maiti (AAE-UIUC)
%**************************************************************************************

% Be sure to "clear all" so that no subspace is recycled from previous calls to driver 
clear all;
clc;

% Put GCRODR in path
addpath('gcrodr');

% Initialize count
count = 0;

% Initialize matvec count
nmv_total = [];

% Solve 10 sequential linear systems
for i = 400:409,
    
   disp(sprintf('\nNow solving linear system #%i\n',i))

   % Load system from disk
   filename = cat(2,sprintf('./data/%i',i),'.txt');
   [A,b] = load_matrix(filename);
   x0 = zeros(length(b),1);

   % Call GCRO-DR
   [x,resvec,r,nmv,relres] = gcrodr(A,b,40,20,x0,1e-10,[],[]);

   % Record number of matrix-vector products needed to solve this linear system
   nmv_total = [nmv_total, nmv];
   
   % Scale convergence history to show relative residual norms
   resvec = resvec / norm(b);

   % Plot convergence history
   u = count : count+length(resvec)-1;
   semilogy(u,resvec);
   axis([0 2500 1e-10 1]);
   title('Convergence for 10 consecutive linear systems')   
   xlabel('Total number of matrix-vector products')
   ylabel('Relative residual norm')
   hold on;

   count = count + length(resvec);
   
end

% Output number of matrix-vector products needed to solve each linear system
for i = 1:10
   disp(sprintf('Linear system %2i required %i matrix-vector products.',i,nmv_total(i)))
end