function T = forward_kinematics(Qinit, DH)

    n_rows = length(Qinit);
    T = eye(4);
    
    for i = 1:n_rows 
       T = T * Ai_Transform(DH(i,:));
    end
    
end