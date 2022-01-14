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
    if (strcmp(robot, 'RRP'))        
        
        DH = [Q_initial(1),                  0,       1,       0;
              Q_initial(2),                  0,     1.1,      90;
                         0,       Q_initial(3),       0,       0];                     

        % convert the entries of the DH table
        DH(1:2, 2) = DH(1:2, 2) * unit_chosen;
        DH(:, 3) = DH(:, 3) * unit_chosen;
        %DH(:, 4) = deg2rad(DH(:, 4));
           
    elseif (strcmp(robot, 'RRPR'))
        
        DH = [Q_initial(1),                  0,       0.25,       0;
              Q_initial(2),                  0,       0.35,     180;
                         0,       Q_initial(3),          0,       0;
              Q_initial(4),             0.1145,          0,       0];
        
        % convert the entries of the DH table
        DH(4, 2) = DH(4, 2) * unit_chosen;
        DH(:, 3) = DH(:, 3) * unit_chosen;
        %DH(:, 4) = deg2rad(DH(:, 4));
        
%     elseif (strcmp(robot, 'RPRR'))
%         
%         DH = [Q_initial(1),                  0,       0.25,       0;
%                          0,       Q_initial(2),          0,      90;
%               Q_initial(3),                  0,       0.35,      90;
%               Q_initial(4),                  0,       0.10,       0];
%           
%         % convert the entries of the DH table
%         DH(:, 3) = DH(:, 3) * unit_chosen;
        
        
    elseif (strcmp(robot, 'RRPRR'))         
      %{
        DH = [Q_initial(1),                0.2,          0,       0;
              Q_initial(2),               0.14,          0,       90;
                         0,       Q_initial(3),          0,      -90;
              Q_initial(4),                  0,          0,       0;
              Q_initial(5),                  0,          0,       90];

%         DH = [Q_initial(1),                  0,          0,       -90;
%               Q_initial(2),               0.34,          0,        90;
%                          0,       Q_initial(3),          0,         0;
%               Q_initial(4),                  0,          0,       -90;
%               Q_initial(5),                  0,          0,        90];

        DH = [Q_initial(1),                  0,          0,       -90;
              Q_initial(2),               0.14,          0,        90;
                         0,       Q_initial(3),          0,         0;
              Q_initial(4),                  0,          0,       -90;
              Q_initial(5),             0.0085,          0,        90];
          
        % convert the entries of the DH table
        DH(1:2, 2) = DH(1:2, 2) * unit_chosen;
        DH(4:5, 2) = DH(4:5, 2) * unit_chosen;
        DH(:, 3) = DH(:, 3) * unit_chosen;
        %}
        
        
        DH = [Q_initial(1),                  0,          0,        90;
              Q_initial(2),                  0,       0.25,        90;
                         0,       Q_initial(3),          0,         0;
              Q_initial(4),                  0,          0,        90;
              Q_initial(5),               0.14,          0,        90;];
          
         
        % convert the entries of the DH table
        DH(1:2, 2) = DH(1:2, 2) * unit_chosen;
        DH(4:5, 2) = DH(4:5, 2) * unit_chosen;
        DH(:, 3) = DH(:, 3) * unit_chosen;
        
        
    elseif (strcmp(robot, 'RRPRRR'))
        
%         DH = [Q_initial(1),                  0,          0,       -90;
%               Q_initial(2),               0.14,          0,        90;
%                          0,       Q_initial(3),          0,         0;
%               Q_initial(4),                  0,          0,       -90;
%               Q_initial(5),                  0,          0,        90;
%               Q_initial(6),             0.0085,          0,         0];       
 
%         DH = [Q_initial(1),                  0,          0,       -90;
%               Q_initial(2),               0.14,          0,        90;
%                          0,       Q_initial(3),          0,         0;
%               Q_initial(4),                  0,          0,       -90;
%               Q_initial(5),                  0,          0,        -90;
%               Q_initial(6),             0.0085,          0,         0];    
        
%         DH = [Q_initial(1),                  0,          0,       -90;
%               Q_initial(2),               0.14,          0,        90;
%                          0,       Q_initial(3),          0,         0;
%               Q_initial(4),                  0,          0,       -90;
%               Q_initial(5),                  0,          0,        -90;
%               Q_initial(6),             0.0085,          0,         0];
          
                  
        DH = [Q_initial(1),                  0,          0,       -90;
              Q_initial(2),               0.14,          0,        90;
                         0,       Q_initial(3),          0,         0;
              Q_initial(4),                  0,          0,       -90;
              Q_initial(5),                  0,          0,        90;
              Q_initial(6),                  0,          0,         0];

%         DH = [Q_initial(1),                0.2,          0,       -90;
%               Q_initial(2),               0.14,          0,        90;
%                          0,       Q_initial(3),          0,         0;
%               Q_initial(4),                  0,          0,       -90;
%               Q_initial(5),                  0,          0,        -90;
%               Q_initial(6),             0.0085,          0,         0];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%% This DH here is verifying the rule of thumb %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         DH = [Q_initial(1),                0.2,          0,       0;
%               Q_initial(2),               0.14,          0,       90;
%                          0,       Q_initial(3),          0,      -90;
%               Q_initial(4),                  0,          0,       0;
%               Q_initial(5),                  0,          0,       90;
%               Q_initial(6),                  0,          0,      -90];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%         DH = [Q_initial(1),                  0,          0,       -90;
%               Q_initial(2),               0.14,          0,        90;
%                        -90,       Q_initial(3),          0,         0;
%               Q_initial(4),                  0,          0,       -90;
%               Q_initial(5),                  0,          0,        90;
%               Q_initial(6),                  0,          0,         0];


%         DH = [Q_initial(1),               0.24,          0,       -90;
%               Q_initial(2),               0.34,          0,        90;
%                        -90,       Q_initial(3),          0,         0;
%               Q_initial(4),                  0,          0,       -90;
%               Q_initial(5),                  0,          0,        90;
%               Q_initial(6),             0.0085,          0,         0];
%           
          
%         DH = [Q_initial(1),                  0,          0,       -90;
%               Q_initial(2),               0.14,          0,        90;
%                          0,       Q_initial(3),          0,         0;
%               Q_initial(4),                  0,          0,       -90;
%               Q_initial(5),                  0,          0,        -90;
%               Q_initial(6),             0.0085,          0,         90];
        
        % convert the entries of the DH table
        DH(1:2, 2) = DH(1:2, 2) * unit_chosen;
        DH(4:6, 2) = DH(4:6, 2) * unit_chosen;
        DH(:, 3) = DH(:, 3) * unit_chosen;
        %DH(:, 4) = deg2rad(DH(:, 4));
       
        
        
    elseif (strcmp(robot, 'PPPRRRR'))
        
        DH = [           0,       Q_initial(1),          0,        -90;
                        -90,       Q_initial(2),          0,        -90;
                         0,       Q_initial(3),          0,         0;
              Q_initial(4),                  0,          0,        -90;
              Q_initial(5),                  0,          0,        -90;
              Q_initial(6),                  0,          0,        -90;
              Q_initial(7),                  0,          0,         0];
        
          
    elseif (strcmp(robot, 'RRPRRRR'))
        
        DH = [Q_initial(1),                  0,          0,        90;
              Q_initial(2),                  0,       0.25,        90;
                         0,       Q_initial(3),          0,         0;
              Q_initial(4),                  0,          0,        90;
              Q_initial(5),               0.14,          0,        90;
              Q_initial(6),                  0,          0,        90;
              Q_initial(7),                  0,          0,         0];
          
         
        % convert the entries of the DH table
        DH(1:2, 2) = DH(1:2, 2) * unit_chosen;
        DH(4:7, 2) = DH(4:7, 2) * unit_chosen;
        DH(:, 3) = DH(:, 3) * unit_chosen;
        
     elseif (strcmp(robot, 'RRRRRRR'))
        
        DH = [Q_initial(1),            -0.2755,          0,        90;
              Q_initial(2),                  0,          0,        90;
              Q_initial(3),             -0.410,          0,        90;
              Q_initial(4),            -0.0098,          0,        90;
              Q_initial(5),            -0.3111,          0,        90;
              Q_initial(6),                  0,          0,        90;
              Q_initial(7),            -0.2638,          0,        180];
        
        % convert the entries of the DH table
        DH(:, 2) = DH(:, 2) * unit_chosen;
        DH(:, 3) = DH(:, 3) * unit_chosen;
        
    elseif (strcmp(robot, 'RRRRR'))  
        
        DH = [Q_initial(1),            -0.2755,          0,        90;
              Q_initial(2),                  0,          0,        90;
              Q_initial(3),             -0.410,          0,        90;
              Q_initial(4),            -0.0098,          0,        90;
              Q_initial(5),            -0.2638,          0,        180];
        
        % convert the entries of the DH table
        DH(:, 2) = DH(:, 2) * unit_chosen;
        DH(:, 3) = DH(:, 3) * unit_chosen;
        
    elseif (strcmp(robot, 'RRRRRR'))    
            
        DH = [Q_initial(1),              0.700,        0.750,       -90;
              Q_initial(2),                  0,       0.1250,         0;
              Q_initial(3),                  0,       -0.055,       -90;
              Q_initial(4),             0.1500,            0,        90;
              Q_initial(5),                  0,            0,        90;
              Q_initial(6),             -0.230,            0,       180];
        
        % convert the entries of the DH table
        DH(:, 2) = DH(:, 2) * unit_chosen;
        DH(:, 3) = DH(:, 3) * unit_chosen;
        
    elseif (strcmp(robot, repmat('RRR',1,10)))
            
        DH = getDH_HDSB(Q_initial, num_module);
           
        
    end 
    
    


end