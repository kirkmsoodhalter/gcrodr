%
% [A,b] = readmat(filename)     
%         reads a sparse matrix and rhs vector from a CSR text file
%         with the following format:
%
%         neqns size(matrx_csr) size(imatrx_csr)
%         matrx_csr1  matrx_csr2  matrx_csr3  matrx_csr4
%         matrx_csr5  matrx_csr6  matrx_csr7  matrx_csr8
%         .      .      .
%         .      .      .
%         jmatrx_csr1 jmatrx_csr2 jmatrx_csr3 jmatrx_csr4 jmatrx_csr5 jmatrx_csr6 jmatrx_csr7
%         .      .      .
%         .      .      .
%         imatrx_csr1 imatrx_csr2 imatrx_csr3 imatrx_csr4 imatrx_csr5 imatrx_csr6 imatrx_csr7
%         .      .      .
%         .      .      .
%         rhs1        rhs2        rhs3        rhs matrx_csr4
%         .      .      .
%         .      .      .
function [A,b] = load_matrix(infilename)

% Open input file
fid = fopen(infilename, 'r');

if (fid == -1) 
    disp(sprintf('File not found!'))
    return
end

% Read first line
line = fgets(fid);
v = sscanf(line,'%d');
neqns           = v(1);  
size_matrx_csr  = v(2); 
size_imatrx_csr = v(3);

disp(sprintf('Loading %i x %i matrix.\n',neqns,neqns))

% Allocate CSR Storage
matrx_csr  = zeros(size_matrx_csr,1);
jmatrx_csr = zeros(size_matrx_csr,1);
imatrx_csr = zeros(size_imatrx_csr,1);
b          = zeros(neqns,1);

% Read in the array matrx_csr
k = 0;
while (k < size_matrx_csr)
  entry = fgets(fid);
  [t,count] = sscanf(entry,'%e', 4); % scan the four items on each line
  if count >= 1
     matrx_csr(k+1) = t(1);
  end
  if count >= 2
     matrx_csr(k+2) = t(2);
  end
  if count >= 3
     matrx_csr(k+3) = t(3);
  end
  if count >= 4
     matrx_csr(k+4) = t(4);
  end
  k = k + count;
end

% Read in the array jmatrx_csr
k = 0;
while (k < size_matrx_csr)
  entry = fgets(fid);
  [t,count] = sscanf(entry,'%i', 7); % scan the seven items on each line
  if count >= 1
     jmatrx_csr(k+1) = t(1);
  end
  if count >= 2
     jmatrx_csr(k+2) = t(2);
  end
  if count >= 3
     jmatrx_csr(k+3) = t(3);
  end
  if count >= 4
     jmatrx_csr(k+4) = t(4);
  end
  if count >= 5
     jmatrx_csr(k+5) = t(5);
  end
  if count >= 6
     jmatrx_csr(k+6) = t(6);
  end
  if count >= 7
     jmatrx_csr(k+7) = t(7);
  end  
  k = k + count;
end

% Read in the array imatrx_csr
k = 0;
while (k < size_imatrx_csr)
  entry = fgets(fid);
  [t,count] = sscanf(entry,'%i', 7); % scan the seven items on each line
  if count >= 1
     imatrx_csr(k+1) = t(1);
  end
  if count >= 2
     imatrx_csr(k+2) = t(2);
  end
  if count >= 3
     imatrx_csr(k+3) = t(3);
  end
  if count >= 4
     imatrx_csr(k+4) = t(4);
  end
  if count >= 5
     imatrx_csr(k+5) = t(5);
  end
  if count >= 6
     imatrx_csr(k+6) = t(6);
  end
  if count >= 7
     imatrx_csr(k+7) = t(7);
  end  
  k = k + count;
end

% Read in the array rhs
k = 0;
while (k < neqns)
  entry = fgets(fid);
  [t,count] = sscanf(entry,'%e', 4); % scan the four items on each line
  if count >= 1
     b(k+1) = t(1);
  end
  if count >= 2
     b(k+2) = t(2);
  end
  if count >= 3
     b(k+3) = t(3);
  end
  if count >= 4
     b(k+4) = t(4);
  end
  k = k + count;
end

fclose(fid);

% Convert CSR format to matlab sparse format
A = spalloc(neqns,neqns,size_matrx_csr);

for i = 1:neqns,
   for j = imatrx_csr(i):imatrx_csr(i+1)-1,
      % Row = i
      % Column = jmatrx_csr(j)
      % A(Row,Col) = matrx_csr(j)
      if j <= length(jmatrx_csr)
         A(i,jmatrx_csr(j)) = matrx_csr(j);
      end
   end
end

A = sparse(A);