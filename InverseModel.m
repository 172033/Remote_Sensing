%comment
% *****measured brightness temperatures************************************
% (6.93v, 6.93h, 10.65v, 10.65h, 18.70v, 18.70h, 23.80v, 23.80h, 36.50v, 36.50h)

TB = [160 80 169 86 185 102 196 122 211 140];

% *****start guess for physical parameters using a standard atmosphere*****
% (wind speed, water vapour, liquid water, sea surface temperature, ice temperature, ice concentration, multiyear ice fraction)

p0 = [0 5 0 273.15 273.15 0.5 0.5];

% *****amount of perturbation to be applied to the elements of p***********

% wind speed
d1 = 0.1;
% water vapour
d2 = 0.1;
% liquid water
d3 = 0.001;
% sea surface temp
d4 = 0.1;
% ice temp
d5 = 0.1;
% ice concentration
d6 = 0.01;
% multi year ice fraction
d7 = 0.01;

% *****variance matrix for the start guess p0******************************

Sp = [
25 0 0 0 0 0 0;
0 25 0 0 0 0 0;
0 0 0.025 0 0 0 0;
0 0 0 10 0 0 0;
0 0 0 0 25 0 0;
0 0 0 0 0 1 0;
0 0 0 0 0 0 1
];

% *****variance matrix for the channels of the radiometer******************

Se = [
0.16 0 0 0 0 0 0 0 0 0;
0 0.16 0 0 0 0 0 0 0 0;
0 0 0.16 0 0 0 0 0 0 0;
0 0 0 0.16 0 0 0 0 0 0;
0 0 0 0 0.16 0 0 0 0 0;
0 0 0 0 0 0.16 0 0 0 0;
0 0 0 0 0 0 0.16 0 0 0;
0 0 0 0 0 0 0 0.16 0 0;
0 0 0 0 0 0 0 0 0.16 0;
0 0 0 0 0 0 0 0 0 0.16
];

% *****computed stuff******************************************************

Sei = inv(Se);

Spi = inv(Sp);

p = p0

for i=1:5
  M=ComputeM(p, d1, d2, d3, d4, d5, d6, d7);
  TA = transpose(ComputeT(p));
  TD = TB - TA;
  p_new = ComputePnew(Spi, Sei, M, p0, p, TD)
  p = p_new;
end

% expected values for the given brightness temperature: [5.04, 3.8445, 0.00144, 278.07, 271.46, 0, 0]






