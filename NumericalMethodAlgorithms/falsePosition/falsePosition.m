function [root, fx, ea, iter] = falsePosition(func, xl, xu, es, maxiter)
% The falsePosition function is a function that uses the false position
% root finding method to find the real roots of a function. This function
% must have an inputed function in the form of func = @(x) function.
% Inputs:
% func = Function that has roots.
% xl = Lower bound guess determined by user. (Cannot be same sign as xu)
% xu = Upper bound guess determined by user.
% es = Desired relative error. (Defaults to 0.0001%)
% maxiter = Maimum iterations. (Deafults to 200 iterations)
% Outputs:
% Root = The estimated root location.
% fx = The function evaluated at the root location.
% ea = The approximate relative error (%).
% iter = Number of iterations performed.

format long     % Will find the root with high precision
if nargin < 3   % Uses nargin to determine the minimum number of inputs
    error('Three inputs are required') % 3 inputs are required(func,xu,xl)
end
signchange = func(xl)*func(xu); % Determines if the sign will 
                                % change over the interval
if signchange > 0   % If the sign isn't negative, there is no sign change
    error('There is no sign change') %Error to tell user that the bounds 
                                     %need to be changed
end
if nargin < 4   % If the user doesn't input an es or maxiter, they will 
    es = .0001; % default to .0001 and 200 respectively
    maxiter = 200;
end
if nargin < 5   % If user doesn't input maxiter, it will default to 200
    maxiter = 200;
end

iter = 0;   % Parameters for while loop. Begins at 0 iterations
ea = 100;
xr = xl;

while (1)   % While 1 allows loop to run with user input
    xrprev = xr; % xrprev = the last xr calculated
    xr = xu - ((func(xu)*(xl - xu))/(func(xl)-func(xu))); % Formula for 
    iter = iter + 1;                                 % false position
    if xr ~= 0  % Will determine the error if the root is not 0
        ea = abs((xr-xrprev)/xr)*100;   % Approximate error equation 
    end
    if func(xr) > 0 && func(xu) > 0 || func(xr) < 0 && func(xu) < 0
        xu = xr;    % Replaces upper bound if func(xr) has the same sign 
                    % as the upper bound
    elseif func(xr) < 0 && func(xl) < 0 || func(xl) > 0 && func(xr) > 0 
        xl = xr;    % Replaces lower bound if func(xr) has the same sign
                    % as the lower bound
    else 
        ea = 0  % If func(xr) is not greater or less than 0, than the 
                % root is 0
    end
 
    if iter >= maxiter % If # of iterations is larger than maximum
        break          % iterations, the while loop will stop
    end
    if ea <= es    % If error is smaller than desired error, the while
        break      % loop will stop
    end
end
    root = xr; 
    fx = func(xr); % Root plugged into the function
    fprintf('The root location is %.3d\n',root)
    fprintf('The root evaluated at the function is %.3d\n',fx)
    fprintf('The approximate relative error (percent) is %.3d\n',ea)
    fprintf('The number of iterations performed is %d\n',iter)
    % fprintf to display each output to 3 decimal places
   



