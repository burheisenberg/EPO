function dist = critical_distance(y1, y2, O, L)
% y: gamma
% O: critical point cloud
% L: line segment (if defined), where L(1) TCC

% rotation transformation
rotation = eul2rotm(deg2rad([y1,y2,0]), 'XYZ');

d = zeros([1,length(O)]);

if nargin == 3

    for i=1:length(O)
        p = O(:,i);
        d(i) = norm(cross(p,rotation*[0;0;1]));
    end

elseif nargin == 4

    for i=1:length(O)
        p = O(:,i);
        d(i) = norm(cross(p,rotation*[0;0;1]));

        % if the projection is not inside the line segment
        if dot( L(:,1)-L(:,2), L(:,1)-p ) < 0
            d(i) = norm( L(:,1)-p );
        end

    end

end

dist = min(d);


end