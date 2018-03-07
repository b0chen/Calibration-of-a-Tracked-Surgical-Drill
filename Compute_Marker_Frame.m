% Bo Chen
% 10190141
% 14bc57
 
% CISC 330
% December 5th, 2017 
% Assignment 3: Calibration of a Tracked Surgical Drill

% Compute_Marker_Fram defines Fm marker frame
%Input: (A,B,C). 
%Output: Ctrm and base vectors (xm ym zm.)

function [Centre, x, y, z] = Compute_Marker_Frame(A,B,C)

    Centre = mean([A B C], 2);

    %find base vectors.
    x = B - A;
    z = cross(x, C - A);
    y = cross(z, x);

    %Normalize base vectors.
    x = x/norm(x);
    z = z/norm(z);
    y = y/norm(y);
    
end

