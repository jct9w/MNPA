R1 = 1;
C = 0.25;
R2 = 2;
L = 0.2;
R3 = 10;
al = 100;
R4 = 0.1;
Ro = 1000;

G1 = 1;
G2 = 1/2;
G3 = 1/10;
G4 = 1/0.1;
Go = 1/1000;

C = [   C   -C  0   0   0   0   0   0;
        -C  C   0   0   0   0   0   0;
        0   0   0   0   0   0   0   0;
        0   0   0   0   0   0   0   0;
        0   0   0   0   0   0   0   0;
        0   0   0   0   0   0   -L  0;
        0   0   0   0   0   0   0   0;
        ];

G = [   G1  -G1 0   0   0   1   0   0;
        -G1 G1+G2 0 0   0   0   1   0;
        0   0   G3  0   0   0   -1  0;
        0   0   0   G4  -G4 0   0   1;
        0   0   0   G4  G4+Go 0 0   0;
        1   0   0   0   0   0   0   0;
        0   1   -1  0   0   0   0   0;
        0   0   -al/R3 1 0  0   0   0;
        ];

F = zeros(8);

figure(1)
title('DC analysis')
V0 = [];
V3 = [];
i = 1;
for Vin = -10:0.1:10
    F(6) = Vin;
    Vdc = G\F;
    V3(i) = Vdc(3);
    V0(i) = Vdc(5);
    i = i+1;
end
i = 1;
plot(-10:0.1:10,V0);
hold on
plot(-10:0.1:10,V3);
hold on
legend('V0','V3');

figure(2)
title('AC analysis')
V0 = [];
F(8) = 1;
i = 1;
for w = 10:1000000
    Vac = (G+C*w*1j)\F;
    V0(i) = Vac(5);
    i = i+1;
end
i = 1;
plot(10:1000000,V0);
hold on
