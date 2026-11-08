function [totalDistance, route] = greedy_tsp(startVertex, distMatrix)
% GREEDY_TSP Solves Traveling Salesperson Problem via Nearest-Neighbor heuristic.
    numVertices = size(distMatrix, 1);
    route = zeros(1, numVertices + 1);
    route(1) = startVertex;

    visited = false(1, numVertices);
    visited(startVertex) = true;

    totalDistance = 0;
    currentVertex = startVertex;

    for step = 1:(numVertices - 1)
        distances = distMatrix(currentVertex, :);
        distances(visited) = Inf; % Bereits besuchte Knoten ausschliessen

        [minDist, nextVertex] = min(distances);
        route(step + 1) = nextVertex;
        visited(nextVertex) = true;
        totalDistance = totalDistance + minDist;
        currentVertex = nextVertex;
    end

    % Rueckkehr zum Ausgangspunkt
    totalDistance = totalDistance + distMatrix(currentVertex, startVertex);
    route(end) = startVertex;
end
