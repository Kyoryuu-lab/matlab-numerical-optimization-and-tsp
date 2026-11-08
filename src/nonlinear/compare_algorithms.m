function compare_algorithms()
% COMPARE_ALGORITHMS Benchmarks multiple unconstrained optimization methods:
% Nelder-Mead, Steepest Descent, Gauss-Newton, Levenberg-Marquardt, DFP, and BFGS.

    fprintf('========================================================================\n');
    fprintf('  BENCHMARK: NICHTLINEARE OPTIMIERUNGSVERFAHREN (DIMENSION N = 50)\n');
    fprintf('========================================================================\n\n');

    % Zielfunktion: 100*x1^2 + sum(|xi - 2*i|)
    fun = @(x) 100 * x(1)^2 + sum(abs(x(2:end) - 2 * (2:length(x))));
    x0 = 12 * ones(1, 50);

    % 1. Nelder-Mead Simplex (fminsearch)
    opts_simplex = optimset('Display', 'off', 'TolFun', 1e-3, 'MaxFunEvals', 20000);
    tic;
    [x_simplex, fval_simplex, ~, out_simplex] = fminsearch(fun, x0, opts_simplex);
    t_simplex = toc;

    % 2. Methode des steilsten Abstiegs (fminunc)
    opts_steep = optimset('Display', 'off', 'TolFun', 1e-3, 'MaxFunEvals', 20000);
    tic;
    [x_steep, fval_steep, ~, out_steep] = fminunc(fun, x0, opts_steep);
    t_steep = toc;

    % 3. Gauss-Newton (fsolve)
    opts_gn = optimoptions('fsolve', 'Display', 'off', 'StepTolerance', 1e-3, 'FunctionTolerance', 1e-3);
    tic;
    [x_gn, fval_gn, exit_gn, out_gn] = fsolve(fun, x0, opts_gn);
    t_gn = toc;

    % 4. Levenberg-Marquardt (fsolve)
    opts_lm = optimoptions('fsolve', 'Algorithm', 'levenberg-marquardt', 'Display', 'off', ...
                           'StepTolerance', 1e-3, 'FunctionTolerance', 1e-3);
    tic;
    [x_lm, fval_lm, exit_lm, out_lm] = fsolve(fun, x0, opts_lm);
    t_lm = toc;

    % 5. Quasi-Newton: Davidon-Fletcher-Powell (DFP)
    opts_dfp = optimoptions('fminunc', 'Algorithm', 'quasi-newton', 'HessUpdate', 'dfp', ...
                            'Display', 'off', 'StepTolerance', 1e-3, 'FunctionTolerance', 1e-3);
    tic;
    [x_dfp, fval_dfp, ~, out_dfp] = fminunc(fun, x0, opts_dfp);
    t_dfp = toc;

    % 6. Quasi-Newton: Broyden-Fletcher-Goldfarb-Shanno (BFGS)
    opts_bfgs = optimoptions('fminunc', 'Algorithm', 'quasi-newton', 'HessUpdate', 'bfgs', ...
                             'Display', 'off', 'StepTolerance', 1e-3, 'FunctionTolerance', 1e-3);
    tic;
    [x_bfgs, fval_bfgs, ~, out_bfgs] = fminunc(fun, x0, opts_bfgs);
    t_bfgs = toc;

    % Ergebnistabelle anzeigen
    methods = {'Nelder-Mead (Simplex)'; 'Steepest Descent'; 'Gauss-Newton'; ...
               'Levenberg-Marquardt'; 'Quasi-Newton (DFP)'; 'Quasi-Newton (BFGS)'};
    times = [t_simplex; t_steep; t_gn; t_lm; t_dfp; t_bfgs];
    iters = [out_simplex.iterations; out_steep.iterations; out_gn.iterations; ...
             out_lm.iterations; out_dfp.iterations; out_bfgs.iterations];
    fvals = [fval_simplex; fval_steep; sum(abs(fval_gn)); sum(abs(fval_lm)); fval_dfp; fval_bfgs];

    T = table(methods, times, iters, fvals, ...
        'VariableNames', {'Methode', 'Laufzeit_s', 'Iterationen', 'Optimum_fval'});
    disp(T);
end
