function len = insertion_length(y1, y2, H, L)

% y: gamma
% H: overall point cloud
% L: line segment (if defined), where L(1) TCC

% rotation transformation
rotation = eul2rotm(deg2rad([y1,y2,0]), 'XYZ');

g = zeros([1,length(H)]);

if nargin ==3
    % calculate the distances between the line and the point cloud
    for i=1:length(H)
        p = H(:,i);
        g(i) = norm(cross(p,rotation*[0;0;1]));
    end

elseif nargin == 4

    for i=1:length(H)
        p = H(:,i);
        g(i) = norm(cross(p,rotation*[0;0;1]));

        % if the projection is not inside the line segment
        if dot( L(:,1)-L(:,2), L(:,1)-p ) < 0
            g(i) = norm( L(:,1)-p );
        end

    end

end

% take the subset of close points (less than 1cm)
H = H(:,g<10);

q = sqrt( H(1,:).^2+H(2,:).^2+H(3,:).^2 );

len = max(q);
end

