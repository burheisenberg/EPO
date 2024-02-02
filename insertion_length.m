function len = insertion_length(y1, y2, H)

% y: gamma
% H: overall point cloud

rotation = eul2rotm(deg2rad([y1,y2,0]), 'XYZ');

g = zeros([1,length(H)]);

% calculate the distances between the line and the point cloud
for i=1:length(H)
    p = H(:,i);
    g(i) = norm(cross(p,rotation*[0;0;1]));
end

% take the subset of close points (less than 1cm)
H = H(:,g<30);

q = sqrt( H(1,:).^2+H(2,:).^2+H(3,:).^2 );

len = max(q);
end

