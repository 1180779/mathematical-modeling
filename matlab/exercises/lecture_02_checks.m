% Checks accompanying notes/lectures/02-linear-programming.tex.
% Source inputs: s4_w2.pdf slides 7-9, 18, and the assumed reading of 19.
% Verified 2026-10-04 in MATLAB 26.2.0.3386108 (R2026b).
% Evidence: user-supplied normal-terminal output in docs/matlab-verification.md.
% Run from the repository root:
%   run('matlab/exercises/lecture_02_checks.m')
% No Optimization Toolbox is required.
clear;
clc;
tol = 1e-10; % Absolute tolerance, suitable for these small, unscaled examples.

%% Production: enumerate intersections of independent active constraints.
A = [2, 1; 3, 3; 1.5, 0];
b = [10; 24; 6];
c = [3; 2];
G = [A; -eye(2)]; % Include both nonnegativity boundaries.
h = [b; zeros(2, 1)];
pairs = nchoosek(1:size(G, 1), 2);
vertices = zeros(2, 0);
for k = 1:size(pairs, 1)
    rows = pairs(k, :);
    active = G(rows, :);
    if rank(active) < 2
        continue;
    end
    candidate = active \ h(rows);
    if all(G * candidate <= h + tol)
        vertices(:, end + 1) = candidate; %#ok<SAGROW>
    end
end
values = c' * vertices;
[bestRevenue, bestIndex] = max(values);
bestProduction = vertices(:, bestIndex);
assert(size(vertices, 2) == 5);
assert(max(abs(bestProduction - [2; 6])) <= tol);
assert(abs(bestRevenue - 18) <= tol);
slacks = b - A * bestProduction;
assert(max(abs(slacks - [0; 0; 3])) <= tol);
% Certificate: nonnegative resource weights reproduce the objective.
weights = [1; 1/3; 0];
assert(max(abs(A' * weights - c)) <= tol);
assert(abs(b' * weights - bestRevenue) <= tol);
% Standard-form optimal basis, with variable order x1,x2,s1,s2,s3.
augmentedA = [A, eye(3)];
basis = [1, 2, 5];
y = zeros(5, 1);
y(basis) = augmentedA(:, basis) \ b;
assert(all(y >= -tol));
assert(max(abs(augmentedA * y - b)) <= tol);
assert(max(abs(y - [2; 6; 0; 0; 3])) <= tol);
fprintf('Production: x = (%.10g, %.10g), revenue = %.10g PLN\n', ...
    bestProduction(1), bestProduction(2), bestRevenue);

%% 5.2 m cutting: verify the supplied-pattern optimality certificate.
patterns = [7, 3, 0; 0, 1, 2];
demand = [1400; 800];
offcut = [0.3; 0.6; 0.2];
counts = [200; 0; 400];
certificate = [3/70; 1/10];
assert(all(patterns * counts >= demand - tol));
assert(all(counts >= 0) && all(counts == floor(counts)));
assert(all(patterns' * certificate <= offcut + tol));
assert(all(certificate >= 0));
assert(abs(offcut' * counts - certificate' * demand) <= tol);
assert(abs(offcut' * counts - 140) <= tol);
fprintf('5.2 m cutting: counts = (200, 0, 400), offcut = %.10g m\n', ...
    offcut' * counts);

%% 2 m cabinets: interpretation assumes 3 x 0.8 m and 2 x 0.3 m per cabinet.
% All 35 pieces require 21 m: hence the integer lower bound is 11 boards.
% A feasible 11-board construction lets us enumerate only totals <= 11;
% larger totals cannot improve it. Multiple optimal pattern counts may exist.
shortDemand = 14;
longDemand = 21;
lowerBound = ceil((0.8 * longDemand + 0.3 * shortDemand) / 2);
knownConstruction = [10; 1; 0];
cabinetPatterns = [2, 1, 0; 1, 4, 6]; % Rows: long pieces, short pieces.
assert(all(cabinetPatterns * knownConstruction == [longDemand; shortDemand]));
upperBound = sum(knownConstruction);
bestBoards = Inf;
bestCounts = zeros(3, 1);
for u = 0:upperBound
    for v = 0:(upperBound - u)
        for w = 0:(upperBound - u - v)
            if 2*u + v >= longDemand && u + 4*v + 6*w >= shortDemand
                if u + v + w < bestBoards
                    bestBoards = u + v + w;
                    bestCounts = [u; v; w];
                end
            end
        end
    end
end
assert(bestBoards == lowerBound && bestBoards == 11);
fprintf('2 m cabinets: %d boards; one enumerated plan = (%d, %d, %d)\n', ...
    bestBoards, bestCounts(1), bestCounts(2), bestCounts(3));
