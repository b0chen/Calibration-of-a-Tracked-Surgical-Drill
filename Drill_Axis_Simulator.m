% Bo Chen
% 10190141
% 14bc57
 
% CISC 330
% December 5th, 2017 
% Assignment 3: Calibration of a Tracked Surgical Drill

% Drill_Axis_Simulator generates points for Drill_Axis_Calibrator
% Input: n poses, array of (A,B,C) markers, center. 
% Output: [A, B, C]

function [A, B, C] = Drill_Axis_Simulator(n, a, b, c, center)
    % Generates n poses in full range, for drill axis calibration. a, b, c
    % represent starting positions.
    
    A = zeros(3, n); 
    B = zeros(3, n); 
    C = zeros(3, n); 
    
    for i = 1:n
        angle = 2*pi*rand;
        
        % Pose A
        % Radius * random angle + center 
        xA = (norm(center(1) - a(1))) * cos(angle) + center(1); 
        yA = (norm(center(1) - a(1))) * sin(angle) + center(2); 
        % no rotation about the z-axis (only 2 freedoms) 
        zA = a(3) + center(3); 
        A(:, i) = [xA; yA; zA]; 
        
        % Pose B
        xB = (norm(center(1) - b(1))) * cos(angle) + center(1); 
        yB = (norm(center(1) - b(1))) * sin(angle) + center(2); 
        zB = b(3) + center(3); 
        B(:, i) = [xB; yB; zB]; 
        
        % Pose C
        xC = (norm(center(1) - c(1))) * cos(angle) + center(1); 
        yC = (norm(center(1) - c(1))) * sin(angle) + center(2); 
        zC = c(3) + center(3); 
        C(:, i) = [xC, yC, zC]; 
        
    end
end

