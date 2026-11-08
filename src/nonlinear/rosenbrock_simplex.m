function rosenbrock_simplex()
% ROSENBROCK_SIMPLEX Evaluates Nelder-Mead on the 2D Rosenbrock banana valley,
% plots 3D surface convergence, and renders 2D contour trajectory maps.

    fprintf('--- Optimierung der Rosenbrock-Funktion via Nelder-Mead Simplex ---\n');

    rosenbrock = @(x) 100 * (x(2) - x(1)^2)^2 + (1 - x(1))^2;
    x0 = [-1.2, 1.0]; % Standard-Startpunkt nach Rosenbrock

    % Simplex-Optimierung mit Iterationsaufzeichnung
    options = optimset('Display', 'iter', 'TolFun', 1e-4);
    [x_opt, f_opt, exitflag, output] = fminsearch(rosenbrock, x0, options);

    fprintf('\nOptimum gefunden bei: [%.4f, %.4f] mit f(x) = %.6e\n', x_opt(1), x_opt(2), f_opt);
    fprintf('Benoetigte Iterationen: %d (Funktionsaufrufe: %d)\n\n', output.iterations, output.funcCount);

    % Gitter fuer Visualisierungen vorbereiten
    [X, Y] = meshgrid(-2:0.05:2, -1:0.05:3);
    Z = 100 * (Y - X.^2).^2 + (1 - X).^2;

    % 1. 3D-Flaechenplot
    figure('Name', 'Rosenbrock 3D Surface', 'Color', 'w');
    surf(X, Y, Z, 'EdgeColor', 'none', 'FaceAlpha', 0.85);
    colormap(jet);
    hold on;
    plot3(x_opt(1), x_opt(2), rosenbrock(x_opt), 'rp', 'MarkerSize', 14, 'MarkerFaceColor', 'r');
    xlabel('X_1'); ylabel('X_2'); zlabel('f(X_1, X_2)');
    title('3D-Visualisierung des Rosenbrock-Optimums');
    grid on; view(-35, 45);

    % 2. 2D-Hoehenlinien (Iso-Konturen)
    figure('Name', 'Rosenbrock Contour Map', 'Color', 'w');
    contour(X, Y, Z, logspace(-1, 3, 25), 'LineWidth', 1.2);
    colorbar; colormap(jet);
    hold on;
    plot(x0(1), x0(2), 'bs', 'MarkerSize', 10, 'MarkerFaceColor', 'b', 'DisplayName', 'Startpunkt');
    plot(x_opt(1), x_opt(2), 'rp', 'MarkerSize', 14, 'MarkerFaceColor', 'r', 'DisplayName', 'Globales Optimum');
    xlabel('X_1'); ylabel('X_2');
    title('Iso-Hoehenlinien der Rosenbrock-Funktion');
    legend('Location', 'northwest');
    grid on;
end
