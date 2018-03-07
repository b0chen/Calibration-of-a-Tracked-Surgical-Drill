%Rigid_Body_Transform
%Input: six markers
%Output: translation and rotation matrix

function [rotation, translation] = Rigid_Body_Transform(Pos1a, Pos1b, Pos1c, Pos2a, Pos2b, Pos2c)
% Help was used from (https://goo.gl/3DXpRA)
    
    A=[Pos1a.';Pos1b.';Pos1c.'];
    B=[Pos2a.';Pos2b.';Pos2c.'];
    N = size(A,1);
    H = (A - repmat(mean(A), N, 1))' * (B - repmat(mean(B), N, 1));
    [U,~,V] = svd(H);
    rotation = V*U';
    if det(rotation) < 0
        V(:,3) = V(:,3)*(-1);
        rotation = V*U';
    end
    translation = round((-rotation*mean(A)' + mean(B)'),10);
end