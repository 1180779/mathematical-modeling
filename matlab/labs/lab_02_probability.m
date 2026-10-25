% Lab 2, group 1: distributions minimizing an expectation or a common bound.
% Run from the repository root: run('matlab/labs/lab_02_probability.m')
% Requires Optimization Toolbox. All bounds are rows of A*x <= b.
clear;
clc;
tol = 1e-7;
options = optimoptions('linprog', 'Display', 'none', ...
    'ConstraintTolerance', 1e-9, 'OptimalityTolerance', 1e-9);
X = [1.2; 2.1; -0.4; 1.2; -0.5];
Y = [1.2; -0.6; 2.4; -0.1; 0.5];

%% Part (a): probabilities sum to one and each lies in [0, 0.3].
A = [-eye(5); eye(5)];
b = [zeros(5, 1); 0.3 * ones(5, 1)];
Aeq = ones(1, 5);
beq = 1;
[pA, valueA, flagA] = linprog(X, A, b, Aeq, beq, [], [], options);
assert(flagA > 0, 'Part (a) did not reach an optimum.');
assert(all(A * pA <= b + tol) && abs(sum(pA) - 1) <= tol);
assert(abs(valueA - 0.21) <= tol && abs(X' * pA - valueA) <= tol);
% Do not demand one particular p: p1+p4=0.4 allows multiple optima.
assert(norm(pA([2, 3, 5]) - [0; 0.3; 0.3], Inf) <= tol);
assert(abs(pA(1) + pA(4) - 0.4) <= tol);
fprintf('Part (a): E[X] = %.10f, E[Y] = %.10f\n', X' * pA, Y' * pA);
disp(table((1:5)', pA, 'VariableNames', {'Outcome', 'Probability'}));

%% Part (b): v=(p1,...,p5,z); z is free, probabilities are nonnegative.
% The 0.3 cap belongs only to part (a). No cap is imposed here.
A = [X', -1; Y', -1; -eye(5), zeros(5, 1)];
b = zeros(7, 1);
Aeq = [ones(1, 5), 0];
f = [zeros(5, 1); 1];
[vB, valueB, flagB] = linprog(f, A, b, Aeq, beq, [], [], options);
assert(flagB > 0, 'Part (b) did not reach an optimum.');
pB = vB(1:5);
assert(all(A * vB <= b + tol) && abs(Aeq * vB - beq) <= tol);
assert(norm(pB - [0; 10/37; 0; 0; 27/37], Inf) <= tol);
assert(abs(valueB - 15/74) <= tol);
assert(norm([X' * pB; Y' * pB] - valueB, Inf) <= tol);
% A convex combination of the expectations certifies the lower bound.
support = (11 * X + 26 * Y) / 37;
assert(all(support >= 15/74 - tol));
fprintf('Part (b): E[X] = %.10f, E[Y] = %.10f, z = %.10f\n', ...
    X' * pB, Y' * pB, valueB);
disp(table((1:5)', pB, 'VariableNames', {'Outcome', 'Probability'}));

%% Show the solver's distributions; another optimal part (a) plot is valid.
figure('Name', 'Lab 2: probability distributions');
subplot(1, 2, 1);
bar(1:5, pA);
xlabel('Outcome i'); ylabel('Probability p_i');
title('Part (a): minimum E[X]'); ylim([0, 1]);
subplot(1, 2, 2);
bar(1:5, pB);
xlabel('Outcome i'); ylabel('Probability p_i');
title('Part (b): minimum common upper bound'); ylim([0, 1]);
fprintf('All probability-model checks passed (tolerance %.0e).\n', tol);
