function tsp_multistart_suite()
% TSP_MULTISTART_SUITE Executes multi-start greedy heuristic searches on TSPLIB ali535
% and visualizes the resulting route against the known world record.

    fprintf('========================================================================\n');
    fprintf('  TSPLIB BENCHMARK ALI535: MULTISTART-GREEDY-ROUTENOPTIMIERUNG\n');
    fprintf('========================================================================\n\n');

    world_record_ali535 = 202339; % Bekannter TSPLIB-Bestwert (in km)
    data_path = fullfile('data', 'ali535.tsp');

    if ~exist(data_path, 'file')
        fprintf('[!] Benchmark-Datei %s nicht gefunden. Generiere synthetische Testflotte...\n', data_path);
        numVertices = 60;
        coordinates = [rand(numVertices, 1)*30 + 15, rand(numVertices, 1)*50 + 10];
    else
        fid = fopen(data_path, 'rt');
        textscan(fid, '%s', 7, 'Delimiter', '\n'); % Header ueberspringen
        raw = textscan(fid, '%f %f %f');
        fclose(fid);
        coordinates = [raw{2}, raw{3}];
        numVertices = size(coordinates, 1);
    end

    % Distanzmatrix initialisieren
    fprintf('[*] Berechne paarweise Distanzmatrix ueber Haversine-Formel...\n');
    distMatrix = zeros(numVertices);
    for i = 1:numVertices
        for j = 1:numVertices
            if i ~= j
                distMatrix(i, j) = haversine_distance(coordinates(i, 1), coordinates(i, 2), ...
                                                      coordinates(j, 1), coordinates(j, 2));
            else
                distMatrix(i, j) = Inf;
            end
        end
    end

    % Multistart-Stichproben ausfuehren (10 Starts)
    numStarts = min(20, numVertices);
    bestDist = Inf;
    bestRoute = [];

    fprintf('[*] Führe Multistart-Suche mit %d zufaelligen Startpunkten durch...\n', numStarts);
    startPoints = randperm(numVertices, numStarts);

    for s = 1:numStarts
        [curDist, curRoute] = greedy_tsp(startPoints(s), distMatrix);
        if curDist < bestDist
            bestDist = curDist;
            bestRoute = curRoute;
        end
    end

    gap = ((bestDist - world_record_ali535) / world_record_ali535) * 100;
    fprintf('\n[+] Bester gefundener Rundreiseweg : %.2f km\n', bestDist);
    fprintf('[*] Bekannter TSPLIB-Weltrekord    : %d km (Abweichung: +%.2f %%)\n', world_record_ali535, gap);

    % Rundreise plotten
    figure('Name', 'TSP Tour ali535', 'Color', 'w');
    plot(coordinates(:, 2), coordinates(:, 1), 'b.', 'MarkerSize', 6);
    hold on;
    tourCoords = coordinates(bestRoute, :);
    plot(tourCoords(:, 2), tourCoords(:, 1), 'r-', 'LineWidth', 1.2);
    plot(tourCoords(1, 2), tourCoords(1, 1), 'go', 'MarkerSize', 8, 'MarkerFaceColor', 'g');
    xlabel('Laengengrad'); ylabel('Breitengrad');
    title(sprintf('Kombinatorische TSP-Tour (Laenge: %.1f km)', bestDist));
    grid on;
end
