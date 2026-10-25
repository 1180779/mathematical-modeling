% Solved practice demo: standard form, two hand pivots, and linprog.
% Invented training task, not an official Lab 3 assignment.
% Run: run('matlab/labs/lab_03_demo.m')
% Hand snapshots need base MATLAB; the final solve needs Optimization Toolbox.
clear;
clc;
tol = 1e-7;

%% Model: continuous batches of two products, profit 4*x1 + 3*x2.
Aresource = [2, 1; 1, 2];
bresource = [8; 8];
c = [4; 3];
% Standard order is fixed throughout: x1, x2, s1, s2.
S = [Aresource, eye(2)];
cStandard = [c; 0; 0];

%% Recompute the three hand tableaux from their bases (not a general solver).
bases = {[3, 4], [1, 4], [1, 2]};
expected = [0, 0, 8, 8; 4, 0, 0, 4; 8/3, 8/3, 0, 0]';
for k = 1:numel(bases)
    B = bases{k};
    Abar = S(:, B) \ S;
    rhs = S(:, B) \ bresource;
    zj = Abar' * cStandard(B);
    q = zj - cStandard;
    z0 = cStandard(B)' * rhs;
    v = zeros(4, 1);
    v(B) = rhs;
    assert(all(v >= -tol) && norm(S * v - bresource, Inf) <= tol);
    assert(norm(v - expected(:, k), Inf) <= tol);
    fprintf('\nHand tableau %d, basis (%d,%d), profit %.10f\n', k, B, z0);
    rowNames = ["basic_" + string(B(:)); "zj"; "zj_minus_cj"];
    tableau = array2table([Abar, rhs; zj', z0; q', z0], ...
        'VariableNames', {'x1', 'x2', 's1', 's2', 'RHS'}, ...
        'RowNames', cellstr(rowNames));
    tableau = addvars(tableau, [cStandard(B); NaN; NaN], ...
        'Before', 1, 'NewVariableNames', 'cB');
    disp(tableau);
end
assert(all(q >= -tol));
% Global bound: nonnegative resource prices reproduce both product profits.
prices = [5/3; 2/3];
assert(norm(Aresource' * prices - c, Inf) <= tol);
assert(abs(prices' * bresource - 56/3) <= tol);

%% Solve the original inequalities, putting nonnegativity into matrix rows.
options = optimoptions('linprog', 'Algorithm', 'dual-simplex-highs', ...
    'Display', 'none', 'ConstraintTolerance', 1e-9, ...
    'OptimalityTolerance', 1e-9);
A = [Aresource; -eye(2)];
b = [bresource; zeros(2, 1)];
[x, minValue, flag, info] = linprog(-c, A, b, [], [], [], [], options);
assert(flag > 0, 'Original model did not reach an optimum.');
assert(all(A * x <= b + tol));
assert(norm(x - [8/3; 8/3], Inf) <= tol);
assert(abs(-minValue - 56/3) <= tol);
fprintf('Original model: x=(%.10f, %.10f), profit=%.10f\n', x, -minValue);
fprintf('Solver algorithm: %s; reported iterations: %d\n', ...
    info.algorithm, info.iterations);

%% Solve the equality/nonnegativity standard form independently.
[v, standardValue, standardFlag] = linprog(-cStandard, -eye(4), ...
    zeros(4, 1), S, bresource, [], [], options);
assert(standardFlag > 0, 'Standard form did not reach an optimum.');
assert(all(v >= -tol) && norm(S * v - bresource, Inf) <= tol);
assert(norm(v(1:2) - x, Inf) <= tol);
assert(abs(standardValue - minValue) <= tol);

%% Geometry of the hand path; linprog can follow a different internal path.
figure('Name', 'Simplex demo: hand path');
fill([0, 4, 8/3, 0], [0, 0, 8/3, 4], [0.85, 0.92, 0.97]);
hold on;
plot([0, 4, 8/3], [0, 0, 8/3], '-o', 'LineWidth', 1.5);
xlabel('Product 1 batches'); ylabel('Product 2 batches');
title('Hand simplex path: (0,0) -> (4,0) -> (8/3,8/3)');
axis equal; xlim([0, 5]); ylim([0, 5]); grid on;
fprintf('All demo checks passed (absolute tolerance %.0e).\n', tol);
