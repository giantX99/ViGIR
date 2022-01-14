

%% Get DH

t = [15.6, 70.4, 29.0, 89.3, 65.0, 12.9];
a = [0, 0.5, 1.2, 0.7, 0, 0];
t = deg2rad(t);

DH = [t(1)  0   a(1)    90
      t(2)  0   a(2)    0
      t(3)  0   a(3)    0
      t(4)  0   a(4)    -90
      t(5)  0   a(5)    90
      t(6)  0   a(6)    0];


%% Get Ai matrices

A1 = Ai_Transform(DH(1, :));
A2 = Ai_Transform(DH(2, :));
A3 = Ai_Transform(DH(3, :));
A4 = Ai_Transform(DH(4, :));
A5 = Ai_Transform(DH(5, :));
A6 = Ai_Transform(DH(6, :));

%% Get Total transformation

Tt = A1*A2*A3*A4*A5*A6;


%% Get Rotation

rot = Tt(1:3, 1:3);

%% Get Translation

trans = Tt(1:3, 4);

%% RPY

RPY = RPY_Transform(Tt);

r = atan2(RPY(2,1), RPY(1,1));
p = atan2(-(RPY(3,1)) , ((RPY(1,1)*cos(r))+(RPY(2,1)*sin(r))));
y = atan2((-RPY(2,3)*cos(r))+(RPY(1,3)*sin(r)) , (RPY(2,2)*cos(r))-(RPY(1,2)*sin(r)));


r = rad2deg(r);
p = rad2deg(p);
y = rad2deg(y);

%% Euler Angles

Euler = Euler_Transform(Tt);

Eu_1 = atan2(Euler(2,3) , Euler(1,3));
Eu_2 = atan2( (Euler(1,3)*cos(Eu_1))+(Euler(2,3)*sin(Eu_1)) , Euler(3,3));
Eu_3 = atan2( (-Euler(1,1)*sin(Eu_1))+(Euler(2,1)*cos(Eu_1)) , (-Euler(1,2)*sin(Eu_1))+(Euler(2,2)*cos(Eu_1)) );

Eu_Angles = [Eu_1 ; Eu_2 ; Eu_3];

Eu_Angles = rad2deg(Eu_Angles);

%% Quaternion

q0 = q0_Quaternion(rot);

Q = Quaternion_Transform(q0, rot);

