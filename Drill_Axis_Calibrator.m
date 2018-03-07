% Bo Chen
% 10190141
% 14bc57
 
% CISC 330
% December 5th, 2017 
% Assignment 3: Calibration of a Tracked Surgical Drill

% Drill_Axis_Calibrator calibrates the drill axis given an aray of A B C 
% markers in various piviot angles
% Input: array of (A,B,C) markers. 
% Output: vm

function Vm = Drill_Axis_Calibrator(A, B, C)
    
    % Normal of each plane of circle points 
    % Help to determine the vector normal to the plane https://goo.gl/Rr724W
    [N1,~] = eig((bsxfun(@minus,A',mean(A.',1)))'* (bsxfun(@minus,A',mean(A.',1))));
    [N2,~] = eig((bsxfun(@minus,B',mean(B.',1)))'* (bsxfun(@minus,B',mean(B.',1))));
    [N3,~] = eig((bsxfun(@minus,C',mean(C.',1)))'* (bsxfun(@minus,C',mean(C.',1))));
    
    % Vt is an average of the normals
    Vt = mean([N1(:,1) N2(:,1) N3(:,1)], 2);
    
    % Marker axis values 
    [n, m] = size(A); 
    MAxis = zeros(n, m); 
    
    % Tracker to marker coordinate system
    for i = 1:n
        % Center point (average center)
        Center = mean([A(:,i) B(:,i) C(:,i)], 2);
        % Rotation and Translation matrix
    	[rotation, translation] = Rigid_Body_Transform(A(:,i), B(:,i),...
            C(:,i), A(:,i) - Center, B(:,i) - Center, C(:,i) - Center);
        
        % Marker axis
        MAxis(:, i) = rotation * (Vt - translation); 
    end 
    
    % average and normalize of marker axis
    Vm = round((mean(MAxis, 2) / norm(mean(MAxis, 2))), 4);
end

