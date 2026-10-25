% SPOILERS: reference models and checks for all four invented mock labs.
% Attempt the practice PDF before reading this file.
% Run: run('matlab/labs/lab_03_practice_answers.m')
% Requires Optimization Toolbox, with the dual-simplex-highs algorithm.
clear;
clc;
tol = 1e-7;
options = optimoptions('linprog', 'Algorithm', 'dual-simplex-highs', ...
    'Display', 'none', 'ConstraintTolerance', 1e-9, ...
    'OptimalityTolerance', 1e-9);

%% A: original and standard forms, including the changed assembly capacity.
resources = [3, 2; 1, 2];
profit = [5; 4];
for assemblyHours = [18, 20]
    capacity = [assemblyHours; 10];
    A = [resources; -eye(2)];
    b = [capacity; zeros(2, 1)];
    [x, fval] = finite_min(-profit, A, b, [], [], options, tol);
    S = [resources, eye(2)];
    [v, standardValue] = finite_min([-profit; 0; 0], -eye(4), ...
        zeros(4, 1), S, capacity, options, tol);
    expected = [(assemblyHours - 10)/2; (30 - assemblyHours)/4];
    assert(norm(x - expected, Inf) <= tol);
    assert(norm(v(1:2) - x, Inf) <= tol && abs(fval - standardValue) <= tol);
    prices = [1.5; 0.5];
    assert(norm(resources' * prices - profit, Inf) <= tol);
    assert(abs(-fval - prices' * capacity) <= tol);
    fprintf('A: assembly=%g, x=(%.10f, %.10f), profit=%.10f\n', ...
        assemblyHours, x, -fval);
end

%% B: original minimum-cost problem and original standard form.
cost = [2; 3];
A = [-1, -1; -eye(2)];
b = [-4; 0; 0];
[x, fval] = finite_min(cost, A, b, [1, 3], 6, options, tol);
S = [1, 1, -1; 1, 3, 0];
[v, standardValue] = finite_min([cost; 0], -eye(3), zeros(3, 1), ...
    S, [4; 6], options, tol);
assert(norm(x - [3; 1], Inf) <= tol && abs(fval - 9) <= tol);
assert(norm(v - [3; 1; 0], Inf) <= tol && abs(standardValue - fval) <= tol);
% Explicit Phase I, independent of the solver's internal initialization.
T = [S, eye(2)];
[phasePoint, artificialSum] = finite_min([0; 0; 0; 1; 1], ...
    -eye(5), zeros(5, 1), T, [4; 6], options, tol);
assert(abs(artificialSum) <= tol && norm(phasePoint(4:5), Inf) <= tol);
% Check the stated hand bases, not the solver's possibly different path.
for basis = {[4, 5], [4, 2], [1, 2]}
    B = basis{1};
    basic = T(:, B) \ [4; 6];
    assert(all(basic >= -tol));
end
fprintf('B: x=(%.10f, %.10f), cost=%.10f; Phase I sum=%.10f\n', ...
    x, fval, artificialSum);

%% C: original signed variables, then shifted and split standard form.
A = [1, 1; -1, 1; 0, -1; 0, 1];
b = [3; 1; 1; 2];
[original, fval] = finite_min([-3; -2], A, b, [], [], options, tol);
S = [1, -1, 1, 1, 0, 0; -1, 1, 1, 0, 1, 0; 0, 0, 1, 0, 0, 1];
c = [3; -3; 2; 0; 0; 0];
[v, standardValue] = finite_min(-c, -eye(6), zeros(6, 1), ...
    S, [4; 2; 3], options, tol);
recovered = [v(1) - v(2); v(3) - 1];
assert(norm(original - [4; -1], Inf) <= tol);
assert(norm(recovered - original, Inf) <= tol);
assert(abs((-fval + 5) - 15) <= tol);
assert(abs((-standardValue + 3) - 15) <= tol);
% The split representation is nonunique even though (u,v) is unique.
assert(norm(S * [6; 2; 0; 0; 6; 3] - [4; 2; 3], Inf) <= tol);
assert(abs(c' * [6; 2; 0; 0; 6; 3] + 3 - 15) <= tol);
fprintf('C: (u,v)=(%.10f, %.10f), full score=%.10f\n', original, -fval + 5);

%% D1: do not require the solver to choose one particular optimal endpoint.
A = [1, 1; 1, 0; 0, 1; -eye(2)];
b = [4; 3; 3; 0; 0];
[x, fval] = finite_min([-1; -1], A, b, [], [], options, tol);
assert(abs(-fval - 4) <= tol && abs(sum(x) - 4) <= tol);
for point = [1, 3; 3, 1]'
    assert(all(A * point <= b + tol) && abs(sum(point) - 4) <= tol);
end
fprintf('D1: one optimizer=(%.10f, %.10f); value=%.10f\n', x, -fval);

%% D2: certify infeasibility and a strictly positive Phase I minimum.
A = [-1, -1; 2, 2; -eye(2)];
b = [-5; 8; 0; 0];
[~, ~, flag, info] = linprog([1; 2], A, b, [], [], [], [], options);
fprintf('D2 status: %d; %s\n', flag, info.message);
assert(flag == -2, 'Expected an infeasible status. Inspect solver diagnostics.');
% Order x1,x2,s,t,a; objective minimizes the one artificial variable.
T = [1, 1, -1, 0, 1; 2, 2, 0, 1, 0];
[~, w] = finite_min([0; 0; 0; 0; 1], -eye(5), zeros(5, 1), ...
    T, [5; 8], options, tol);
assert(abs(w - 1) <= tol);
assert(norm(T * [4; 0; 0; 0; 1] - [5; 8], Inf) <= tol);

%% D3: check a ray as well as the solver's unbounded status.
A = [1, -1; -eye(2)];
b = [1; 0; 0];
profit = [2; 1];
point = [1; 0];
direction = [1; 1];
assert(all(A * point <= b + tol));
assert(all(A * direction <= tol) && profit' * direction > 0);
[~, ~, flag, info] = linprog(-profit, A, b, [], [], [], [], options);
fprintf('D3 status: %d; %s\n', flag, info.message);
assert(flag == -3, 'Expected an unbounded status. Inspect solver diagnostics.');
fprintf('All practice-answer checks passed (tolerance %.0e).\n', tol);

function [x, fval] = finite_min(f, A, b, Aeq, beq, options, tol)
    % Shared acceptance checks only; each task supplies its explicit model.
    [x, fval, flag, info] = linprog(f, A, b, Aeq, beq, [], [], options);
    assert(flag > 0, 'No finite optimum: %s', info.message);
    assert(all(A * x <= b + tol));
    if ~isempty(Aeq)
        assert(norm(Aeq * x - beq, Inf) <= tol);
    end
    assert(abs(f' * x - fval) <= tol);
end
