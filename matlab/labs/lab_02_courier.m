% Lab 2, group 5: delivery quantities on the fixed route 0->1->2->3->0.
% Run from the repository root: run('matlab/labs/lab_02_courier.m')
% Requires Optimization Toolbox. Original submitted files remain separate.
clear;
clc;
tol = 1e-7;
options = optimoptions('linprog', 'Display', 'none', ...
    'ConstraintTolerance', 1e-9, 'OptimalityTolerance', 1e-9);
M = (7:11)';
minimumDelivery = [2; 4; 2.5];
maximumDelivery = [6; 7; 5];
% Rows: total delivered <= M, three lower bounds, three upper bounds.
A = [ones(1, 3); -eye(3); eye(3)];
f = [-5.5; -2.5; -1.5];
deliveries = NaN(numel(M), 3);
totalCost = NaN(numel(M), 1);
exitFlag = zeros(numel(M), 1);
for k = 1:numel(M)
    m = M(k);
    b = [m; -minimumDelivery; maximumDelivery];
    [x, variableCost, exitFlag(k)] = linprog(f, A, b, [], [], [], [], options);
    if m < sum(minimumDelivery)
        assert(exitFlag(k) == -2, 'Expected infeasibility below 8.5 kg.');
        fprintf('M = %g kg: infeasible (minimum deliveries total 8.5 kg).\n', m);
        continue;
    end
    assert(exitFlag(k) > 0, 'A feasible case did not reach an optimum.');
    assert(all(A * x <= b + tol));
    expected = [m - 6.5; 4; 2.5];
    assert(norm(x - expected, Inf) <= tol);
    deliveries(k, :) = x';
    % linprog omits this constant; restore it for the physical trip cost.
    totalCost(k) = 7.5 * m + variableCost;
    edgeLoads = [m; m - x(1); m - x(1) - x(2); m - sum(x)];
    assert(all(edgeLoads >= -tol));
    assert(abs([2, 3, 1, 1.5] * edgeLoads - totalCost(k)) <= tol);
    assert(abs(totalCost(k) - (2 * m + 22)) <= tol);
end
disp(table(M, exitFlag, deliveries(:, 1), deliveries(:, 2), ...
    deliveries(:, 3), totalCost, 'VariableNames', ...
    {'M', 'ExitFlag', 'Point1_kg', 'Point2_kg', 'Point3_kg', 'TripCost'}));

% NaN rows keep infeasible cases on the axis without inventing zero deliveries.
figure('Name', 'Lab 2: courier deliveries');
bar(M, deliveries, 'grouped');
xticks(M); xlabel('Initial load M (kg)'); ylabel('Delivered mass (kg)');
legend('Point 1', 'Point 2', 'Point 3', 'Location', 'northwest');
title('Optimal deliveries; M=7 and M=8 are infeasible');
fprintf('All courier-model checks passed (tolerance %.0e).\n', tol);
