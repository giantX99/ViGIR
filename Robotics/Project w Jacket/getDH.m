% Retrieve the DH table of a robotic manipulator.
% Example: DH = getDH(robot, Q_initial)
% Inputs:  robot = a string representing the robot to load
%          Q_initial = a vector representing the initial joint
%          configuration of the robot to load
% Outputs: DH = a matrix representing the corresponding DH table

function DH = getDH(robot, Q_initial, unit_chosen, num_module)

    %% build the DH table
    % Here, we are using the RRP example for the 3DoF robot used in Bo's
    % paper    
    if (strcmp(robot, 'RR'))        
        
        DH = [Q_initial(1),                  0,       0.5,       0;
              Q_initial(2),                  0,       0.5,       0];                    

        % convert the entries of the DH table
        DH(:, 2) = DH(:, 2) * unit_chosen;
        DH(:, 3) = DH(:, 3) * unit_chosen;     
            
    elseif (strcmp(robot, repmat('RRR',1,10)))
            
        DH = getDH_HDSB(Q_initial, num_module);
           
        
    end 
    
    


end