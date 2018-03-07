% Bo Chen
% 10190141
% 14bc57
 
% CISC 330
% December 5th, 2017 
% Assignment 3: Calibration of a Tracked Surgical Drill

% Coordinate_Calculations computes repeditative Spherical Coordinate Calculations 
% Input: marker, Phi, Theta, pivot. 
% Output: xyz

function[xyz] = Coordinate_Calculations(marker, Phi, Theta, pivot)
       
       % Spherical Coordinate Calculations
       x = pivot(1) + ( norm(pivot - marker) * sin(Phi) * cos(Theta) );
       y = pivot(2) + ( norm(pivot - marker) * sin(Phi) * sin(Theta) );
       z = pivot(3) + ( norm(pivot - marker) * cos(Phi) );
       
       xyz = [x;y;z];
end