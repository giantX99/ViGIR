function Q = Quaternion_Transform(q0, rot)

    q_rest = (1/(4*q0))*[rot(3,2)-rot(2,3) , rot(1,3)-rot(3,1) , rot(2,1)-rot(1,2)];
    
    Q = [q0; q_rest(1); q_rest(2); q_rest(3)];

end