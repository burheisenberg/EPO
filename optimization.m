clear all, close all, clc

% get the tumor coordinates
TCC = [-40,-30,50]';

% obtain the point clouds somehow
[H,O] = pseudo_brain;

% create the needle path for demonstration (tumor centered coordinates)
needle_path = [0,0; 0,0; linspace(0,200,2)];

%% Optimization

% switch to tumor centered coordinates for the easiness of the analysis
H = H-TCC;
O = O-TCC;

% iterate over gamma1 and gamma2 angles
y1 = linspace(0,90,50);
y2 = linspace(0,90,50);

cost = zeros([length(y1),length(y2)]);

counter=0;
for i=1:length(y1)
    for j=1:length(y2)

        yx = y1(i);
        yy = y2(j);

        cost(i,j) = -critical_distance(yx, yy, O, needle_path)+insertion_length(yx,yy,H,needle_path);

    end
end

minimum_cost = min(min(cost));

[I,J] = find(cost == minimum_cost);

I = I(1); J=J(1);
yx=y1(I), yy=y2(J)


crit_dist = critical_distance(yx, yy, O, needle_path)
need_leng = insertion_length(yx,yy,H, needle_path)
minimum_cost

% switch back to original coordinates after the analysis
H = H+TCC;
O = O+TCC;

%% visualization


% create the needle path for demonstration
needle_path = [0,0; 0,0; linspace(0,200,2)];
rotation = eul2rotm(deg2rad([yx,yy,0]), 'XYZ');
needle_path = rotation*needle_path+TCC;

% draw the overall point cloud and critical point cloud
figure
hold on
plot3(H(1,:),H(2,:),H(3,:),'bo')
plot3(O(1,:),O(2,:),O(3,:),'ro')
plot3(needle_path(1,:),needle_path(2,:),needle_path(3,:),'ko-','LineWidth',2)
xlabel('X [mm]'),ylabel('Y [mm]'),zlabel('Z [mm]')
axis equal, grid minor, rotate3d on
legend('Overall Point Cloud','Do Not Pass Region','Needle Path')


