% Checks accompanying notes/lectures/04-degeneracy-and-duality.tex.
% Inputs: s4_w4.pdf, plus the added examples identified in the end remarks.
% Verified 2026-10-04 in the user's normal terminal; all assertions passed.
% User-supplied R2026b output: docs/matlab-verification.md.
% Run from the repository root:
%   run('matlab/exercises/lecture_04_checks.m')
% Base MATLAB only. Checks specified small paths, not a general LP solver.
clear;
clc;
tol = 1e-10; % Absolute tolerance for these modestly scaled examples.

%% Cycling, Bland, and lexicographic paths use the same original matrices.
A = [1, 0, 0, 1/4, -8, -1, 9; ...
     0, 1, 0, 1/2, -12, -1/2, 3; ...
     0, 0, 1, 0, 0, 1, 0];
b = [0; 0; 1];
c = [0; 0; 0; 3/4; -20; 1/2; -6];
cycle = [1, 2, 3; 4, 2, 3; 4, 5, 3; 6, 5, 3; ...
         6, 7, 3; 1, 7, 3; 1, 2, 3];
check_primal_path(A, b, c, cycle, 'first', zeros(1, 7), tol);
assert(isequal(cycle(1, :), cycle(end, :)));
[~, ~, ~, initialX, ~] = basis_data(A, b, c, cycle(1, :), tol);
for step = 1:size(cycle, 1)
    [~, ~, ~, x, ~] = basis_data(A, b, c, cycle(step, :), tol);
    assert(norm(x - initialX, Inf) <= tol);
end
bland = [1, 2, 3; 4, 2, 3; 4, 5, 3; 6, 5, 3; ...
         6, 1, 3; 6, 1, 2; 6, 1, 4];
lex = [1, 2, 3; 1, 4, 3; 1, 4, 6];
check_primal_path(A, b, c, bland, 'bland', [0, 0, 0, 0, 0, 1/2, 5/4], tol);
check_primal_path(A, b, c, lex, 'lex', [0, 0, 5/4], tol);
expectedX = [3/4; 0; 0; 1; 0; 1; 0];
expectedQ = [0; 3/2; 5/4; 0; 2; 0; 21/2];
for B = {bland(end, :), lex(end, :)}
    [~, ~, q, x, value] = basis_data(A, b, c, B{1}, tol);
    assert(norm(x - expectedX, Inf) <= tol && abs(value - 5/4) <= tol);
    assert(norm(q - expectedQ, Inf) <= tol && all(q >= -tol));
end
fprintf('Cycling: six zero steps return to the initial basis\n');
fprintf('Anti-cycling: Bland = 6 pivots, lexicographic = 2, optimum = 5/4\n');

%% Klee-Minty: verify Dantzig's choices and all eight vertices for p = 5.
A = [1, 0, 0, 1, 0, 0; 4, 1, 0, 0, 1, 0; 8, 4, 1, 0, 0, 1];
b = [5; 25; 125];
c = [4; 2; 1; 0; 0; 0];
bases = [4, 5, 6; 1, 5, 6; 1, 2, 6; 4, 2, 6; ...
         4, 2, 3; 1, 2, 3; 1, 5, 3; 4, 5, 3];
values = [0, 20, 30, 50, 75, 95, 105, 125];
vertices = [0, 0, 0; 5, 0, 0; 5, 5, 0; 0, 25, 0; ...
            0, 25, 25; 5, 5, 65; 5, 0, 85; 0, 0, 125];
check_primal_path(A, b, c, bases, 'first', values, tol);
for step = 1:size(bases, 1)
    [~, ~, ~, x, ~] = basis_data(A, b, c, bases(step, :), tol);
    assert(norm(x(1:3) - vertices(step, :)', Inf) <= tol);
end
[~, ~, q, ~, ~] = basis_data(A, b, c, bases(end, :), tol);
assert(all(q >= -tol));
fprintf('Klee-Minty: 8 vertices, 7 pivots, maximum = 125\n');

%% Mixed signs: feasible primal and dual points with equal values.
A = [1, -6, 1; 5, 7, -2];
b = [2; -4];
c = [8; 3; -2];
x = [0; 0; 2];
y = [0; 1];
assert(x(1) <= tol && x(2) >= -tol);
assert(A(1, :) * x >= b(1) - tol && abs(A(2, :) * x - b(2)) <= tol);
assert(y(1) <= tol);
assert(A(:, 1)' * y <= c(1) + tol && A(:, 2)' * y >= c(2) - tol);
assert(abs(A(:, 3)' * y - c(3)) <= tol && abs(c' * x - b' * y) <= tol);

%% Production: basis multipliers, complementarity, and the valid RHS interval.
A = [2, 1; 3, 3; 1.5, 0];
b = [10; 24; 6];
c = [3; 2];
standardA = [A, eye(3)];
standardC = [c; zeros(3, 1)];
B = [2, 5, 1];
y = standardA(:, B)' \ standardC(B);
assert(norm(y - [1; 1/3; 0], Inf) <= tol);
[~, ~, q, fullX, value] = basis_data(standardA, b, standardC, B, tol);
assert(norm(q(3:5) - y, Inf) <= tol);
check_minmax_pair(A, b, c, fullX(1:2), y, false, 18, tol);
assert(abs(value - 18) <= tol);
for delta = [-2, -1, 0, 1, 2]
    changedB = b + [delta; 0; 0];
    [~, rhs, q, x, value] = basis_data(standardA, changedB, standardC, B, tol);
    assert(all(rhs >= -tol) && all(q >= -tol));
    assert(norm(x(B) - [6-delta; 3-1.5*delta; 2+delta], Inf) <= tol);
    check_minmax_pair(A, changedB, c, x(1:2), y, false, 18+delta, tol);
    assert(abs(value - 18 - delta) <= tol);
end
for delta = [-3, 3]
    [~, rhs, q, ~, ~] = basis_data(standardA, b + [delta; 0; 0], standardC, B, tol);
    assert(any(rhs < -tol) && all(q >= -tol));
end
fprintf('Production: dual y = (1, 1/3, 0), value = 18; RHS interval [-2, 2]\n');

%% Complementary slackness: the candidate and its entire optimal segment.
A = [1, 2, 0, 1, 0; 0, 1, 1, -1, 0; 0, 1, 0, 0, 1];
b = [4; 2; 1];
c = [1; 4; 2; 2; 8];
y = [1; 2; 0];
assert(norm(c - A' * y - [0; 0; 0; 3; 8], Inf) <= tol);
for parameter = [1, 1.25, 1.5, 1.75, 2]
    x = [4-2*parameter; parameter; 2-parameter; 0; 0];
    check_minmax_pair(A, b, c, x, y, true, 8, tol);
end
fprintf('Complementarity: candidate and optimal segment have minimum = 8\n');

%% Dual simplex: choose the negative row, preserve q, and certify the minimum.
originalA = [1, 2, 1; 2, 1, -1];
b = [2; 10];
c = [1; 1; 1];
A = [-originalA, eye(2)];
maxC = [-c; 0; 0];
B = [4, 5];
[Abar, rhs, q, ~, value] = basis_data(A, -b, maxC, B, tol);
assert(all(q >= -tol) && any(rhs < -tol) && abs(value) <= tol);
[~, pivotRow] = min(rhs);
assert(pivotRow == 2);
eligible = find(Abar(pivotRow, :) < -tol);
ratios = q(eligible)' ./ (-Abar(pivotRow, eligible));
[alpha, index] = min(ratios);
entering = eligible(index);
assert(entering == 1 && abs(alpha - 1/2) <= tol);
nextB = B;
nextB(pivotRow) = entering;
[nextAbar, nextRhs, nextQ, x, nextValue] = basis_data(A, -b, maxC, nextB, tol);
assert(all(nextRhs >= -tol) && all(nextQ >= -tol));
assert(norm(x - [5; 0; 0; 3; 0], Inf) <= tol && abs(nextValue + 5) <= tol);
expectedTable = [0, -1.5, -1.5, 1, -0.5, 3; ...
                 1, 0.5, -0.5, 0, -0.5, 5; ...
                 0, 0.5, 1.5, 0, 0.5, -5];
assert(norm([nextAbar, nextRhs; nextQ', nextValue] - expectedTable, Inf) <= tol);
assert(norm(nextQ - q - alpha * Abar(pivotRow, :)', Inf) <= tol);
assert(abs(nextValue - value - alpha * rhs(pivotRow)) <= tol);
y = A(:, nextB)' \ maxC(nextB);
assert(norm(y - [0; 1/2], Inf) <= tol);
check_minmax_pair(originalA, b, c, x(1:3), y, true, 5, tol);
% Wrong candidate column 2 would have alpha = 1 and destroy dual feasibility.
wrongQ = q + Abar(pivotRow, :)';
assert(abs(wrongQ(1) + 1) <= tol);
fprintf('Dual simplex: one pivot, minimum = 5, dual y = (0, 1/2)\n');

%% An infeasible-row certificate and an improving feasible dual ray.
A = [1, 1];
b = -1;
c = [0; 0];
[Abar, rhs, q, ~, ~] = basis_data(A, b, c, 1, tol);
assert(all(q >= -tol) && rhs < -tol && all(Abar >= -tol));
h = A(:, 1)' \ 1;
assert(all(A' * h >= -tol) && b' * h < -tol);
for lambda = [0, 1, 10]
    dualPoint = lambda * h;
    assert(all(A' * dualPoint >= c - tol));
    assert(abs(b' * dualPoint + lambda) <= tol);
end
fprintf('Infeasibility: h*A >= 0 and h*b = -1 certify the contradictory row\n');
fprintf('All Lecture 4 numerical assertions passed.\n');

function [Abar, rhs, q, x, value] = basis_data(A, b, c, B, tol)
    AB = A(:, B);
    assert(rank(AB) == size(A, 1), 'Singular basis.');
    Abar = AB \ A;
    rhs = AB \ b;
    y = AB' \ c(B);
    q = A' * y - c;
    x = zeros(size(A, 2), 1);
    x(B) = rhs;
    value = c' * x;
    % No nonnegativity assumption here: dual-simplex starts can be infeasible.
    assert(norm(A * x - b, Inf) <= tol, 'Equality residual.');
    assert(norm(Abar(:, B) - eye(numel(B)), Inf) <= tol);
    assert(norm(q(B), Inf) <= tol && abs(value - b' * y) <= tol);
end

function check_primal_path(A, b, c, bases, rule, expectedValues, tol)
    for step = 1:size(bases, 1)
        B = bases(step, :);
        [Abar, rhs, q, x, value] = basis_data(A, b, c, B, tol);
        assert(all(rhs >= -tol) && abs(value - expectedValues(step)) <= tol);
        if step == size(bases, 1)
            return;
        end
        eligible = find(q < -tol);
        assert(~isempty(eligible));
        if strcmp(rule, 'bland')
            entering = eligible(1);
        else
            [~, index] = min(q(eligible));
            entering = eligible(index);
        end
        u = Abar(:, entering);
        rows = find(u > tol);
        assert(~isempty(rows));
        theta = min(rhs(rows) ./ u(rows));
        tied = rows(abs(rhs(rows) ./ u(rows) - theta) <= tol);
        pivotRow = tied(1); % First row only for the demonstrated cycling rule.
        if strcmp(rule, 'bland')
            [~, index] = min(B(tied));
            pivotRow = tied(index);
        elseif strcmp(rule, 'lex')
            for row = tied(:)'
                candidate = [rhs(row), Abar(row, :)] / u(row);
                current = [rhs(pivotRow), Abar(pivotRow, :)] / u(pivotRow);
                first = find(abs(candidate - current) > tol, 1);
                if ~isempty(first) && candidate(first) < current(first)
                    pivotRow = row;
                end
            end
        end
        nextB = B;
        nextB(pivotRow) = entering;
        assert(isequal(nextB, bases(step+1, :)), 'Unexpected pivot choice.');
        [~, ~, ~, nextX, nextValue] = basis_data(A, b, c, nextB, tol);
        direction = zeros(size(A, 2), 1);
        direction(B) = -u;
        direction(entering) = 1;
        assert(norm(nextX - x - theta * direction, Inf) <= tol);
        assert(abs(nextValue - value + theta * q(entering)) <= tol);
    end
end

function check_minmax_pair(A, b, c, x, y, isMin, expectedValue, tol)
    if isMin
        primalSlack = A * x - b;
        dualSlack = c - A' * y;
        gap = c' * x - b' * y;
    else
        primalSlack = b - A * x;
        dualSlack = A' * y - c;
        gap = b' * y - c' * x;
    end
    assert(all(x >= -tol) && all(y >= -tol));
    assert(all(primalSlack >= -tol) && all(dualSlack >= -tol));
    assert(norm(y .* primalSlack, Inf) <= tol);
    assert(norm(x .* dualSlack, Inf) <= tol);
    assert(abs(gap) <= tol && abs(c' * x - expectedValue) <= tol);
    assert(abs(b' * y - expectedValue) <= tol);
end
