% Bo Chen
% 10190141
% 14bc57
 
% CISC 330
% December 5th, 2017 
% Assignment 3: Calibration of a Tracked Surgical Drill

% Sphere_Fit finds the center 
% Input: marker 
% Output: center

function [center] = Sphere_Fit(marker)
    M = [-2*marker ones(length(marker),1)];
    b = zeros(length(marker),1);
    marker = marker';

    % Vector B
    for i = 1:length(marker)
        xj = [marker(1,i); marker(2,i); marker(3,i)];
        b(i) = -(xj' * xj);
    end
    
    % QR decomposition to solve c (least squares method)
    [Q, R] = qr(M, 0);
    qtb = Q' * b;
    
    % Backwards Substution 
    n = length(qtb);
    X = zeros(n,1);
    X(n) = qtb(n)/R(n,n);

    for k = n-1:-1:1
        X(k) = (qtb(k)-R(k,k+1:n)*X(k+1:n))/R(k,k);
    end
    
    center = X(1:3);
end
