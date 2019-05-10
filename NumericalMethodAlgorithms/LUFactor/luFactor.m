function [L,U,P] = luFactor(A)
% The function luFactor creates an upper, lower, and pivot matrix by
% performing LU decomposition on a coefficient matrix. 
%   Inputs: 
%   A - Coefficient matrix
%   Outputs: 
%   L - Lower triangular matrix
%   U - Upper triangular matrix
%   P - Pivot matrix

[r,c] = size(A); %r=row and c=column, used to index the coefficient matrix 
L = eye(c); % Creates 1's along the diagonal for the lower matrix
P = L;  % Identity matrix is set to have 1's along diagonal
U = A;  % Initializes the upper matrix

% Error code to tell the user that LU decomposition must be done on a
% square matrix
if r ~= c
    error('The coefficient matrix must be a square matrix')
end

% Error code to tell the user that the matrix input must be a matrix
if r <= 1 || c <= 1
    error('The coefficient matrix must be larger than a 1x1')
end

for i = 1:c    % i=all the colums in the matrix
    [pivot r] = max(abs(U(i:c,i))); % Uses max to find maximum absolute 
                                    % value in the matrix
    r = r+i-1;  % Searches for maximum value in each column starting at 1
    if r ~= i
        % Pivot the upper matrix - move largest value in column
        pivot = U(i,:);   % Assigns a column as a pivot column
        U(i,:) = U(r,:);  % Replaces column with pivot column
        U(r,:) = pivot;   % Puts the replaced column in the previous pivot 
                          % columns spot
        % Pivot the identity matrix (Copy of the upper pivot)
        pivot = P(i,:);
        P(i,:) = P(r,:);
        P(r,:) = pivot;
    end
    % Pivot the lower matrix - similar to the upper matrix pivot except the
    % lower matrix will only pivot the lower corner of the matrix (the
    % multiplers)
    if i >= 2
        pivot = L(i,1:i-1); 
        L(i,1:i-1) = L(r,1:i-1);
        L(r,1:i-1) = pivot;
    end
    % Solves for upper and lower triangular matices
    for j = i+1:c  
        L(j,i) = U(j,i)/U(i,i);    % Finds the multiplier for lower matrix
        U(j,:) = U(j,:) - L(j,i)*U(i,:);    % Finds what the new values in 
                                            % the upper matrix are
    end
end

% Final check to see if the lower and upper matrices are correct
check = P*A == L*U;  

% Display each individual matrix
disp('The lower triangular matrix L is: ')
disp(L)
disp('The upper triangular matrix U is: ')
disp(U)
disp('The identiy matrix P is: ')
disp(P)
disp('Check to see if [P][A]=[L][U]')
disp(check)

