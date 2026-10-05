% Checks for notes/exercises/01-complementarity-and-two-phase.tex.
% Source: ProgMatc1.pdf, task groups 2 and 3.
% MATLAB execution is not yet verified; record actual runs separately.
% Run from the repository root:
%   run('matlab/exercises/sheet_01_complementarity_and_two_phase.m')
% Base MATLAB only. Fixed hand-solution paths, not a general LP solver.
clear;
clc;
tol = 1e-10; % Absolute tolerance for these small, modestly scaled examples.

%% 2(a): primal candidate, complementary dual, and uniqueness constraints.
A = [4, 1, -2; 2, 1, -2; -1, 1, -1; 1, 1, -1];
b = [1; 6; 2; 3];
c = [4; 5; -8];
x = [0; 3; 1];
y = [3; 0; 2; 0];
s = b - A*x;
dualSlack = A'*y - c;
assert(all(x >= -tol) && all(s >= -tol));
assert(all(y >= -tol) && all(dualSlack >= -tol));
assert_close(s, [0; 5; 0; 1], tol);
assert_close(dualSlack, [6; 0; 0], tol);
assert_close(y.*s, zeros(4, 1), tol);
assert_close(x.*dualSlack, zeros(3, 1), tol);
assert_close(c'*x, 7, tol);
assert_close(b'*y, 7, tol);
assert_close([1, -2; 1, -1] \ [1; 2], [3; 1], tol);
fprintf('2(a): supplied point optimal, maximum 7, dual (3,0,2,0)\n');

%% 2(b): reject the supplied point before constructing an optimal pair.
A = [1, -1, -1; 0, -3, -2; 1, -1, 1];
b = [-1; -4; 4];
c = [6; 2; -3];
supplied = [2; 0; -2];
assert(supplied(3) < -tol);
assert(A(3, :)*supplied < b(3) - tol);
x = [2; 0; 2];
y = [0; 9/2; 6];
s = A*x - b;
dualSlack = c - A'*y;
assert(all(x >= -tol) && all(s >= -tol));
assert(all(y >= -tol) && all(dualSlack >= -tol));
assert_close(s, [1; 0; 0], tol);
assert_close(dualSlack, [0; 43/2; 0], tol);
assert_close(y.*s, zeros(3, 1), tol);
assert_close(x.*dualSlack, zeros(3, 1), tol);
assert_close(c'*x, 6, tol);
assert_close(b'*y, 6, tol);
fprintf('2(b): supplied point infeasible; actual minimum 6, dual (0,9/2,6)\n');

%% 2(c): a mixed-sign dual and the complete optimal segment.
A = [-1, 1, 1, 1; 2, 1, 2, 2; 1, 1, -1, 1];
b = [3; 10; 2];
c = [2; 1; -3; 1];
y = [-1; 0; 2];
dualSlack = A'*y - c;
assert(y(1) <= tol && all(y(2:3) >= -tol));
assert_close(dualSlack, [1; 0; 0; 0], tol);
assert_close(b'*y, 1, tol);
for parameter = [0, 1/2, 1, 5/2]
    x = [0; 5/2-parameter; 1/2; parameter];
    rowValues = A*x;
    s = [rowValues(1)-b(1); b(2:3)-rowValues(2:3)];
    assert(all(x >= -tol) && all(s >= -tol));
    assert_close(abs(y).*s, zeros(3, 1), tol);
    assert_close(x.*dualSlack, zeros(4, 1), tol);
    assert_close(c'*x, 1, tol);
end
fprintf('2(c): supplied point optimal, maximum 1, full segment checked\n');

%% 3(a), Phase I: all three complete tableaus.
% Column order: (x1,x2,x3,s1,s2,s3,a2,a3).
M = [1, 0, 1, 1, 0, 0, 0, 0; ...
     1, 3, 1, 0, -1, 0, 1, 0; ...
     1, 2, -1, 0, 0, -1, 0, 1];
b = [12; 4; 6];
dI = [0; 0; 0; 0; 0; 0; -1; -1];
BI = [4, 7, 8; 4, 2, 8; 4, 2, 5];
expected = {M, ...
    [1, 0, 1, 1, 0, 0, 0, 0; ...
     1/3, 1, 1/3, 0, -1/3, 0, 1/3, 0; ...
     1/3, 0, -5/3, 0, 2/3, -1, -2/3, 1], ...
    [1, 0, 1, 1, 0, 0, 0, 0; ...
     1/2, 1, -1/2, 0, 0, -1/2, 0, 1/2; ...
     1/2, 0, -5/2, 0, 1, -3/2, -1, 3/2]};
expectedRhs = [12, 4, 6; 12, 4/3, 10/3; 12, 3, 5];
expectedQ = [-2, -5, 0, 0, 1, 1, 0, 0; ...
             -1/3, 0, 5/3, 0, -2/3, 1, 5/3, 0; ...
              0, 0, 0, 0, 0, 0, 1, 1];
expectedValues = [-10, -10/3, 0];
for iteration = 1:3
    [barM, rhs, q, v, value] = basis_data(M, b, dI, BI(iteration, :), tol);
    assert_close(barM, expected{iteration}, tol);
    assert_close(rhs, expectedRhs(iteration, :)', tol);
    assert_close(q, expectedQ(iteration, :)', tol);
    assert_close(value, expectedValues(iteration), tol);
    if iteration == 3
        assert_close(v(7:8), [0; 0], tol);
        assert(all(q >= -tol));
    end
end
check_pivot(M, b, dI, BI(1, :), 2, 2, 4/3, BI(2, :), tol);
check_pivot(M, b, dI, BI(2, :), 5, 3, 5, BI(3, :), tol);

%% 3(a), Phase II: no extra pivot is necessary.
MII = M(:, 1:6);
dII = [-1; -2; 1; 0; 0; 0];
[barM, rhs, q, v, value] = basis_data(MII, b, dII, BI(3, :), tol);
assert_close(barM, expected{3}(:, 1:6), tol);
assert_close(rhs, [12; 3; 5], tol);
assert_close(q, [0; 0; 0; 0; 0; 1], tol);
assert_close(v, [0; 3; 0; 12; 5; 0], tol);
assert_close(value, -6, tol);
assert(all(q >= -tol));
A = [1, 0, 1; 1, 3, 1; 1, 2, -1];
c = [-1; -2; 1];
y = [0; 0; -1];
assert(y(1) >= -tol && all(y(2:3) <= tol));
assert_close(A'*y, c, tol);
assert_close(b'*y, -6, tol);
for parameter = [0, 1, 3, 6]
    x = [parameter; 3-parameter/2; 0];
    rowValues = A*x;
    s = [b(1)-rowValues(1); rowValues(2:3)-b(2:3)];
    assert(all(x >= -tol) && all(s >= -tol));
    assert_close(abs(y).*s, zeros(3, 1), tol);
    assert_close(c'*x, -6, tol);
end
fprintf('3(a): Phase I steps 4/3,5; Phase II maximum -6, dual (0,0,-1)\n');

%% 3(b), Phase I: substitute t=-x3 and reverse rows with negative RHS.
% Column order: (x1,x2,t,s1,s2,s3,a3).
M = [-1, 1, 1, 1, 0, 0, 0; ...
     -1, -2, 2, 0, 1, 0, 0; ...
      1, -1, 1, 0, 0, -1, 1];
b = [1; 4; 4];
dI = [0; 0; 0; 0; 0; 0; -1];
BI = [4, 5, 7; 4, 5, 1];
expected = {M, ...
    [0, 0, 2, 1, 0, -1, 1; ...
     0, -3, 3, 0, 1, -1, 1; ...
     1, -1, 1, 0, 0, -1, 1]};
expectedRhs = [1, 4, 4; 5, 8, 4];
expectedQ = [-1, 1, -1, 0, 0, 1, 0; 0, 0, 0, 0, 0, 0, 1];
for iteration = 1:2
    [barM, rhs, q, v, value] = basis_data(M, b, dI, BI(iteration, :), tol);
    assert_close(barM, expected{iteration}, tol);
    assert_close(rhs, expectedRhs(iteration, :)', tol);
    assert_close(q, expectedQ(iteration, :)', tol);
    assert_close(value, -4*(2-iteration), tol);
    if iteration == 2
        assert_close(v(7), 0, tol);
        assert(all(q >= -tol));
    end
end
check_pivot(M, b, dI, BI(1, :), 1, 3, 4, BI(2, :), tol);

%% 3(b), Phase II: maximize minus the original minimization objective.
MII = M(:, 1:6);
dII = [-2; 2; 1; 0; 0; 0];
BII = [4, 5, 1; 3, 5, 1];
expectedFinal = [0, 0, 1, 1/2, 0, -1/2; ...
                 0, -3, 0, -3/2, 1, 1/2; ...
                 1, -1, 0, -1/2, 0, -1/2];
[barM, rhs, q, ~, value] = basis_data(MII, b, dII, BII(1, :), tol);
assert_close(barM, expected{2}(:, 1:6), tol);
assert_close(rhs, [5; 8; 4], tol);
assert_close(q, [0; 0; -3; 0; 0; 2], tol);
assert_close(value, -8, tol);
check_pivot(MII, b, dII, BII(1, :), 3, 1, 5/2, BII(2, :), tol);
[barM, rhs, q, v, value] = basis_data(MII, b, dII, BII(2, :), tol);
assert_close(barM, expectedFinal, tol);
assert_close(rhs, [5/2; 1/2; 3/2], tol);
assert_close(q, [0; 0; 0; 3/2; 0; 1/2], tol);
assert_close(v, [3/2; 0; 5/2; 0; 1/2; 0], tol);
assert_close(value, -1/2, tol);
assert(all(q >= -tol));
A = [1, -1, 1; 1, 2, 2; 1, -1, -1];
originalB = [-1; -4; 4];
c = [2; -2; 1];
x = [v(1:2); -v(3)];
y = [3/2; 0; 1/2];
assert_close(c'*x, -value, tol);
assert(all(y >= -tol));
columnValues = A'*y;
assert(all(columnValues(1:2) <= c(1:2) + tol));
assert(columnValues(3) >= c(3) - tol);
assert_close(originalB'*y, 1/2, tol);
dualSlack = [c(1:2)-columnValues(1:2); columnValues(3)-c(3)];
assert_close(dualSlack, zeros(3, 1), tol);
for parameter = [0, 1/2, 1, 10]
    x = [3/2+parameter; parameter; -5/2];
    s = A*x - originalB;
    assert(all(x(1:2) >= -tol) && x(3) <= tol);
    assert_close(s, [0; 1/2+3*parameter; 0], tol);
    assert(all(s >= -tol));
    assert_close(y.*s, zeros(3, 1), tol);
    assert_close(abs(x).*dualSlack, zeros(3, 1), tol);
    assert_close(c'*x, 1/2, tol);
end
ray = [1; 1; 0];
assert(all(A*ray >= -tol));
assert_close(c'*ray, 0, tol);
fprintf('3(b): Phase I step 4, Phase II step 5/2; original minimum 1/2\n');
fprintf('3(b): dual (3/2,0,1/2), constant-objective optimal ray checked\n');
fprintf('All complementary certificates and displayed tableaus passed at tol = %.1e\n', tol);

function assert_close(actual, expected, tol)
    assert(isequal(size(actual), size(expected)));
    assert(all(abs(actual(:)-expected(:)) <= tol));
end

function [barM, rhs, q, v, value] = basis_data(M, b, d, B, tol)
    basisMatrix = M(:, B);
    assert(rcond(basisMatrix) > tol);
    barM = basisMatrix \ M;
    rhs = basisMatrix \ b;
    q = barM'*d(B)-d;
    v = zeros(size(M, 2), 1);
    v(B) = rhs;
    value = d'*v;
    assert(all(rhs >= -tol));
    assert_close(M*v, b, tol);
    assert_close(barM(:, B), eye(length(B)), tol);
    assert_close(q(B), zeros(length(B), 1), tol);
end

function check_pivot(M, b, d, B, entering, leavingRow, step, nextB, tol)
    [barM, rhs, q, v, value] = basis_data(M, b, d, B, tol);
    nonbasic = setdiff(1:size(M, 2), B);
    minimumQ = min(q(nonbasic));
    tied = nonbasic(abs(q(nonbasic)-minimumQ) <= tol);
    assert(entering == min(tied) && q(entering) < -tol);
    column = barM(:, entering);
    eligible = find(column > tol);
    ratios = rhs(eligible)./column(eligible);
    assert_close(step, min(ratios), tol);
    assert(column(leavingRow) > tol);
    assert_close(rhs(leavingRow)/column(leavingRow), step, tol);
    replacement = B;
    replacement(leavingRow) = entering;
    assert(isequal(replacement, nextB));
    direction = zeros(size(v));
    direction(B) = -column;
    direction(entering) = 1;
    assert_close(M*direction, zeros(size(b)), tol);
    assert_close(d'*direction, -q(entering), tol);
    [~, ~, ~, nextV, nextValue] = basis_data(M, b, d, nextB, tol);
    assert_close(nextV, v + step*direction, tol);
    assert_close(nextValue, value-step*q(entering), tol);
end
