%******************************
% INPUT
%
% T_A is a 10 element row vector with computed values for brightness temperatures:
% 6.93v, 6.93h, 10.65v, 10.65h, 18.70v, 18.70h, 23.80v, 23.80h, 36.50v, 36.50h
%
% OUTPUT
% 
% q is a 7 element row vector with values for:
% wind speed, water vapour, liquid water, sea surface temperature, ice temperature, ice concentration, multiyear ice fraction
%*******************************

function[q,s]=InverseModel(TB)
%function[q]=InverseModel(TB)
% *****start guess for physical parameters using a standard atmosphere from NWP*****
% (wind speed, water vapour, liquid water, sea surface temperature, ice temperature, ice concentration, multiyear ice fraction)

p0 = [6.1327 7.7035 0.0295 273.5503 265.0088 0.5000 0.5000]; 
%p0 = [0 5 0 273.15 273.15 0.5 0.5]; % first try

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

% Sp = [
% 25 0 0 0 0 0 0;
% 0 25 0 0 0 0 0;
% 0 0 0.025 0 0 0 0;
% 0 0 0 10 0 0 0;
% 0 0 0 0 25 0 0;
% 0 0 0 0 0 1 0;
% 0 0 0 0 0 0 1
% ];

% Variance matrix for the mean physical parameters calculated from the NWP
Sp = [
9.2865 0 0 0 0 0 0;
0 62.1415 0 0 0 0 0;
0 0 0.0056 0 0 0 0;
0 0 0 22.5386 0 0 0;
0 0 0 0 98.6461 0 0;
0 0 0 0 0 1 0;
0 0 0 0 0 0 1
];

% *****variance matrix for the channels of the radiometer******************
% All channels on
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

% Se that can be varied to exclude channels in analysis 
% (6.93v, 6.93h, 10.65v, 10.65h, 18.70v, 18.70h, 23.80v, 23.80h, 36.50v, 36.50h)
% Se = [
% 10000 0 0 0 0 0 0 0 0 0;
% 0 10000 0 0 0 0 0 0 0 0;
% 0 0 10000 0 0 0 0 0 0 0;
% 0 0 0 10000 0 0 0 0 0 0;
% 0 0 0 0 0.16 0 0 0 0 0;
% 0 0 0 0 0 0.16 0 0 0 0;
% 0 0 0 0 0 0 0.16 0 0 0;
% 0 0 0 0 0 0 0 10000 0 0;
% 0 0 0 0 0 0 0 0 0.16 0;
% 0 0 0 0 0 0 0 0 0 0.16
% ];

% *****computed stuff******************************************************

Sei = inv(Se);

Spi = inv(Sp);

p = p0;

for i=1:5
  M=ComputeM(p, d1, d2, d3, d4, d5, d6, d7);
  TA = transpose(ComputeT(p));
  TD = TB - TA;
  p_new = ComputePnew(Spi, Sei, M, p0, p, TD);
  p = p_new;
end

S = inv(Spi + M'*Sei*M); % Computing S matrix: error on retrieval from inverse model

q = p;
s = S;







