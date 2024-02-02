function [H,O] = pseudo_brain

% H: overall point cloud for the brain
% O: point cloud for the dont pass region

% Overall point cloud
R = 130; % assume 26cm head

q = linspace(0,90,36);  % theta
p = linspace(0,360,72); % phi
r = linspace(0,R,10);   % r

H = zeros([3,length(q)*length(p)*length(r)]);

counter = 0;
for i = 1:length(q)
    for j = 1:length(p)
        for k = 1:length(r)
            counter = counter+1;
            qq = q(i);
            pp = p(j);
            rr = r(k);

            % convert the spherical coordinates into cartesian coordinates
            x = rr*sind(qq)*cosd(pp);
            y = rr*sind(qq)*sind(pp);
            z = rr*cosd(qq);

            H(:,counter) = [x;y;z];

        end
    end
end

% figure
% plot3(H(1,:),H(2,:),H(3,:),'ro')
% xlabel('X [mm]'),ylabel('Y [mm]'),zlabel('Z [mm]')
% axis equal, grid minor, rotate3d on

% Critical point cloud
R = 130; % assume 26cm head

q1 = linspace(75,90,6);  
p1 = linspace(-180,0,20);
r1 = linspace(0.3*R,R,10); 

q2 = linspace(0,90,10);
p2 = linspace(0,180,20);
r2 = linspace(0.3*R,R,10);

O = zeros([3,length(q1)*length(p1)*length(r1)+length(q2)*length(p2)*length(r2)]);

counter = 0;
for i = 1:length(q1)
    for j = 1:length(p1)
        for k = 1:length(r1)
            counter = counter+1;
            qq = q1(i);
            pp = p1(j);
            rr = r1(k);

            % convert the spherical coordinates into cartesian coordinates
            x = rr*sind(qq)*cosd(pp);
            y = rr*sind(qq)*sind(pp);
            z = rr*cosd(qq);

            O(:,counter) = [x;y;z];

        end
    end
end

for i = 1:length(q2)
    for j = 1:length(p2)
        for k = 1:length(r2)
            counter = counter+1;
            qq = q2(i);
            pp = p2(j);
            rr = r2(k);

            % convert the spherical coordinates into cartesian coordinates
            x = rr*sind(qq)*cosd(pp);
            y = rr*sind(qq)*sind(pp);
            z = rr*cosd(qq);

            O(:,counter) = [x;y;z];

        end
    end
end
