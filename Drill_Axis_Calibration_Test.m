% Bo Chen
% 10190141
% 14bc57
 
% CISC 330
% December 5th, 2017 
% Assignment 3: Calibration of a Tracked Surgical Drill

% Drill_Axis_Calibration_Test tests Drill_Axis_Calibrator using points from
% Drill_Axis_Simulator then graphs the output
% Output: Vm and Angle

% Using ideal points
Ad = [5; 0; 26];
Bd = [11; 0; 20];
Cd = [5; 0 ; 20];

% Simulation
[A, B, C] = Drill_Axis_Simulator(20, Ad, Bd, Cd, [0;0;0]);

% Calibration
Vm = Drill_Axis_Calibrator(A, B, C)
Angle = atan2d(norm(cross(Vm, [0;0;1])), dot(Vm, [0;0;1]))

% Graph
figure
hold on
title('Drill Axis Calibtator')
scatter3(0,0,0,'x','r')
xlabel('X')
ylabel('Y')
zlabel('Z')

for i = 1:20
   fill3([A(1, i) B(1, i) C(1, i)],  [A(2, i) B(2, i) C(2, i)],...
       [A(3, i) B(3, i) C(3, i)], [1; 2; 3])
end

