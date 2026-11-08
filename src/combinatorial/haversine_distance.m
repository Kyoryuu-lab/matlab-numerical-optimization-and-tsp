function d = haversine_distance(lat1, lon1, lat2, lon2)
% HAVERSINE_DISTANCE Computes spherical great-circle distance in km.
    R = 6371.0; % Mittlerer Erdradius in km
    dLat = deg2rad(lat2 - lat1);
    dLon = deg2rad(lon2 - lon1);

    a = sin(dLat / 2)^2 + cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * sin(dLon / 2)^2;
    c = 2 * atan2(sqrt(a), sqrt(1 - a));
    d = R * c;
end
