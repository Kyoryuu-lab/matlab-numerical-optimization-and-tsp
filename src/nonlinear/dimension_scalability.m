function dimension_scalability()
% DIMENSION_SCALABILITY Evaluates optimization runtime across increasing dimensions
% and applies polynomial vs. robust linear regression fitting.

    fprintf('--- Skalierungsanalyse ueber Dimensionen n = 2 bis 50 ---\n');

    fun = @(x) 100 * x(1)^4 + sum(abs(x(2:end) - 2 * (2:length(x))));
    dimensions = [2:20, 22:2:30, 35:5:50];
    opts = optimoptions('fminunc', 'Display', 'off', 'Algorithm', 'quasi-newton');

    opt_times = zeros(1, length(dimensions));

    for i = 1:length(dimensions)
        n = dimensions(i);
        x0 = rand(1, n);
        tic;
        fminunc(fun, x0, opts);
        opt_times(i) = toc;
        fprintf('  Dimension: %2d | Gemessene Laufzeit: %.4f s\n', n, opt_times(i));
    end

    % 1. Robuste Regression (IRLS / Huber M-Estimator)
    [b_robust, ~] = robustfit(dimensions, opt_times);
    fit_robust = b_robust(1) + b_robust(2) * dimensions;

    % 2. Polynomielle Regression (Grad 2)
    p2 = polyfit(dimensions, opt_times, 2);
    fit_poly2 = polyval(p2, dimensions);

    % Graphischer Vergleich
    figure('Name', 'Dimension Scalability Analysis', 'Color', 'w');
    plot(dimensions, opt_times, 'ko', 'MarkerFaceColor', 'k', 'DisplayName', 'Messdaten');
    hold on;
    plot(dimensions, fit_robust, 'b-', 'LineWidth', 1.8, 'DisplayName', 'Robuste Regression');
    plot(dimensions, fit_poly2, 'r--', 'LineWidth', 1.8, 'DisplayName', 'Polynom 2. Grades');
    xlabel('Problem-Dimension (n)');
    ylabel('Laufzeit (s)');
    title('Laufzeitskalierung bei steigender Variablenanzahl');
    legend('Location', 'northwest');
    grid on;
end
