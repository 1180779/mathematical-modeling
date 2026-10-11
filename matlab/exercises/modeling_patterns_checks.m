% Checks for Chapters 1, 2 and the modeling-patterns supplement.
% Current source: ProgMat_w1.pdf, pp. 2-26; added examples are identified
% in the notes' final source remarks. These are specified certificate checks,
% not a general LP solver. Base MATLAB only; absolute tolerance 1e-10.
% Execution evidence: docs/matlab-verification.md. Revised diet run unverified.
% Run from the repository root:
%   run('matlab/exercises/modeling_patterns_checks.m')
clear;
clc;
tol = 1e-10;

%% Factory: check both grinding capacities and a global upper bound.
A = [12, 20, 0, 25, 15; 10, 8, 16, 0, 0; 20, 20, 20, 20, 20];
c = [550; 600; 350; 400; 200];
weights = [16; 179/5; 0];
assert(all(weights >= 0) && all(A' * weights >= c - tol));
capacities = [144, 192];
expected = [28704/5, 32544/5];
for k = 1:numel(capacities)
    G = capacities(k);
    b = [G; 96; 384];
    x = [48/5; 0; 0; (G - 576/5)/25; 0];
    assert(all(x >= 0) && all(A * x <= b + tol));
    assert(abs(c' * x - expected(k)) <= tol);
    assert(abs(weights' * b - c' * x) <= tol);
    assert(norm(weights .* (b - A * x), Inf) <= tol);
    assert(norm(x .* (A' * weights - c), Inf) <= tol);
end

%% Two-food diet: rows are nutrients, columns are foods (grams per serving).
A = [2, 1; 1, 3];
b = [4; 4];
c = [2; 3];
x = [8/5; 4/5];
weights = [3/5; 4/5];
assert(all(A * x >= b - tol) && all(x >= 0));
assert(all(weights > 0) && rank(A) == 2); % Tight constraints fix the optimizer.
assert(norm(A * x - b, Inf) <= tol);
assert(norm(A' * weights - c, Inf) <= tol);
assert(abs(c' * x - 28/5) <= tol);
assert(abs(b' * weights - c' * x) <= tol);

%% Regression: the same observations produce different optimal criteria.
t = [0; 1; 2];
observed = [0; 2; 0];
minimax = observed - (0 * t + 1);
absoluteFit = observed - (0 * t + 0);
assert(abs(max(abs(minimax)) - 1) <= tol);
assert(abs(sum(abs(absoluteFit)) - 2) <= tol);
% Identity valid for every affine line, including free/negative parameters.
for parameters = [0, 0; 1, -2; -3, 4]'
    e = observed - (parameters(1) * t + parameters(2));
    assert(abs(e(2) - (e(1) + e(3))/2 - 2) <= tol);
end

%% Blending: capacities, conservation, quality, and global profit bound.
x = [4300/27; 1100/27; 0; 250; 0];
y = sum(x);
hardness = [8.8; 6.1; 2; 4.2; 5];
purchase = [110; 120; 130; 110; 115];
margin = 150 - purchase;
A = [1, 1, 0, 0, 0; 0, 0, 1, 1, 1; (hardness - 6)'];
b = [200; 250; 0];
weights = [800/27; 140/3; 100/27];
assert(all(x >= 0) && abs(y - 450) <= tol);
assert(all(A * x <= b + tol));
assert(hardness' * x >= 3 * y - tol);
assert(abs(hardness' * x / y - 6) <= tol);
assert(all(A' * weights >= margin - tol));
profit = 150 * y - purchase' * x;
assert(abs(profit - 475000/27) <= tol);
assert(abs(weights' * b - profit) <= tol);
assert(norm(weights .* (b - A * x), Inf) <= tol);
assert(norm(x .* (A' * weights - margin), Inf) <= tol);
% No-production feasibility is checked algebraically, without dividing by zero.
assert(all(A * zeros(5, 1) <= b));

%% Transportation: only allowed routes are represented, never infinite costs.
routes = [1, 1; 1, 3; 1, 4; 2, 1; 2, 2; 3, 1; 3, 2; 3, 3; 3, 4];
costs = [132; 97; 103; 85; 91; 106; 89; 100; 98];
flow = [0; 39; 87; 56; 0; 6; 83; 0; 4];
supply = [135; 56; 93];
demand = [62; 83; 39; 91];
u = [0; 26; 5];
v = [111; 94; 97; 103];
shipments = zeros(3, 4);
for k = 1:size(routes, 1)
    i = routes(k, 1);
    j = routes(k, 2);
    shipments(i, j) = flow(k);
    assert(costs(k) >= v(j) - u(i) - tol);
    assert(abs(flow(k) * (costs(k) - v(j) + u(i))) <= tol);
end
assert(all(flow >= 0) && all(sum(shipments, 2) <= supply));
assert(norm(sum(shipments, 1)' - demand, Inf) <= tol);
assert(norm(u .* (supply - sum(shipments, 2)), Inf) <= tol);
assert(abs(costs' * flow - 25919) <= tol);
assert(abs(v' * demand - u' * supply - costs' * flow) <= tol);

%% Inventory: balances, time restrictions, and matching lower bounds.
dayCapacity = [100; 150; 140; 160];
nightCapacity = [50; 75; 70; 80];
demand = [80; 200; 300; 200];
day = [100; 150; 140; 160];
night = [45; 75; 70; 40];
stock = [65; 90; 0; 0];
previousStock = [0; stock(1:3)];
assert(all(day >= 0 & day <= dayCapacity));
assert(all(night >= 0 & night <= nightCapacity) && all(stock >= 0));
assert(norm(previousStock + day + night - demand - stock, Inf) <= tol);
assert(stock(4) == 0 && sum(day + night) == sum(demand));
minimumNight = sum(demand) - sum(dayCapacity);
minimumI2 = demand(3) - dayCapacity(3) - nightCapacity(3);
minimumI1 = sum(demand(2:3)) - sum(dayCapacity(2:3) + nightCapacity(2:3));
productionBound = sum(demand) + 0.5 * minimumNight;
holdingBound = 0.3 * (minimumI1 + minimumI2);
actualCost = sum(day) + 1.5 * sum(night) + 0.3 * sum(stock(1:3));
assert(minimumNight == 230 && minimumI1 == 65 && minimumI2 == 90);
assert(abs(actualCost - 1883/2) <= tol);
assert(abs(actualCost - productionBound - holdingBound) <= tol);
% Each forward assignment traverses exactly destination-source storage intervals.
for sourceMonth = 1:4
    for destinationMonth = sourceMonth:4
        assert(abs((1 + 0.3 * (destinationMonth - sourceMonth)) ...
            - (1 + sum(0.3 * ones(1, destinationMonth - sourceMonth)))) <= tol);
    end
end

%% Three-node flow: incidence signs and an exact cost formula.
B = [1, 0, 1; -1, 1, 0; 0, -1, -1]; % AB, BC, AC; tail positive.
flow = [2; 2; 1];
netSupply = [3; 0; -3];
assert(norm(B * flow - netSupply, Inf) <= tol);
assert(all(flow >= 0 & flow <= [2; 2; 3]));
assert([1, 1, 5] * flow == 9);
for amount = [0, 1, 2]
    candidate = [amount; amount; 3-amount];
    assert(norm(B * candidate - netSupply, Inf) <= tol);
    assert([1, 1, 5] * candidate == 15-3*amount);
end

%% Comparable objectives: weighted-sum, threshold and max-min certificates.
assert(abs(0.5 + 0.5 - 1) <= tol); % Equal weighted sum is constant.
for beta = [0, 0.25, 1]
    x = 1 - beta;
    assert(x >= 0 && x <= 1 && abs(1-x-beta) <= tol);
end
x = 0.5;
z = 0.5;
assert(z <= x && z <= 1-x && 2*z == 1);

%% Soft targets: sum, max and weighted compromises differ.
for x = [1, 2, 3]
    u = x - 1;
    v = 3 - x;
    assert(u >= 0 && v >= 0 && x <= 1+u && x >= 3-v);
    assert(u+v == 2);
end
x = 2; u = 1; v = 1; z = 1;
assert(x <= 1+u && x >= 3-v && u <= z && v <= z && 2*z == 2);
x = 1; u = 0; v = 2;
assert(x <= 1+u && x >= 3-v && 2*u+v == 2);

fprintf('Factory: optima 28704/5 and 32544/5 for G = 144 and 192\n');
fprintf('Blending: profit 475000/27; transport cost 25919\n');
fprintf('Storage: cost 1883/2; three-node flow cost 9\n');
fprintf('All modeling-pattern certificate assertions passed.\n');
