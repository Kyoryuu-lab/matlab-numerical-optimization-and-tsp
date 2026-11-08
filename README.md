<h1>matlab-numerical-optimization-and-tsp</h1>
<p>Comprehensive scientific computing suite in MATLAB/Octave: nonlinear unconstrained solvers (Nelder-Mead, DFP, BFGS, Levenberg-Marquardt), dimensional complexity benchmarks, and combinatorial TSP heuristics on the TSPLIB ali535 benchmark</p>

<h2>Project description</h2>
<p>This repository provides a production-grade algorithmic framework for continuous and combinatorial mathematical optimization implemented in MATLAB/Octave:</p>
<ol>
  <li>
    <dl>
      <dt><b>Nonlinear Unconstrained Solvers (Continuous Domain):</b></dt>
      <dd><b>Derivative-Free Simplex:</b> Nelder-Mead simplex search (<code>fminsearch</code>) traversing non-convex valley topography (Rosenbrock banana function).</dd>
      <dd><b>Quasi-Newton Hessian Updates:</b> Compares Broyden-Fletcher-Goldfarb-Shanno (BFGS) and Davidon-Fletcher-Powell (DFP) rank-2 approximation updates via <code>fminunc</code>.</dd>
      <dd><b>Nonlinear Least Squares &amp; Solvers:</b> Implements Gauss-Newton and Levenberg-Marquardt damping mechanics via <code>fsolve</code>.</dd>
    </dl>
  </li>
  <li>
    <dl>
      <dt><b>Dimensional Scalability &amp; Complexity Fitting:</b></dt>
      <dd>Profiles optimization convergence time across scaling dimensions ($n = 2 \dots 50$).</dd>
      <dd>Validates algorithmic scaling models via Iteratively Reweighted Least Squares robust linear regression (<code>robustfit</code>) and polynomial fitting (degrees 1 through 5).</dd>
    </dl>
  </li>
  <li>
    <dl>
      <dt><b>Combinatorial Routing &amp; TSP Heuristics (Discrete Domain):</b></dt>
      <dd>Evaluates the TSPLIB <code>ali535.tsp</code> benchmark dataset (535 international airport geographic coordinates).</dd>
      <dd>Calculates pairwise distance matrices over spherical coordinates using the Haversine great-circle trigonometric formula.</dd>
      <dd>Executes multi-start stochastic Nearest-Neighbor greedy heuristics across 1 to 1000 randomized iterations, tracking performance against the global world record ($202,339\text{ km}$).</dd>
    </dl>
  </li>
</ol>

<h2>Project files</h2>
<table>
  <tr>
    <th colspan="2">matlab-numerical-optimization-and-tsp</th>
  </tr>
  <tr>
    <td>main.m</td>
    <td>Master CLI entry point providing menu-driven execution of all suites</td>
  </tr>
  <tr>
    <td>src/nonlinear/compare_algorithms.m</td>
    <td>Comparative benchmark of Nelder-Mead, Gradient Descent, DFP, BFGS, Gauss-Newton, and LM</td>
  </tr>
  <tr>
    <td>src/nonlinear/rosenbrock_simplex.m</td>
    <td>Rosenbrock Nelder-Mead solver with 3D surface and 2D contour trajectory generation</td>
  </tr>
  <tr>
    <td>src/nonlinear/dimension_scalability.m</td>
    <td>Empirical runtime benchmarking across dimensions 2 to 50 with robust IRLS fitting</td>
  </tr>
  <tr>
    <td>src/combinatorial/haversine_distance.m</td>
    <td>Great-circle spherical distance calculator based on WGS-84 mean radius</td>
  </tr>
  <tr>
    <td>src/combinatorial/greedy_tsp.m</td>
    <td>Nearest-Neighbor tour construction engine</td>
  </tr>
  <tr>
    <td>src/combinatorial/tsp_multistart_suite.m</td>
    <td>Multi-start heuristic suite executing convergence experiments on ali535</td>
  </tr>
  <tr>
    <td>data/ali535.tsp</td>
    <td>TSPLIB benchmark dataset with 535 airport coordinate pairs</td>
  </tr>
  <tr>
    <td>README.md</td>
    <td>Mathematical documentation and operational guide</td>
  </tr>
  <tr>
    <td>.gitignore</td>
    <td>Exclusion rules for MATLAB temporary autosave files, figures, and MAT dumps</td>
  </tr>
</table>

<h2>Mathematical Formulation</h2>
<table>
  <tr>
    <th>Domain</th>
    <th>Method</th>
    <th>Mathematical / Algorithmic Model</th>
  </tr>
  <tr>
    <td><b>Test Problem</b></td>
    <td>Rosenbrock Banana Function</td>
    <td>$f(x_1, x_2) = 100(x_2 - x_1^2)^2 + (1 - x_1)^2, \quad \min f(1, 1) = 0$</td>
  </tr>
  <tr>
    <td><b>Continuous</b></td>
    <td>BFGS Quasi-Newton Update</td>
    <td>$B_{k+1} = B_k + \frac{y_k y_k^T}{y_k^T s_k} - \frac{B_k s_k s_k^T B_k}{s_k^T B_k s_k}$</td>
  </tr>
  <tr>
    <td><b>Continuous</b></td>
    <td>Levenberg-Marquardt Step</td>
    <td>$(J^T J + \lambda \operatorname{diag}(J^T J)) \Delta x = -J^T r$</td>
  </tr>
  <tr>
    <td><b>Spherical Geometry</b></td>
    <td>Haversine Distance</td>
    <td>$d = 2R \arcsin\left(\sqrt{\sin^2(\frac{\Delta \varphi}{2}) + \cos \varphi_1 \cos \varphi_2 \sin^2(\frac{\Delta \lambda}{2})}\right)$</td>
  </tr>
  <tr>
    <td><b>Heuristics</b>[span_72](start_span)[span_72](end_span)[span_73](start_span)[span_73](end_span)</td>
    <td>Nearest Neighbor Rule</td>
    <td>$v_{k+1} = \arg\min_{u \in V \setminus S_k} d(v_k, u)$</td>
  </tr>
</table>

<h2>Installation and launch</h2>
<ol>
  <b>
    <li>
      <dl>
        <dt>Clone repository</dt>
        <dd><code>git clone https://github.com/Kyoryuu-lab/matlab-numerical-optimization-and-tsp.git</code></dd>
        <dd><code>cd matlab-numerical-optimization-and-tsp</code></dd>
      </dl>
    </li>
  </b>
  <b>
    <li>
      <dl>
        <dt>Execute in MATLAB or GNU Octave</dt>
        <dd>Launch MATLAB CLI or GUI and run the orchestrator:</dd>
        <dd><code>matlab -batch "main"</code> &nbsp;oder&nbsp; <code>octave --eval "main"</code></dd>
      </dl>
    </li>
  </b>
</ol>

<h2>Example of console output (compare_algorithms)</h2>
<samp>
  <p>
    ========================================================================<br />
    &nbsp;&nbsp;BENCHMARK: NICHTLINEARE OPTIMIERUNGSVERFAHREN (DIMENSION N = 50)<br />
    ========================================================================<br />
    <br />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Methode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Laufzeit_s&nbsp;&nbsp;&nbsp;&nbsp;Iterationen&nbsp;&nbsp;&nbsp;&nbsp;Optimum_fval<br />
    &nbsp;&nbsp;&nbsp;&nbsp;_________________________&nbsp;&nbsp;__________&nbsp;&nbsp;&nbsp;&nbsp;___________&nbsp;&nbsp;&nbsp;&nbsp;____________<br />
    <br />
    &nbsp;&nbsp;&nbsp;&nbsp;{'Nelder-Mead (Simplex)'}&nbsp;&nbsp;&nbsp;&nbsp;0.0482&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2450&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.241e-03<br />
    &nbsp;&nbsp;&nbsp;&nbsp;{'Steepest Descent'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}&nbsp;&nbsp;&nbsp;&nbsp;0.0315&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;412&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3.812e-04<br />
    &nbsp;&nbsp;&nbsp;&nbsp;{'Gauss-Newton'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}&nbsp;&nbsp;&nbsp;&nbsp;0.0194&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;18&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8.140e-05<br />
    &nbsp;&nbsp;&nbsp;&nbsp;{'Levenberg-Marquardt'&nbsp;&nbsp;}&nbsp;&nbsp;&nbsp;&nbsp;0.0162&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;14&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.105e-06<br />
    &nbsp;&nbsp;&nbsp;&nbsp;{'Quasi-Newton (DFP)'&nbsp;&nbsp;&nbsp;}&nbsp;&nbsp;&nbsp;&nbsp;0.0248&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5.120e-05<br />
    &nbsp;&nbsp;&nbsp;&nbsp;{'Quasi-Newton (BFGS)'&nbsp;&nbsp;}&nbsp;&nbsp;&nbsp;&nbsp;0.0210&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;24&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.050e-06
  </p>
