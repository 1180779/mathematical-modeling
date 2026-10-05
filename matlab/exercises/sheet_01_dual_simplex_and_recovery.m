% Sheet 1, tasks 4 and 5(a)-(d): dual simplex and primal recovery.
% Hand derivations: notes/exercises/01-dual-simplex-and-recovery.tex.
% Source: ../execrices-2026-27/ProgMatc1.pdf, PDF page 2.
% MATLAB execution initially unverified; record actual runs separately.
% Run from the repository root:
%   run('matlab/exercises/sheet_01_dual_simplex_and_recovery.m')
% Base MATLAB only. Validates recorded small paths, not a general LP solver.
clear;
clc;
tol = 1e-10; % Absolute tolerance for the same hand inputs throughout.

%% Task 4: dual simplex repairs the negative RHS while preserving q >= 0.
originalA = [4, 2, -1, 1; 1, 1, 1, 1; -2, -2, -1, -1];
originalB = [4; 5; -8];
originalC = [1; 6; 2; 3];
A = [-originalA, eye(3)];
b = -originalB;
c = [-originalC; zeros(3, 1)];
bases = [5, 6, 7; 5, 1, 7; 5, 1, 3];

tables = { ...
    [-4, -2, 1, -1, 1, 0, 0, -4; ...
     -1, -1, -1, -1, 0, 1, 0, -5; ...
     2, 2, 1, 1, 0, 0, 1, 8; ...
     1, 6, 2, 3, 0, 0, 0, 0], ...
    [0, 2, 5, 3, 1, -4, 0, 16; ...
     1, 1, 1, 1, 0, -1, 0, 5; ...
     0, 0, -1, -1, 0, 2, 1, -2; ...
     0, 5, 1, 2, 0, 1, 0, -5], ...
    [0, 2, 0, -2, 1, 6, 5, 6; ...
     1, 1, 0, 0, 0, 1, 1, 3; ...
     0, 0, 1, 1, 0, -2, -1, 2; ...
     0, 5, 0, 1, 0, 3, 1, -7] ...
};

check_path(A, b, c, bases, tables, 'dual', [2, 3], [1, 3], tol);
[~, rhs, q, augmentedX, value, y] = basis_data(A, b, c, bases(end, :), tol);
assert(norm(augmentedX - [3; 0; 2; 0; 6; 0; 0], Inf) <= tol);
assert(norm(y - [0; 3; 1], Inf) <= tol);
check_pair(originalA, originalB, originalC, augmentedX(1:4), y, ...
    ones(4, 1), 7, tol);
assert(all(rhs >= -tol) && all(q >= -tol) && abs(value + 7) <= tol);
assert(all(q([2, 4, 6, 7]) > tol)); % Every nonbasic coefficient is positive.
% Complementarity forces y1=0 and the two independent x1/x3 equations.
assert(rank([1, 0, 0; 4, 1, -2; -1, 1, -1]) == 3);
fprintf('Task 4: primal = (3,0,2,0), dual = (0,3,1), value = 7; both unique\n');

%% Task 5(a): Phase I stops immediately at positive artificial sum 3.
originalA = [-1, 2, 1; -1, 1, 1; -1, 2, -1; -1, 2, 1];
originalB = [2; 1; -3; 1];
originalC = [3; 10; 2];
A = [-1, -1, -1, -1, -1, 0, 0, 1; ...
      2,  1,  2,  2,  0, 1, 0, 0; ...
      1,  1, -1,  1,  0, 0, 1, 0];
b = [3; 10; 2];
c = [zeros(7, 1); -1];
bases = [8, 6, 7];

tables = { ...
    [-1, -1, -1, -1, -1, 0, 0, 1, 3; ...
     2, 1, 2, 2, 0, 1, 0, 0, 10; ...
     1, 1, -1, 1, 0, 0, 1, 0, 2; ...
     1, 1, 1, 1, 1, 0, 0, 0, -3] ...
};

check_path(A, b, c, bases, tables, 'primal', [], [], tol);
[~, ~, q, u, value] = basis_data(A, b, c, bases, tol);
assert(all(q >= -tol) && abs(value + 3) <= tol && abs(u(8) - 3) <= tol);
% A nonnegative linear combination verifies a1 >= 3 exactly at the start.
assert(isequal(A(1, :), [-ones(1, 5), 0, 0, 1]));
check_ray(originalA, originalB, originalC, [-2; 0; 0], [-1; 0; 0], ...
    [-1; 1; 1], -6, -3, tol);
fprintf('Task 5(a): dual infeasible, Phase I artificial sum = 3; primal slope = -3\n');

%% Task 5(b): solve the mixed-domain dual, then recover the primal.
originalA = [0, -2, -2; 2, -1, 0; -2, 1, 1; 2, 2, 1];
originalB = [-2; 1; -5; 1];
originalC = [3; 10; 1];
% y1,y2,y3,y4,s1,s3,a2: free x2 produces equality row 2.
A = [0, 2, -2, 2, 1, 0, 0; ...
    -2, -1, 1, 2, 0, 0, 1; ...
    -2, 0, 1, 1, 0, 1, 0];
b = [3; 10; 1];
phaseIC = [zeros(6, 1); -1];
bases = [5, 7, 6; 5, 7, 4; 1, 7, 4; 1, 3, 4];

tables = { ...
    [0, 2, -2, 2, 1, 0, 0, 3; ...
     -2, -1, 1, 2, 0, 0, 1, 10; ...
     -2, 0, 1, 1, 0, 1, 0, 1; ...
     2, 1, -1, -2, 0, 0, 0, -10], ...
    [4, 2, -4, 0, 1, -2, 0, 1; ...
     2, -1, -1, 0, 0, -2, 1, 8; ...
     -2, 0, 1, 1, 0, 1, 0, 1; ...
     -2, 1, 1, 0, 0, 2, 0, -8], ...
    [1, 1/2, -1, 0, 1/4, -1/2, 0, 1/4; ...
     0, -2, 1, 0, -1/2, -1, 1, 15/2; ...
     0, 1, -1, 1, 1/2, 0, 0, 3/2; ...
     0, 2, -1, 0, 1/2, 1, 0, -15/2], ...
    [1, -3/2, 0, 0, -1/4, -3/2, 1, 31/4; ...
     0, -2, 1, 0, -1/2, -1, 1, 15/2; ...
     0, -1, 0, 1, 0, -1, 1, 9; ...
     0, 0, 0, 0, 0, 0, 1, 0] ...
};

check_path(A, b, phaseIC, bases, tables, 'primal', [3, 1, 2], [4, 1, 3], tol);
[~, ~, ~, phaseIX, phaseIValue] = basis_data(A, b, phaseIC, bases(end, :), tol);
assert(abs(phaseIValue) <= tol && abs(phaseIX(7)) <= tol);
assert(~ismember(7, bases(end, :))); % Artificial is nonbasic before deletion.
A = A(:, 1:6);
c = [originalB; 0; 0];

tables = { ...
    [1, -3/2, 0, 0, -1/4, -3/2, 31/4; ...
     0, -2, 1, 0, -1/2, -1, 15/2; ...
     0, -1, 0, 1, 0, -1, 9; ...
     0, 11, 0, 0, 3, 7, -44] ...
};

check_path(A, b, c, bases(end, :), tables, 'primal', [], [], tol);
[~, ~, q, u, value, multipliers] = basis_data(A, b, c, bases(end, :), tol);
y = u(1:4);
assert(norm(y - [31/4; 0; 15/2; 9], Inf) <= tol && abs(value + 44) <= tol);
assert(norm(q - [0; 11; 0; 0; 3; 7], Inf) <= tol);
assert(all(q([2, 5, 6]) > tol)); % No zero-cost nonbasic move.
% Recover only from rows with positive dual multipliers; no primal simplex.
activeRows = [1, 3, 4];
x = originalA(activeRows, :) \ originalB(activeRows);
assert(norm(x - [3; -6; 7], Inf) <= tol);
assert(norm(multipliers - x, Inf) <= tol);
check_pair(originalA, originalB, originalC, x, y, [1; 0; 1], -44, tol);
assert(norm(originalA * x - originalB - [0; 11; 0; 0], Inf) <= tol);
fprintf('Task 5(b): dual = (31/4,0,15/2,9), recovered primal = (3,-6,7), value = -44; both unique\n');

%% Task 5(c): one Phase I pivot leaves artificial sum 4.
originalA = [-1, -1, 2; -1, 0, 3; -1, 1, 1; 0, -1, -2];
originalB = [-1; 5; 1; -1];
originalC = [-1; 5; 8];
% y1,y2,y3,y4,s3,a1,a2; normalize the first equality to RHS +1.
A = [1, 1, 1, 0, 0, 1, 0; ...
    -1, 0, 1, -1, 0, 0, 1; ...
     2, 3, 1, -2, 1, 0, 0];
b = [1; 5; 8];
c = [zeros(5, 1); -1; -1];
bases = [6, 7, 5; 3, 7, 5];

tables = { ...
    [1, 1, 1, 0, 0, 1, 0, 1; ...
     -1, 0, 1, -1, 0, 0, 1, 5; ...
     2, 3, 1, -2, 1, 0, 0, 8; ...
     0, -1, -2, 1, 0, 0, 0, -6], ...
    [1, 1, 1, 0, 0, 1, 0, 1; ...
     -2, -1, 0, -1, 0, -1, 1, 4; ...
     1, 2, 0, -2, 1, -1, 0, 7; ...
     2, 1, 0, 1, 0, 2, 0, -4] ...
};

check_path(A, b, c, bases, tables, 'primal', 1, 3, tol);
[Abar, ~, q, u, value] = basis_data(A, b, c, bases(end, :), tol);
assert(all(q >= -tol) && abs(value + 4) <= tol);
assert(abs(sum(u(6:7)) - 4) <= tol);
assert(norm(Abar(2, :) - [-2, -1, 0, -1, 0, -1, 1], Inf) <= tol);
check_ray(originalA, originalB, originalC, [-5; 0; 0], [-1; -1; 0], ...
    [0; 0; 1], 5, -4, tol);
fprintf('Task 5(c): dual infeasible, Phase I artificial sum = 4; primal slope = -4\n');

%% Task 5(d): one Phase I pivot, two Phase II pivots.
originalA = [3, 1, 2; -1, 0, 1; -1, -1, 1; 3, -1, -2];
originalB = [1; 5; 1; -2];
originalC = [1; -5; 8];
% Normalize the free-x2 equality by -1 before adding a2.
A = [3, -1, -1, 3, 1, 0, 0; ...
    -1, 0, 1, 1, 0, 0, 1; ...
     2, 1, 1, -2, 0, 1, 0];
b = [1; 5; 8];
phaseIC = [zeros(6, 1); -1];
phaseIBases = [5, 7, 6; 5, 3, 6];

tables = { ...
    [3, -1, -1, 3, 1, 0, 0, 1; ...
     -1, 0, 1, 1, 0, 0, 1, 5; ...
     2, 1, 1, -2, 0, 1, 0, 8; ...
     1, 0, -1, -1, 0, 0, 0, -5], ...
    [2, -1, 0, 4, 1, 0, 1, 6; ...
     -1, 0, 1, 1, 0, 0, 1, 5; ...
     3, 1, 0, -3, 0, 1, -1, 3; ...
     0, 0, 0, 0, 0, 0, 1, 0] ...
};

check_path(A, b, phaseIC, phaseIBases, tables, 'primal', 2, 3, tol);
[~, ~, ~, phaseIX, phaseIValue] = basis_data(A, b, phaseIC, phaseIBases(end, :), tol);
assert(abs(phaseIValue) <= tol && abs(phaseIX(7)) <= tol);
assert(~ismember(7, phaseIBases(end, :)));
A = A(:, 1:6);
c = [originalB; 0; 0];
bases = [5, 3, 6; 5, 3, 2; 5, 4, 2];

tables = { ...
    [2, -1, 0, 4, 1, 0, 6; ...
     -1, 0, 1, 1, 0, 0, 5; ...
     3, 1, 0, -3, 0, 1, 3; ...
     -2, -5, 0, 3, 0, 0, 5], ...
    [5, 0, 0, 1, 1, 1, 9; ...
     -1, 0, 1, 1, 0, 0, 5; ...
     3, 1, 0, -3, 0, 1, 3; ...
     13, 0, 0, -12, 0, 5, 20], ...
    [6, 0, -1, 0, 1, 1, 4; ...
     -1, 0, 1, 1, 0, 0, 5; ...
     0, 1, 3, 0, 0, 1, 18; ...
     1, 0, 12, 0, 0, 5, 80] ...
};

check_path(A, b, c, bases, tables, 'primal', [3, 2], [2, 4], tol);
[~, ~, q, u, value, multipliers] = basis_data(A, b, c, bases(end, :), tol);
y = u(1:4);
assert(norm(y - [0; 18; 0; 5], Inf) <= tol && abs(value - 80) <= tol);
assert(norm(originalC - originalA' * y - [4; 0; 0], Inf) <= tol);
assert(norm(q - [1; 0; 12; 0; 0; 5], Inf) <= tol);
assert(all(q([1, 3, 6]) > tol));
% Column 1 is strict, so x1=0. Positive y2,y4 make those rows tight.
recoveryA = [1, 0, 0; originalA([2, 4], :)];
recoveryB = [0; originalB([2, 4])];
x = recoveryA \ recoveryB;
assert(norm(x - [0; -8; 5], Inf) <= tol);
% The second normalized dual row has the opposite sign to the original one.
assert(norm(multipliers .* [1; -1; 1] - x, Inf) <= tol);
check_pair(originalA, originalB, originalC, x, y, [1; 0; 1], 80, tol);
assert(norm(originalA * x - originalB - [1; 0; 12; 0], Inf) <= tol);
fprintf('Task 5(d): dual = (0,18,0,5), recovered primal = (0,-8,5), value = 80; both unique\n');
fprintf('All Sheet 1 dual-simplex and recovery assertions passed.\n');

function [Abar, rhs, q, x, value, multiplier] = basis_data(A, b, c, B, tol)
    AB = A(:, B);
    assert(rank(AB) == size(A, 1), 'Singular recorded basis.');
    Abar = AB \ A;
    rhs = AB \ b;
    multiplier = AB' \ c(B);
    q = A' * multiplier - c;
    x = zeros(size(A, 2), 1);
    x(B) = rhs;
    value = c' * x;
    assert(norm(A * x - b, Inf) <= tol, 'Equality residual.');
    assert(norm(Abar(:, B) - eye(numel(B)), Inf) <= tol, 'Canonical basis.');
    assert(norm(q(B), Inf) <= tol && abs(value - b' * multiplier) <= tol);
end

function check_path(A, b, c, bases, expected, kind, rows, columns, tol)
    assert(size(bases, 1) == numel(expected));
    assert(numel(rows) == size(bases, 1)-1 && numel(columns) == numel(rows));
    for step = 1:size(bases, 1)
        B = bases(step, :);
        [Abar, rhs, q, ~, value] = basis_data(A, b, c, B, tol);
        actual = [Abar, rhs; q', value];
        assert(norm(actual - expected{step}, Inf) <= tol, 'Hand tableau mismatch.');
        if strcmp(kind, 'dual')
            assert(all(q >= -tol), 'Dual feasibility must be preserved.');
        else
            assert(all(rhs >= -tol), 'Primal feasibility must be preserved.');
        end
        if step == size(bases, 1)
            assert(all(q >= -tol), 'Terminal tableau must be dual feasible.');
            if strcmp(kind, 'dual')
                assert(all(rhs >= -tol), 'Dual simplex must repair primal feasibility.');
            end
            continue;
        end
        row = rows(step);
        column = columns(step);
        if strcmp(kind, 'dual')
            [minimumRhs, chosenRow] = min(rhs);
            assert(minimumRhs < -tol && row == chosenRow);
            eligible = find(Abar(row, :) < -tol);
            ratios = q(eligible)' ./ (-Abar(row, eligible));
            [alpha, index] = min(ratios);
            assert(column == eligible(index));
        else
            [minimumQ, chosenColumn] = min(q);
            assert(minimumQ < -tol && column == chosenColumn);
            eligible = find(Abar(:, column) > tol);
            ratios = rhs(eligible) ./ Abar(eligible, column);
            smallest = min(ratios);
            tied = eligible(abs(ratios - smallest) <= tol);
            [~, index] = min(B(tied));
            assert(row == tied(index));
        end
        nextB = B;
        nextB(row) = column;
        assert(isequal(nextB, bases(step+1, :)), 'Unexpected basis transition.');
        % Independent Gauss-Jordan update, compared with the next basis solve.
        pivotTable = actual;
        pivotTable(row, :) = pivotTable(row, :) / pivotTable(row, column);
        for other = 1:size(pivotTable, 1)
            if other ~= row
                pivotTable(other, :) = pivotTable(other, :) ...
                    - pivotTable(other, column) * pivotTable(row, :);
            end
        end
        [nextA, nextRhs, nextQ, ~, nextValue] = basis_data(A, b, c, nextB, tol);
        assert(norm(pivotTable - [nextA, nextRhs; nextQ', nextValue], Inf) <= tol);
        if strcmp(kind, 'dual')
            assert(norm(nextQ - q - alpha * Abar(row, :)', Inf) <= tol);
            assert(abs(nextValue - value - alpha * rhs(row)) <= tol);
        else
            theta = rhs(row) / Abar(row, column);
            assert(abs(nextValue - value + q(column) * theta) <= tol);
        end
    end
end

function check_pair(A, b, c, x, y, domain, expectedValue, tol)
    assert(all(A * x >= b - tol) && all(y >= -tol), 'Row feasibility.');
    slack = c - A' * y;
    assert(all(x(domain == 1) >= -tol) && all(x(domain == -1) <= tol));
    assert(all(slack(domain == 1) >= -tol) && all(slack(domain == -1) <= tol));
    assert(all(abs(slack(domain == 0)) <= tol), 'Free-variable dual equality.');
    assert(abs(c' * x - expectedValue) <= tol && abs(b' * y - expectedValue) <= tol);
    assert(norm(x .* slack, Inf) <= tol);
    assert(norm(y .* (A * x - b), Inf) <= tol);
end

function check_ray(A, b, c, start, direction, domain, initialValue, slope, tol)
    assert(all(A * start >= b - tol) && all(A * direction >= -tol));
    assert(all(start(domain == 1) >= -tol) && all(direction(domain == 1) >= -tol));
    assert(all(start(domain == -1) <= tol) && all(direction(domain == -1) <= tol));
    assert(abs(c' * start - initialValue) <= tol && abs(c' * direction - slope) <= tol);
    assert(slope < -tol); % These conditions prove feasibility for every t >= 0.
    for parameter = [0, 1, 10]
        x = start + parameter * direction;
        assert(all(A * x >= b - tol));
        assert(abs(c' * x - initialValue - parameter * slope) <= tol);
    end
end
