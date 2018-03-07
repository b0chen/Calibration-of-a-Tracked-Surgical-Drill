% Bo Chen
% 10190141
% 14bc57
 
% CISC 330
% December 5th, 2017 
% Assignment 3: Calibration of a Tracked Surgical Drill

% Drill_Tip_Simulator generates points for Drill_Tip_Calibrator
% Input: n poses, array of (A,B,C) markers, center. 
% Output: [A, B, C]

function [A, B, C] = Drill_Tip_Simulator(n, a, b, c, center)
    % Initilize first pose
    A = zeros(3, n);
    C = zeros(3, n);
    B = zeros(3, n);
    A(:, 1) = a;
    B(:, 1) = b;
    C(:, 1) = c;
    
    % Initial Phi
    InitalPhiA = acos((a(3) - center(3)) / norm(center - a));
    InitalPhiB = acos((b(3) - center(3)) / norm(center - b));
    InitalPhiC = acos((c(3) - center(3)) / norm(center - c));
    
    % Generate poses
    count = 1;
    while count < n
     
       %Generate new pose for point A (generate random pose)
       Phi = (pi/2) * rand;
       Theta = 2*pi*rand; 
       newA = Coordinate_Calculations(a, Phi, Theta, center);       
       
       % New position markers after applying change in angles
       PhiB = mod((InitalPhiB + (Phi - InitalPhiA)) + pi/2, pi) - pi/2;
       ThetaB = wrapTo2Pi (Theta);  
       
       newB = Coordinate_Calculations(b, PhiB, ThetaB, center);
       
       PhiC = mod((InitalPhiC + (Phi - InitalPhiA)) + pi/2, pi) - pi/2;
       ThetaC = wrapTo2Pi (Theta);
       
       newC = Coordinate_Calculations(c, PhiC, ThetaC, center);

       % Check if side lengths have changed (check for errors)
       if norm(newA - newB) == (norm(A(:, 1) - B(:, 1))) && norm(newC - newB) == (norm(C(:, 1) - B(:, 1)))
            count = count + 1;
            A(:, count) = newA;
            B(:, count) = newB;
            C(:, count) = newC;
       end
       
    end
end

