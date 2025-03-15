% Arnoldi Iteration
%
% Generates relation (I - C*C') V(:,1:m) = V(:,1:m+1) H
%
% INPUT:  A      N-by-N matrix
%         X      current solution vector
%         R      N-by-1 preconditioned residual vector
%         M      number of GMRES iterations to perform
%         M1     left preconditioner for A
%         M2     right preconditioner for A
%         C 
%         tol    specifies the tolerance of the method
% OUTPUT: V      N-by-M+1 matrix containing orthogonal basis for Krylov subspace 
%         H      M+1-by-M upper Hessenburg reduction of matrix operator
%         B      the matrix C'*A*V(:,1:k)
%         K      number of GMRES iterations actually performed
%         RESVEC vector containing norm of residual at each iteration
function [V,H,B,k,resvec] = gmres2(A,x,r,m,M1,M2,C,tol)

if(isempty(M1))
   existM1 = 0;
else
   existM1 = 1;
end
if(isempty(M2))
   existM2 = 0;
else
   existM2 = 1;
end

% Initialize V
V(:,1) = r / norm(r);

for k = 1:m
   % Find w using preconditioning if available.
   if(existM2)
      w = M2 \ V(:,k);
   else
      w = V(:,k);
   end
   w = A*w;
   if(existM1)
      w = M1 \ w;
   end

   % Apply (I-C*C') operator to Aw
   B(:,k) = C' * w;
   w = w - C * B(:,k);

   % Create next column of V and H
   for j = 1:k
      H(j,k) = V(:,j)' * w;
      w = w - H(j,k) * V(:,j);
   end

   H(k+1,k) = norm(w);
   V(:,k+1) = w / H(k+1,k);

   % Initialize right hand side of least-squares system
   rhs = zeros(k+1,1);
   rhs(1) = norm(r);

   % Solve least squares system; Calculate residual norm
   y = H \ rhs;
   res = rhs - H * y;
   resvec(k) = norm(res);
   if resvec(k) < tol
      return
   end
end