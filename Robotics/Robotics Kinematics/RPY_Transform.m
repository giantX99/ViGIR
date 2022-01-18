function RPY = RPY_Transform(Tt)
    
    RPY = [Tt(1,1)    Tt(1,2)   Tt(1,3)   0
           Tt(2,1)    Tt(2,2)   Tt(2,3)   0
           Tt(3,1)    Tt(3,2)   Tt(3,3)   0
           0          0         0         1];

end