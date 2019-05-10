function [I] = Simpson(x,y)

% The Simpson function is a function that uses Simpson's 1/3 rule to
% integrate experimental data.

% Inputs:
% x: Values that will be plugged into the function y.
% y: Values of a function y, calculated by using x values. Y must be
% inputed by using y = @(x).

% Outputs:
% I: The value of the integral of the function.

% Initialize x and y matrices
[r,c] = size(x);
[a,b] = size(y);

n = length(x);     % Initializes n - the number of integers
h = x(2) - x(1);   % Initializes h - the interval size

% Error's and Warnings for inputs:
if nargin< 2 
    error('At least 2 inputs are required')
end
if r ~= a && c ~= b
    error('The x and y inputs must be the same length')
end

% Test to check if the number of intervals is even or odd
test = linspace(x(1),x(end),n);
check = test(1,2:end-1) == x(1,2:end-1);

if check ~= ones(1,n-2)
    error('Inputs must be equally spaced')
end

% Even is a test to check if the interval spacing is odd and if so, a warning is given 
even = mod(n,2) == 0;

if even ~= 0
    warning('The tapazoidal rule will be used on the last interval')
end

% Calculation of middle terms in the integral calculation
j = x(2:2:end);    
s1 = 4*sum(y(j));  
k = x(3:2:end-2);  
s2 = 2*sum(y(k)); 

if even ~= 0    % If the number of intervals is odd the trap rule will be added
    I = h/3*(y(x(1)) + s1 + s2 + y(x(end))) + ((x(n)-(x(n-1)))*(y(n)+y(n-1)))/2;
else   % If the number of intervals is even the trap rule will not be added
    I= h/3*(y(x(1)) + s1 + s2 + y(x(end)));
end

% Display the value of the integral
disp('The value of the integral is:');
fprintf('%d\n',I)

end


