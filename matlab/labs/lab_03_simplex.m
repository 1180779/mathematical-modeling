% Basic simplex implementation for max c' * x subject to |Ax| <= b, b > 0.
% Runs both nonnegative and unrestricted-variable cases with shared display.
% Based on a historical Lab 3 task; current assignment alignment unconfirmed.
% Run: run('matlab/labs/lab_03_simplex.m')
% Requires base MATLAB only; no linprog comparison is included yet.

% Clear the env
clear;
clc;

% save old format
oldFormat = format(); 
format compact

%%
%% Program starts here
%%

n = 3;
m = 2;

c = randi([1, 2], n, 1);
c(c==2) = -1;
b = randi([1, 10], m, 1);
A = randi([-1, 1], m, n);

% Both functions maximize c' * x subject to |Ax| <= b, b > 0.
fprintf('\n=== Nonnegative variables: y = x ===\n');
[xNonnegative, fvalNonnegative, exitflagNonnegative] = symplex(c, A, b);
display_simplex_result(xNonnegative, fvalNonnegative, exitflagNonnegative);

fprintf('\n=== Unrestricted variables: y = [x_plus; x_minus], x = x_plus - x_minus ===\n');
[xUnrestricted, fvalUnrestricted, exitflagUnrestricted] = symplex_unrestricted(c, A, b);
display_simplex_result(xUnrestricted, fvalUnrestricted, exitflagUnrestricted);

% restore format
format(oldFormat)

%%
%% functions below
%%

function [my_x, my_fval, my_exitflag] = symplex(f, A, b)
  % Maximize f' * x subject to |Ax| <= b, x >= 0, b > 0
  % 
  % exitflags: 
  %   1 = optimal
  %  -3 = unbounded
  %   0 = iteration limit

  % check that the sizes are valid
  validateattributes(f, {'numeric'}, {'real', 'finite', 'vector', 'nonempty'});
  validateattributes(A, {'numeric'}, {'real', 'finite', '2d', 'nonempty'});
  validateattributes(b, {'numeric'}, {'real', 'finite', 'vector', 'positive', 'nonempty'});
  f = double(f(:)');
  b = double(b(:));
  A = double(A);
  n = size(A, 2);
  m = size(A, 1);
  assert(numel(f) == n && numel(b) == m, 'invalid input dimensions')

  % the input system
  %   |Ax| <= b, 
  % is equivalent to 
  %    Ax  <= b and 
  %   -Ax  <= b
  A = [A; -A];
  b = [b; b];
  m = size(A, 1);

  % to get the standard form we need to add m slacks to get equalities instead
  % (which form an identity matrix on the right side of A):
  % A_n x_n = b
  % where
  %   A_n = [A I_m]
  % and
  %   x_n is the x extended with introduced slack variables
  An = [A eye(m)];

  % x_n is unknown to us

  % we similarly need to update the f coefficient vector to take into account those introduced variables
  % their coefficients are 0
  f = [f zeros(1, m)];

  % let B be the indexes of the variables chosen to be in the basis
  B = n + (1:m);
  % and BC be their coefficients vector
  function c = BC()
    c = f(B);
  end

  % let RHS be the right hand side (starts with original b, duplicated)
  RHS = b;

  % the simplex method step consists of the following operations
  % calculate the zj row
  % calculate the zj - cj row
  % from the zj - cj row select the value with the most negative coefficient (for ties the one with the smallest index)
  % suppose the selected value is in column 'k'
  % then from the m rows of column k calculate the ratios of RHS / column cells
  % only take into account those of the cells which have positive values
  % let the selected row be 'l'
  % the ratio which is the smallest identifies the variable which goes out of the basis (in comes the one corresponding to the most negative selection earlier)
  % now that we know which variable goes out and which in we want to make modifications in order to accomplish that
  % i.e., make the other rows in column corresponding to variable k zero and itself make it one in that l-th row
  % after that we continue

  % the process repeats until all of the values in zj - cj are nonnegative in which case we have found the maximum

  % note that the process can sometimes find itself in a loop, so a max number of iterations is needed as a precaution

  MAX_ITER = 1000;
  TOL = 1e-10;
  my_x = [];
  my_fval = NaN;
  my_exitflag = 0;
  for i = 1:MAX_ITER
    % calculate zj (row)
    zj = BC() * An;

    % calculate zj - cj = zj - f
    zjcj = zj - f;

    display_simplex_tableau(i, An, RHS, B, f, zj);

    % find most negative index
    [minZjcj, minIdx] = min(zjcj);
    if minZjcj >= -TOL
      xn = zeros(n + m, 1);
      xn(B) = RHS;
      my_x = xn(1:n);
      my_fval = f(1:n) * my_x;
      my_exitflag = 1;
      return
    end

    % calculate the ratios for the minIdx-th column (positive cells only)
    eligible = An(:, minIdx) > TOL;
    if ~any(eligible)
      my_fval = Inf;
      my_exitflag = -3;
      return
    end
    ratios = Inf(m, 1);
    ratios(eligible) = RHS(eligible) ./ An(eligible, minIdx);
    [~, l] = min(ratios);

    % zero all other rows in minIdx-th column
    % first get a one at [l, minIdx]
    pivot = An(l, minIdx);
    An(l, :) = An(l, :) ./ pivot;
    RHS(l) = RHS(l) ./ pivot;
    % then zero all other rows
    for j = 1:m
      if j == l
        continue
      end
      factor = An(j, minIdx);
      An(j, :) = An(j, :) - An(l, :) .* factor;
      RHS(j) = RHS(j) - RHS(l) .* factor;
    end
    B(l) = minIdx;
  end
end

function display_simplex_tableau(iteration, An, RHS, B, f, zj)
  % y denotes nonnegative decision variables; s denotes slack variables.
  m = size(An, 1);
  n = size(An, 2) - m;
  labels = [compose('y%d', 1:n), compose('s%d', 1:m)];

  fprintf('\nIteration %d\n', iteration);
  fprintf('Basis indices B:');
  fprintf(' %d', B);
  fprintf('\n');
  fprintf('%10s%12s', 'Basis', 'cB');
  fprintf('%12s', labels{:});
  fprintf('%12s\n', 'RHS');

  for row = 1:m
    fprintf('%10s%12.6g', labels{B(row)}, f(B(row)));
    fprintf('%12.6g', An(row, :));
    fprintf('%12.6g\n', RHS(row));
  end

  fprintf('%10s%12s', 'cj', '');
  fprintf('%12.6g', f);
  fprintf('%12s\n', '-');
  fprintf('%10s%12s', 'zj', '');
  fprintf('%12.6g', zj);
  fprintf('%12.6g\n', f(B) * RHS);
  fprintf('%10s%12s', 'zj - cj', '');
  fprintf('%12.6g', zj - f);
  fprintf('%12s\n', '-');
  fprintf('Current objective value: %.10g\n', f(B) * RHS);
end

function display_simplex_result(my_x, my_fval, my_exitflag)
  switch my_exitflag
    case 1
      fprintf('\nOptimal solution found.\n');
    case -3
      fprintf('\nThe objective is unbounded above.\n');
    otherwise
      fprintf('\nIteration limit reached; no optimum certified.\n');
  end
  fprintf('my_x (original variables):\n');
  disp(my_x);
  fprintf('my_fval: %.10g\n', my_fval);
  fprintf('my_exitflag: %d\n', my_exitflag);
end

function [my_x, my_fval, my_exitflag] = symplex_unrestricted(f, A, b)
  % Maximize 
  %   f' * x 
  % subject to 
  %   |Ax| <= b, b > 0; 
  % x may have either sign
  validateattributes(f, {'numeric'}, {'real', 'finite', 'vector', 'nonempty'});
  assert(numel(f) == size(A, 2), 'invalid input dimensions')
  n = numel(f);
  f = double(f(:));
  A = double(A);

  % Write 
  %   x = x_plus - x_minus, 
  % with both new vectors nonnegative
  % the objective becomes 
  %   [f; -f]' * [x_plus; x_minus]
  [split_x, my_fval, my_exitflag] = symplex([f; -f], [A -A], b);
  my_x = [];
  if my_exitflag == 1
    my_x = split_x(1:n) - split_x(n + (1:n));
  end
end
