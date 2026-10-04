% Lecture 5: sensitivity, structural updates, and KKT certificates.
% Base MATLAB only. Run from the repository root.
% Execution status is documented in docs/matlab-verification.md.
clear;
tol = 1e-10;

%% One-parameter sensitivity and the full second-RHS value function.
A = [3 -1 2 1 0 0; -2 4 0 0 1 0; -4 3 8 0 0 1];
b = [7; 12; 10];
c = [-1; 3; -2; 0; 0; 0];
B = [1 2 6];
[T, basic, q, x, value, y] = basis_data(A, b, c, B, tol);
assert(norm(basic - [4; 5; 11], inf) < tol);
assert(norm(q - [0; 0; 12/5; 1/5; 4/5; 0], inf) < tol);
assert(norm(y - [1/5; 4/5; 0], inf) < tol);
assert(abs(value - 11) < tol);

v = A(:, B) \ [0; 1; 0];
lower = max(-basic(v > tol) ./ v(v > tol));
upper = min(-basic(v < -tol) ./ v(v < -tol));
assert(abs(lower + 50/3) < tol && abs(upper - 22) < tol);
for t = [lower, -10, 0, 10, upper]
    changedB = b + [0; t; 0];
    [~, basicNew, qNew, ~, newValue] = basis_data(A, changedB, c, B, tol);
    assert(all(basicNew >= -tol) && norm(qNew - q, inf) < tol);
    assert(norm(basicNew - (basic + t*v), inf) < tol);
    assert(abs(newValue - (11 + 4*t/5)) < tol);
    assert(abs(enumerated_maximum(A, changedB, c, tol) - newValue) < tol);
end
for r = [-14/3, -4, 0, 12, 34, 40]
    expected = min((4*r + 7)/5, 143/5);
    actual = enumerated_maximum(A, [7; r; 10], c, tol);
    assert(abs(actual - expected) < tol);
end
% Infeasibility is also proved by the exact inequality in the notes.
assert(isempty(enumerated_maximum(A, [7; -5; 10], c, tol)));

% Cost interval endpoints and samples inside each valid half-line.
for change = [-1/2, 0, 2]
    newCost = c; newCost(1) = c(1) + change;
    [~, ~, indicators, ~, newValue] = basis_data(A, b, newCost, B, tol);
    assert(all(indicators >= -tol) && abs(newValue - (11 + 4*change)) < tol);
    assert(abs(enumerated_maximum(A, b, newCost, tol) - newValue) < tol);
end
for change = [-1, 0, 2]
    newCost = c; newCost(2) = c(2) + change;
    [~, ~, indicators, ~, newValue] = basis_data(A, b, newCost, B, tol);
    assert(all(indicators >= -tol) && abs(newValue - (11 + 5*change)) < tol);
    assert(abs(enumerated_maximum(A, b, newCost, tol) - newValue) < tol);
end
newCost = c; newCost(3) = 2/5;
for theta = [0, 1/2, 11/10]
    candidate = x;
    candidate(3) = theta;
    candidate(B) = basic - T(:, 3)*theta;
    assert(all(candidate >= -tol) && norm(A*candidate - b, inf) < tol);
    assert(abs(newCost'*candidate - 11) < tol);
end
% Outside each range, a negative indicator has a positive feasible step here.
outsideValues = [-2; 1; 1];
for entry = [1 2 3]
    outsideCost = c;
    outsideCost(entry) = outsideValues(entry);
    [~, ~, outsideQ] = basis_data(A, b, outsideCost, B, tol);
    assert(any(outsideQ < -tol));
    assert(enumerated_maximum(A, b, outsideCost, tol) > outsideCost'*x + tol);
end
fprintf('Sensitivity: RHS change [-50/3, 22]; cost endpoints = -3/2, 2, 2/5\n');

%% Coupled RHS changes: separate intervals do not form a box.
[~, singleA] = basis_data(A, b + [0; 20; 0], c, B, tol);
[~, singleB] = basis_data(A, b + [0; 0; -10], c, B, tol);
[~, together] = basis_data(A, b + [0; 20; -10], c, B, tol);
assert(all(singleA >= -tol) && all(singleB >= -tol));
assert(norm(together - [6; 11; -9], inf) < tol);
fprintf('Simultaneous RHS changes: separately feasible, combined basic slack = -9\n');

%% Common small model, objective/RHS vector changes.
E = [1 1 1 1 0; -1 2 0 0 1];
eb = [6; 4]; ec = [2; -1; 1; 0; 0]; start = [1 5];
newCost = [3; 4; 2; 0; 0];
check_optimal(E, eb, newCost, [1 2], [8/3; 10/3; 0; 0; 0], 64/3, tol);
[T0, r0, q0, ~, z0] = basis_data(E, eb, newCost, start, tol);
assert(norm(q0 - [0; -1; 1; 3; 0], inf) < tol && abs(z0 - 18) < tol);
ratios = r0 ./ T0(:, 2);
assert(abs(min(ratios) - 10/3) < tol);
check_optimal(E, [3; 4], ec, start, [3; 0; 0; 0; 7], 6, tol);
bothCost = [4; -1; 1; 0; 0];
check_optimal(E, [3; 4], bothCost, start, [3; 0; 0; 0; 7], 12, tol);
deltaB = [-3; 0]; deltaC = bothCost - ec;
[~, ~, ~, oldX, oldValue, oldY] = basis_data(E, eb, ec, start, tol);
crossTerm = deltaC(start)' * (E(:, start) \ deltaB);
assert(abs(crossTerm + 6) < tol);
assert(abs(oldValue + oldY'*deltaB + oldX'*deltaC + crossTerm - 12) < tol);
% The canonical row 3*x2 + x3 + x4 + x5 = -2 proves infeasibility.
[badT, badRhs, badQ] = basis_data(E, [6; -8], ec, start, tol);
assert(badRhs(2) < -tol && all(badT(2, :) >= -tol) && all(badQ >= -tol));
assert(isempty(enumerated_maximum(E, [6; -8], ec, tol)));
fprintf('Vector updates: new-cost value = 64/3; new-RHS value = 6; joint value = 12\n');

%% Add a variable and verify the selected primal pivot.
column = [-1; 2];
extended = [E column]; extendedCost = [ec; 1];
[T0, r0, q0, ~, z0] = basis_data(extended, eb, extendedCost, start, tol);
assert(norm(T0(:, 6) - [-1; 1], inf) < tol && abs(q0(6) + 3) < tol);
step = r0(2) / T0(2, 6);
assert(abs(step - 10) < tol && abs(z0 - q0(6)*step - 42) < tol);
check_optimal(extended, eb, extendedCost, [1 6], [16; 0; 0; 0; 0; 10], 42, tol);
% Added zero column with positive cost is an unbounded ray.
rayA = [E zeros(2, 1)]; rayC = [ec; 1];
direction = [zeros(5, 1); 1];
assert(norm(rayA*direction, inf) < tol && rayC'*direction == 1);
fprintf('Added column: x1 = 16, x6 = 10, value = 42\n');

%% Add a constraint, canonicalize, and verify the dual ratio choice.
rowA = [E zeros(2, 1); 1 0 -2 0 0 1];
rowB = [eb; -2]; rowC = [ec; 0]; rowStart = [1 5 6];
[T0, r0, q0, ~, z0] = basis_data(rowA, rowB, rowC, rowStart, tol);
assert(norm(T0(3, :) - [0 -1 -3 -1 0 1], inf) < tol);
assert(abs(r0(3) + 8) < tol && all(q0 >= -tol));
eligible = find(T0(3, :) < -tol);
dualRatios = q0(eligible) ./ (-T0(3, eligible)');
[alpha, index] = min(dualRatios);
entering = eligible(index);
assert(entering == 3 && abs(alpha - 1/3) < tol);
[~, ~, nextQ, ~, nextValue] = basis_data(rowA, rowB, rowC, [1 5 3], tol);
assert(norm(nextQ - (q0 + alpha*T0(3, :)'), inf) < tol);
assert(abs(nextValue - (z0 + alpha*r0(3))) < tol);
check_optimal(rowA, rowB, rowC, [1 5 3], [10/3; 0; 8/3; 0; 22/3; 0], 28/3, tol);
fprintf('Added row: x = (10/3, 0, 8/3), value = 28/3\n');

%% Delete variables and production constraints.
reduced = E(:, [2 3 4 5]);
check_optimal(reduced, eb, [-1; 1; 0; 0], [2 4], [0; 6; 0; 4], 6, tol);
% Positive original coordinate does not automatically imply infeasible deletion.
keepOptimum = E(:, [1 3 4 5]);
check_optimal(keepOptimum, eb, [2; 1; 0; 0], [1 4], [6; 0; 0; 10], 12, tol);
P = [2 1 1 0 0; 3 3 0 1 0; 1.5 0 0 0 1];
pb = [10; 24; 6]; pc = [3; 2; 0; 0; 0];
relaxed = [P [-1; 0; 0]]; relaxedCost = [pc; 0];
[T0, r0, q0] = basis_data(relaxed, pb, relaxedCost, [2 5 1], tol);
assert(abs(q0(6) + 1) < tol);
assert(abs(min(r0(T0(:, 6) > tol) ./ T0(T0(:, 6) > tol, 6)) - 2) < tol);
check_optimal(relaxed, pb, relaxedCost, [2 6 1], [4; 4; 0; 0; 0; 2], 20, tol);
% Drop row 3 and its original slack column.
check_optimal(P(1:2, 1:4), pb(1:2), pc(1:4), [2 1], [2; 6; 0; 0], 18, tol);
% Verify directly in the reduced model after dropping row 1 and slack x3.
check_optimal(P(2:3, [1 2 4 5]), pb(2:3), pc([1 2 4 5]), ...
    [2 1], [4; 4; 0; 0], 20, tol);
fprintf('Deletions: x1 removal gives 6; production row 3 gives 18, row 1 gives 20\n');

%% KKT: all inequalities oriented <=, including the four lower bounds.
G = [3 2 1 1; -5 2 -1 -2; -eye(4)];
gb = [20; -3; zeros(4, 1)];
h = [2 1 0 1];
candidate = [0; 17/4; 0; 23/4];
objective = [1; 3; -2; 1];
lambda = [0; 1/2; 1/2; 0; 3/2; 0];
nu = 2;
slack = gb - G*candidate;
assert(all(slack >= -tol) && abs(h*candidate - 10) < tol);
assert(all(lambda >= -tol) && norm(lambda .* slack, inf) < tol);
assert(norm(-objective + G'*lambda + h'*nu, inf) < tol);
assert(abs(objective'*candidate - 37/2) < tol);
assert(abs(gb'*lambda + 10*nu - 37/2) < tol);
% Positive multipliers force x1=x3=0 and the third row tight.
boundRows = eye(4);
uniqueMatrix = [h; G(2, :); boundRows([1 3], :)];
uniqueSolution = uniqueMatrix \ [10; -3; 0; 0];
assert(norm(uniqueSolution - candidate, inf) < tol);
fprintf('KKT: multiplier signs, stationarity, complementarity; unique maximum = 37/2\n');
fprintf('All Lecture 5 numerical assertions passed.\n');

function [T, basic, q, x, value, y] = basis_data(A, b, c, B, tol)
AB = A(:, B);
T = AB \ A;
basic = AB \ b;
y = AB' \ c(B);
q = A'*y - c;
x = zeros(size(c)); x(B) = basic;
value = c(B)'*basic;
assert(norm(A*x - b, inf) < tol);
assert(norm(T(:, B) - eye(numel(B)), inf) < tol);
assert(norm(q(B), inf) < tol && abs(b'*y - value) < tol);
end

function check_optimal(A, b, c, B, expectedX, expectedValue, tol)
[~, basic, q, x, value] = basis_data(A, b, c, B, tol);
assert(all(basic >= -tol) && all(q >= -tol));
assert(norm(x - expectedX, inf) < tol && abs(value - expectedValue) < tol);
assert(abs(enumerated_maximum(A, b, c, tol) - value) < tol);
end

function best = enumerated_maximum(A, b, c, tol)
% Small full-row-rank standard-form examples only; not an unboundedness test.
bases = nchoosek(1:size(A, 2), size(A, 1));
best = [];
for k = 1:size(bases, 1)
    B = bases(k, :);
    if rcond(A(:, B)) < tol
        continue;
    end
    basic = A(:, B) \ b;
    if all(basic >= -tol)
        value = c(B)'*basic;
        if isempty(best) || value > best
            best = value;
        end
    end
end
end
