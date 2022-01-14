function Ai = Ai_Transform(DH_r)

    Ai = [cos(DH_r(1))  -sin(DH_r(1))*cos(DH_r(4))   sin(DH_r(1))*sin(DH_r(4))    DH_r(3)*cos(DH_r(1))
          sin(DH_r(1))  cos(DH_r(1))*cos(DH_r(4))   -cos(DH_r(1))*sin(DH_r(4))    DH_r(3)*sin(DH_r(1))
          0             sin(DH_r(4))                 cos(DH_r(4))                 DH_r(2)
          0             0                            0                            1                     ];

end