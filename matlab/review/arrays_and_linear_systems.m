% Original refresher examples accompanying the matching LaTeX notes.
% Verified 2026-10-04 in MATLAB 26.2.0.3386108 (R2026b).
% Evidence: user-supplied terminal output in docs/matlab-verification.md.
% Run from the repository root with run('matlab/review/arrays_and_linear_systems.m').
clear;
clc;
tol = 1e-10;

%% Dimensions, matrix multiplication, and indexing.
x = [2; 6];
c = [3; 2];
M = [1, 2, 3; 4, 5, 6];
assert(isequal(size(M), [2, 3]) && numel(M) == 6);
assert(c.' * x == 18);
assert(M(2, 3) == 6);
assert(isequal(M(:, 2), [2; 5]));
assert(isequal(M(1, :), [1, 2, 3]));
assert(isequal(M(:), [1; 4; 2; 5; 3; 6]));
assert(isequal(M(M > 3), [4; 5; 6]));
assert(isequal(size([1; 2] + [10, 20]), [2, 2]));

%% Matrix versus element-wise square.
M = [1, 2; 3, 4];
assert(isequal(M * M, [7, 10; 15, 22]));
assert(isequal(M .^ 2, [1, 4; 9, 16]));

%% Production: hand solution x=(2,6), all original constraints checked.
B = [2, 1; 3, 3];
b = [10; 24];
x = B \ b;
assert(norm(x - [2; 6], Inf) <= tol);
assert(norm(B*x - b, Inf) <= tol);
A = [2, 1; 3, 3; 1.5, 0];
capacity = [10; 24; 6];
slack = capacity - A*x;
assert(all(x >= -tol) && all(slack >= -tol));
assert(norm(slack - [0; 0; 3], Inf) <= tol);

%% Function handle, vectorized evaluation, and preallocated loop.
f = @(t) t.^2 - 4*t + 5;
t = linspace(0, 4, 101);
values = f(t);
loopValues = zeros(size(t));
for k = 1:numel(t)
    loopValues(k) = f(t(k));
end
assert(max(abs(values-loopValues)) <= tol);
assert(abs(f(2)-1) <= tol);
assert(all(values >= 1-tol));
fprintf('All numerical refresher assertions passed.\n');

%% Export a plot outside the tracked source tree.
% run() may temporarily change the working directory; resolve paths from this file.
repoRoot = fileparts(fileparts(fileparts(mfilename('fullpath'))));
outputDir = fullfile(repoRoot, 'matlab', 'output');
if ~isfolder(outputDir)
    mkdir(outputDir);
end
fig = figure('Visible', 'off');
plot(t, values, 'LineWidth', 1.5);
xlabel('t'); ylabel('f(t)');
title('f(t) = (t - 2)^2 + 1');
grid on;
plotPath = fullfile(outputDir, '01-quadratic-review.png');
exportgraphics(fig, plotPath, 'Resolution', 150);
close(fig);
fprintf('Plot exported to %s\n', plotPath);
