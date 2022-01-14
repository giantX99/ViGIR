%% Siavash's implementation in Matlab - Jacket

%% clear the workspace
clc, clear

%% initialize important variables
robot = 'RR';
motion = '2DoF';

inverses = ["MP"];
units  = ["m"];

%% create a folder to store the results
% motion is the name of the directory when the result are stored
if ~exist(motion, 'dir')
    mkdir(motion)
end

          
%% TODO: Read a list of 2DoF positions ????????
% read a csv file 
P_list = []; %positions = (x,y) in CSV file


%% TODO: Create a loop through the all the rows in P_list
[num_rowsP, num_colmsP] = size(P_list);

for p = 1:num_rowsP %start reading P_list[]

    for j1=1:length(inverses)  %it will loop only once for now
        for i1=1:length(units) %it will loop only once for now

            str_unit_chosen = units(i1);
            inverse_chosen = inverses(j1);


            %% choose the unit to investigate
            if(str_unit_chosen == "m")                     % choose the m
                unit_chosen = 1;                           
            elseif (str_unit_chosen == "dm")               % choose the dm
                unit_chosen = 10;
            elseif (str_unit_chosen == "cm")               % choose the cm
                unit_chosen = 100;
            elseif (str_unit_chosen == "mm")               % choose the mm
                unit_chosen = 1000;
            end       
    % ignore for now


            %% Specify the chosen values of alpha 
            %indexes = [0.03; 0.06; 0.09; 0.1; 0.2; 0.4; 0.6; 0.8; 1];
            indexes = [1];

            %% Run through the program
            for j = 1:length(indexes) %it will loop only once for now
                %% provide the initial joint configuration, the DH, and the desired pose
                if(strcmp(robot, 'RR'))
                    Q_initial = [0; 0]; %% from base position 

                    %% TODO: Adapt 
                    DH = getDH(robot, Q_initial, unit_chosen);

                    %% TODO: Read from the P_list
                    D_final = [0.5, 0.5];  %                

                    D_final = D_final * unit_chosen;

                end

                %% Initialize D_estimated, Q_current, delta_Q and J to zeros and other values
                % these variables will help store values during the computation
                D_estimated         = zeros(length(D_final), 1);
                delta_Q             = zeros(length(Q_initial), 1);
                J                   = zeros(length(D_final), length(Q_initial));
                position_error      = 0.001 * unit_chosen;  % setting the accepted error to 1mm
                orientation_error   = 0.1;
                iterations          = 5000; 

                % current attenuation factor being processed
                alpha = indexes(j);
                fprintf("Processing alpha = %f\n", alpha);

                %% Compute and store the initial value in .txt files
                T = forwardKinematics(DH);
                D_current = getPose(T, length(D_final));
                D_initial = D_current;
                Q_current = Q_initial;

                % save to file
                saveToFile(D_current, motion, str_unit_chosen, inverse_chosen, alpha, "w");

                %% Loop until the solution is found
                fprintf("\nBeginning the iterative process");
                tic     % check for how long the loop is runnig for

                for i=1:iterations

                    % check if the acceptable error is reached, if not keep on with the estimation
                    if (abs(D_final(1) - D_estimated(1)) > position_error) || (abs(D_final(2) - D_estimated(2)) > position_error)

                        fprintf("\n\nIteration [%d]", i);

                        % set the perturbations values per joints
                        for c=1:length(robot)
                            if (strcmp(robot(c), 'R'))
                            delta_Q(c) = 0.05;
                            elseif (strcmp(robot(c), 'P'))
                            delta_Q(c) = 0.1 * unit_chosen;
                            end
                        end

                        % display the current estimated joint
                        displayJoints(Q_current, robot);

                        % compute the initial pose vector
                        T = forwardKinematics(DH);
                        D_current = getPose(T, length(D_final));

                        % display the current estimated joint
                        displayPose(D_current, length(D_final));

                        % build the jacobian matrix
                        % add incremental motion/small perturbations to each joint
                        D_temp = zeros(length(D_final), length(Q_current));
                        for k=1:length(Q_current)
                            Q_temp = Q_current;
                            Q_temp(k) = Q_temp(k) + delta_Q(k);
                            DH = getDH(robot, Q_temp, unit_chosen);
                            T = forwardKinematics(DH);        
                            D_temp(:, k) = getPose(T, length(D_final)); 
                            J(:,k) = (D_temp(:, k) - D_current)/delta_Q(k);
                        end

                        % Display the current jacobian
                        fprintf("\nCurrent Jacobian:")
                        J  %#ok<NOPTS>

                        % Compute the inverse jacobian
                        if (inverse_chosen == "MP")                     % Use the Moore-Penrose
                            inv_J = pinv(J);                    
                        end

                        fprintf("\nInverse Jacobian:")
                        inv_J  %#ok<NOPTS>

                        % Estimate the current distance between D_Final and D_current
                        d_D = alpha * (D_final - D_current);
                        fprintf("\nd_D - current difference in pose:")
                        d_D %#ok<NOPTS>

                        % Estimate the current d_Q
                        fprintf("\nd_Q - current difference in joint:")
                        d_Q = inv_J * d_D;
                        d_Q %#ok<NOPTS>

                        % Add the current estimated joint configuration            
                        Q_current = Q_current + d_Q;
                        DH = getDH(robot, Q_current, unit_chosen);
                        T = forwardKinematics(DH);        
                        D_current = getPose(T, length(D_final)); 

                        for r=1:length(robot)
                            if (strcmp(robot(r), 'R'))
                                Q_current(r) = wrapTo360(Q_current(r));
                            end
                        end


                    else
                        break        
                    end

                    %% Write the calculation in a file
                    saveToFile(D_current, motion, str_unit_chosen, inverse_chosen, alpha, "a");

                    % the current pose estimation is:
                    D_estimated = D_current;


                end % end for loop iterations

                %% Summary of the computation
                fprintf("######################################################\n\n")
                fprintf("Estimated Joint Vector:")
                Q_current %#ok<NOPTS

                fprintf("Initial Joint Vector:")
                Q_initial %#ok<NOPTS

                fprintf("Initial Pose Vector:")
                D_initial %#ok<NOPTS

                fprintf("Desired Pose Vector:")
                D_final %#ok<NOPTS>

                fprintf("Estimated Pose Vector:")
                D_current %#ok<NOPTS>


                fprintf("Pose error:\n")
                Position_error = sqrt(sum((D_final - D_current).^2));
                %Position_error = sqrt(sum((D_final(1:3) - D_current(1:3)).^2));
                fprintf("Position error: %f", (Position_error));

                %Orientation_error = sum(abs(D_final(4:6) - D_current(4:6)))/3;
                %fprintf("\nOrientation error: %f", Orientation_error);

                fprintf("\n\nTotal number of iterations: %d", i);   

                fprintf("\n")
                toc %finishes recording time
                elapsedTime = toc;



            end % end for loop multiple alphas

        end
    end
end %end reading from P_list[]