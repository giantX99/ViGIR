function q0 = q0_Quaternion(rot)

    q0 = 0.5*sqrt(1+rot(1,1)+rot(2,2)+rot(3,3));

end