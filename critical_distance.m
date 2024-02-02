function dist = critical_distance(y1, y2, O)
% y: gamma
% O: critical point cloud
rotation = eul2rotm(deg2rad([y1,y2,0]), 'XYZ');
d = zeros([1,length(O)]);
for i=1:length(O)
    p = O(:,i);
    d(i) = norm(cross(p,rotation*[0;0;1]));
end
dist = min(d);
end