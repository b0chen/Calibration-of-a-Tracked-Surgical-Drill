% Bo Chen
% 10190141
% 14bc57
 
% CISC 330
% December 5th, 2017 
% Assignment 3: Calibration of a Tracked Surgical Drill

% Drill_Tip_Calibrator finds the tip of the drill in the marker coordinate
% system, given an aray of A B C markers in various piviot angles
% Input: array of (A,B,C) markers
% Output: Tm

function Tm = Drill_Tip_Calibrator(A, B, C)
    cols = length(A);
    
    % Average center of the markers in various piviot angles (poviot point)
    Tt = [round(mean([Sphere_Fit(A'), Sphere_Fit(B'), Sphere_Fit(C')], 2), 4); 1];
    pC = zeros(3, cols);
    
    % Base marker frame
    % Center point (average center)
    Center = mean([A(:,1) B(:,1) C(:,1)], 2);
    
    % Base vectors
    x1 = B(:,1) - A(:,1);
    z1 = cross(x1, C(:,1) - A(:,1));
    y1 = cross(z1, x1);
    
    % Normalized base vectors
    x1 = x1/norm(x1);
    z1 = z1/norm(z1);
    y1 = y1/norm(y1);  
    
    
    for i = 1:cols
        % Coordinate system for each markers at pivot i
        % Base vectors
        x2 = B(:,i) - A(:,i);
        z2 = cross(x2, C(:,i) - A(:,i));
        y2 = cross(z2, x2);
        
        % Normalized base vectors
        x2 = x2/norm(x2);
        z2 = z2/norm(z2);
        y2 = y2/norm(y2);
        
        % Translation matrix
        [ ~ , translation] = Rigid_Body_Transform(A(:, i), B(:, i),...
            C(:, i), (A(:, i) - Center) , (B(:, i) - Center),...
            (C(:,i) - Center));
        
        % Rotation matrix (for base coordinate frame) 
        rotationMatrix = [dot(x1,x2), dot(x1,y2), dot(x1, z2), 0;...
            dot(y1,x2), dot(y1,y2), dot(y1, z2), 0; dot(z1,x2),...
            dot(z1,y2), dot(z1, z2), 0; 0,0,0,1];
      
        % Translation matrix
        v = [1 1 1 1];
        t = diag(v);
        t = t + horzcat(zeros(4,3),[translation;0]); 

        % Apply transformation and rotation 
        val = t * rotationMatrix * Tt;
        pC(:, i) = val(1:3);
    end

    % Average of piviots
    Tm = mean(pC, 2);  
end