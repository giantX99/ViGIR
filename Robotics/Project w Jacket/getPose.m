% Retrieve the end-effector pose form the total transformation matrix T
% of a robotic manipulator.
% Example: D = getPose(T, n)
% Inputs:  T = transformation matrix
%          n = number of rows to get in the pose vector
% Outputs: D = Pose vector

function D = getPose(T, n)

    D_current = zeros(n, 1); 
    % Retrieve the end-effector position
    D_current(1) = T(1,4);
    D_current(2) = T(2,4);
    D_current(3) = T(3,4);  
    
    % Retrieve the end-effector orientation  --- Roll Pitch Yaw
    %D_current(4) = atand(-T(2,1)/-T(1,1));
    D_current(4) = atand(T(2,1)/T(1,1));
    D_current(5) = atand(-T(3,1)/(T(1,1)*cosd(D_current(4))+T(2,1)*sind(D_current(4))));
    D_current(6) = atand((-T(2,3)*cosd(D_current(4))+T(1,3)*sind(D_current(4)))/(T(2,2)*cosd(D_current(4))-T(1,2)*sind(D_current(4))));    
    
    %D_current(4) = atan2d(-T(2,1), -T(1,1));
    %D_current(5) = atan2d(-T(3,1), (T(1,1)*cosd(D_current(4))+T(2,1)*sind(D_current(4))));
    %D_current(6) = atan2d((-T(2,3)*cosd(D_current(4))+T(1,3)*sind(D_current(4))), (T(2,2)*cosd(D_current(4))-T(1,2)*sind(D_current(4))));
    
    D = D_current(1:n,1);
    
end