function main()
% MAIN Master CLI runner for MATLAB Numerical Optimization and TSP Suite.

    addpath(genpath('src'));

    fprintf('========================================================================\n');
    fprintf('  MATLAB NUMERICAL OPTIMIZATION & COMBINATORIAL HEURISTICS SUITE\n');
    fprintf('========================================================================\n');
    fprintf('  1. Algorithmenvergleich (Simplex, DFP, BFGS, Gauss-Newton, LM)\n');
    fprintf('  2. Rosenbrock 3D-Fläche & Kontur-Trajektorie (Nelder-Mead)\n');
    fprintf('  3. Dimensionale Skalierungsanalyse (n = 2..50, Robustfit)\n');
    fprintf('  4. TSP Multistart Heuristik auf TSPLIB ali535 (Haversine-Distanz)\n');
    fprintf('  0. Beenden\n');
    fprintf('========================================================================\n');

    choice = input('Auswahl eingeben [0-4]: ');
    fprintf('\n');

    switch choice
        case 1
            compare_algorithms();
        case 2
            rosenbrock_simplex();
        case 3
            dimension_scalability();
        case 4
            tsp_multistart_suite();
        case 0
            fprintf('Programm beendet.\n');
        otherwise
            fprintf('Ungueltige Option gewaehlt.\n');
    end
end
