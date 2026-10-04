% Checks accompanying notes/lectures/03-simplex-method.tex.
% Inputs: s4_w3.pdf slides 8, 12, 24-31, 39-44, plus added counterexamples.
% MATLAB execution is pending; see docs/matlab-verification.md.
% Run from the repository root:
%   run('matlab/exercises/lecture_03_checks.m')
% Base MATLAB only. This checks specified paths, not a general LP solver.
clear;
clc;
tol = 1e-10; % Absolute tolerance for these small, modestly scaled examples.

%% Basic versus feasible: all three candidates solve the same equations.
A = [2, 1, 3, 0, 0, 1; 1, 0, 2, 0, 1, 1; 3, 0, 1, 1, 0, 2];
b = [8; 5; 4];
candidates = [0, 0, 0; 8, 1/2, 0; 0, 5/2, 0; 4, 3/2, -12; ...
    5, 0, -3; 0, 0, 8];
bases = {[2, 5, 4], [2, 3, 4], [4, 5, 6]};
for k = 1:numel(bases)
    B = bases{k};
    assert(rank(A(:, B)) == 3);
    actual = zeros(6, 1);
    actual(B) = A(:, B) \ b;
    assert(norm(actual - candidates(:, k), Inf) <= tol);
    assert(norm(A * actual - b, Inf) <= tol);
end
assert(all(candidates(:, 1) >= 0) && all(candidates(:, 2) >= 0));
assert(any(candidates(:, 3) < 0));

%% Production: independently recompute each basis and verify every pivot.
A = [2, 1, 1, 0, 0; 3, 3, 0, 1, 0; 1.5, 0, 0, 0, 1];
b = [10; 24; 6];
c = [3; 2; 0; 0; 0];
bases = {[3, 4, 5], [3, 4, 1], [2, 4, 1], [2, 5, 1]};
points = [0, 4, 4, 2; 0, 0, 2, 6; 10, 2, 0, 0; ...
    24, 12, 6, 0; 6, 0, 0, 3];
values = [0, 12, 16, 18];
for k = 1:numel(bases)
    [~, ~, ~, x, value] = checked_basis(A, b, c, bases{k}, tol);
    assert(norm(x - points(:, k), Inf) <= tol);
    assert(abs(value - values(k)) <= tol);
end
check_pivot(A, b, c, bases{1}, 1, 5, 4, bases{2}, tol);
check_pivot(A, b, c, bases{2}, 2, 3, 2, bases{3}, tol);
check_pivot(A, b, c, bases{3}, 5, 4, 3, bases{4}, tol);
[~, ~, q, ~, ~] = checked_basis(A, b, c, bases{4}, tol);
assert(norm(q - [0; 0; 1; 1/3; 0], Inf) <= tol);
assert(all(q([3, 4]) > tol)); % Strict nonbasic indicators certify uniqueness.
weights = A(:, bases{4})' \ c(bases{4});
assert(norm(A' * weights - c - q, Inf) <= tol);
assert(abs(b' * weights - 18) <= tol);
% Alternative first pivot from the study question.
check_pivot(A, b, c, [3, 4, 5], 2, 4, 8, [3, 2, 5], tol);
check_pivot(A, b, c, [3, 2, 5], 1, 3, 2, [1, 2, 5], tol);
fprintf('Production: revenue sequence = 0, 12, 16, 18 PLN\n');

%% Unbounded example: validate the point, direction, and objective slope.
A = [1, 2, -1, -1, 1, 0; 2, -2, 3, -3, 0, 1];
b = [4; 9];
c = [3; 1; -3; -1; 0; 0];
check_pivot(A, b, c, [5, 6], 1, 5, 4, [1, 6], tol);
[Abar, ~, q, x, value] = checked_basis(A, b, c, [1, 6], tol);
assert(q(4) < -tol && all(Abar(:, 4) <= tol));
d = zeros(6, 1);
d([1, 6]) = -Abar(:, 4);
d(4) = 1;
assert(norm(d - [1; 0; 0; 1; 0; 1], Inf) <= tol);
assert(norm(A * d, Inf) <= tol && all(d >= -tol));
assert(abs(c' * d - 2) <= tol && abs(value - 12) <= tol);
for theta = [0, 1, 100]
    candidate = x + theta * d;
    assert(all(candidate >= -tol));
    assert(norm(A * candidate - b, Inf) <= tol);
    assert(abs(c' * candidate - (12 + 2 * theta)) <= tol);
end
fprintf('Unbounded ray: Ad = 0, d >= 0, objective slope = 2\n');

%% Two-phase Start A: two artificials and two Phase I pivots.
originalA = [1, 1, 1, 1; 1, 0, 1, -3];
b = [1; 1/2];
originalC = [-1; -2; -3; -4];
A = [originalA, eye(2)];
phaseC = [zeros(4, 1); -1; -1];
bases = {[5, 6], [5, 1], [4, 1]};
phaseValues = [-3/2, -1/2, 0];
for k = 1:numel(bases)
    [~, ~, ~, ~, value] = checked_basis(A, b, phaseC, bases{k}, tol);
    assert(abs(value - phaseValues(k)) <= tol);
end
check_pivot(A, b, phaseC, bases{1}, 1, 6, 1/2, bases{2}, tol);
check_pivot(A, b, phaseC, bases{2}, 4, 5, 1/8, bases{3}, tol);
[~, ~, q, x, ~] = checked_basis(A, b, phaseC, bases{3}, tol);
assert(all(q >= -tol) && norm(x(5:6), Inf) <= tol);
[~, ~, q, xA, valueA] = checked_basis(originalA, b, originalC, [4, 1], tol);
assert(norm(q - [0; 1/4; 2; 0], Inf) <= tol);
assert(abs(valueA + 11/8) <= tol);

%% Two-phase Start B: reuse x2, then improve the original objective.
A = [originalA, [0; 1]];
phaseC = [zeros(4, 1); -1];
check_pivot(A, b, phaseC, [2, 5], 1, 5, 1/2, [2, 1], tol);
[~, ~, q, x, value] = checked_basis(A, b, phaseC, [2, 1], tol);
assert(all(q >= -tol) && abs(value) <= tol && abs(x(5)) <= tol);
[~, ~, q, ~, value] = checked_basis(originalA, b, originalC, [2, 1], tol);
assert(abs(value + 3/2) <= tol && abs(q(4) + 1) <= tol);
check_pivot(originalA, b, originalC, [2, 1], 4, 2, 1/8, [4, 1], tol);
[~, ~, ~, xB, valueB] = checked_basis(originalA, b, originalC, [4, 1], tol);
assert(norm(xA - xB, Inf) <= tol && abs(valueA - valueB) <= tol);
assert(norm(xB - [7/8; 0; 0; 1/8], Inf) <= tol);
fprintf('Two-phase: both starts give x = (7/8, 0, 0, 1/8), z = -11/8\n');

%% Big M on the equality example: a sufficient finite penalty for these data.
A = [originalA, eye(2)];
penaltyC = [originalC; -10; -10];
check_pivot(A, b, penaltyC, [5, 6], 1, 6, 1/2, [5, 1], tol);
check_pivot(A, b, penaltyC, [5, 1], 4, 5, 1/8, [4, 1], tol);
[~, ~, q, x, value] = checked_basis(A, b, penaltyC, [4, 1], tol);
assert(all(q >= -tol) && norm(x(5:6), Inf) <= tol);
assert(abs(value + 11/8) <= tol);
assert(norm(q - [0; 1/4; 2; 0; 10-7/4; 10+3/4], Inf) <= tol);

%% Degeneracy: an optimal point can have an uncertifying basis.
[~, rhs, q, x, ~] = checked_basis([1, 1], 0, [0; 1], 1, tol);
assert(abs(rhs) <= tol && norm(x, Inf) <= tol && q(2) < -tol);
check_pivot([1, 1], 0, [0; 1], 1, 2, 1, 0, 2, tol);
[~, ~, q, ~, ~] = checked_basis([1, 1], 0, [0; 1], 2, tol);
assert(q(1) > tol);
[~, ~, q, ~, ~] = checked_basis([1, 1], 0, [0; 0], 1, tol);
assert(abs(q(2)) <= tol); % Still only the singleton feasible set.

%% Infeasible inequalities: feasible Phase I point and optimal certificate.
% Order: x, surplus s, slack t, artificial a1, artificial a2.
A = [1, -1, 0, 1, 0; 1, 0, 1, 0, 1];
b = [2; 1];
phaseC = [0; 0; 0; -1; -1];
[~, ~, q, x, value] = checked_basis(A, b, phaseC, [4, 1], tol);
assert(all(q >= -tol));
assert(norm(x - [1; 0; 0; 1; 0], Inf) <= tol && abs(value + 1) <= tol);
fprintf('Infeasible original inequalities: Phase I optimum w = 1\n');

%% Big M counterexample: insufficient finite penalty retains an artificial.
K = 100;
M = 10;
[~, ~, q, x, value] = checked_basis([1, 1], 1, [-K; -M], 2, tol);
assert(all(q >= -tol) && norm(x - [0; 1], Inf) <= tol);
assert(abs(value + 10) <= tol && value > -K);
% Positive artificial on an augmented ray does not imply infeasibility.
A = [1, -1, 1];
augmentedPoint = [0; 0; 1];
originalPoint = [1; 0; 0];
d = [1; 1; 0];
assert(A * augmentedPoint == 1 && A * originalPoint == 1 && A * d == 0);
assert([1, 0, -M] * d > 0);
fprintf('All Lecture 3 numerical assertions passed.\n');

function [Abar, bbar, q, x, value] = checked_basis(A, b, c, B, tol)
    AB = A(:, B);
    assert(rank(AB) == size(A, 1), 'Singular basis.');
    Abar = AB \ A;
    bbar = AB \ b;
    q = Abar' * c(B) - c;
    x = zeros(size(A, 2), 1);
    x(B) = bbar;
    value = c' * x;
    assert(all(x >= -tol), 'Infeasible basis.');
    assert(norm(A * x - b, Inf) <= tol, 'Constraint residual.');
    assert(norm(Abar(:, B) - eye(numel(B)), Inf) <= tol);
    assert(norm(q(B), Inf) <= tol, 'Nonzero basic indicator.');
end

function check_pivot(A, b, c, B, entering, leaving, expectedStep, nextB, tol)
    [Abar, bbar, q, x, value] = checked_basis(A, b, c, B, tol);
    assert(~ismember(entering, B) && q(entering) < -tol);
    u = Abar(:, entering);
    rows = find(u > tol);
    assert(~isempty(rows), 'Expected a finite step.');
    ratios = bbar(rows) ./ u(rows);
    step = min(ratios);
    tiedRows = rows(abs(ratios - step) <= tol);
    % For a tied minimum, choose the smallest original basic variable index.
    [~, tieIndex] = min(B(tiedRows));
    pivotRow = tiedRows(tieIndex);
    assert(B(pivotRow) == leaving && abs(step - expectedStep) <= tol);
    replacement = B;
    replacement(pivotRow) = entering;
    assert(isequal(replacement, nextB));
    [nextAbar, nextBbar, nextQ, nextX, nextValue] = ...
        checked_basis(A, b, c, nextB, tol);
    d = zeros(size(A, 2), 1);
    d(B) = -u;
    d(entering) = 1;
    assert(norm(nextX - x - step * d, Inf) <= tol);
    assert(abs(nextValue - value + q(entering) * step) <= tol);
    % Verify Gauss-Jordan updates against the separately solved next basis.
    tableau = [Abar, bbar; q', value];
    tableau(pivotRow, :) = tableau(pivotRow, :) / tableau(pivotRow, entering);
    for row = 1:size(tableau, 1)
        if row ~= pivotRow
            tableau(row, :) = tableau(row, :) - ...
                tableau(row, entering) * tableau(pivotRow, :);
        end
    end
    assert(norm(tableau - [nextAbar, nextBbar; nextQ', nextValue], Inf) <= tol);
end
