
%******************************
% Computation of partial derivatives
%
% INPUT
% 
% p is a 7 element row vector with values for:
% wind speed, water vapour, liquid water, sea surface temperature, ice temperature, ice concentration, multiyear ice fraction
% 
% d1, d2, ... are scalars that denote the amount of perturbation applied to the elements of p
%
% OUTPUT
% 
% M is the 10-by-7 matrix of partial derivatives:
% each row corresponds to a radiometer channel,
% each column corresponds to one physical parameter
%*******************************



function [M] = ComputeM(p, d1, d2, d3, d4, d5, d6, d7)




D = [d1 d2 d3 d4 d5 d6 d7];


p1a = p + [d1, 0, 0, 0, 0, 0, 0];
%p1b = p - [d1, 0, 0, 0, 0, 0, 0];
p2a = p + [0, d2, 0, 0, 0, 0, 0];
%p2b = p - [0, d2, 0, 0, 0, 0, 0];
p3a = p + [0, 0, d3, 0, 0, 0, 0];
%p3b = p - [0, 0, d3, 0, 0, 0, 0];
p4a = p + [0, 0, 0, d4, 0, 0, 0];
%p4b = p - [0, 0, 0, d4, 0, 0, 0];
p5a = p + [0, 0, 0, 0, d5, 0, 0];
%p5b = p - [0, 0, 0, 0, d5, 0, 0];
p6a = p + [0, 0, 0, 0, 0, d6, 0];
%p6b = p - [0, 0, 0, 0, 0, d6, 0];
p7a = p + [0, 0, 0, 0, 0, 0, d7];
%p7b = p - [0, 0, 0, 0, 0, 0, d7];


T_M = [
transpose(ComputeT(p1a) - ComputeT(p));
transpose(ComputeT(p2a) - ComputeT(p));
transpose(ComputeT(p3a) - ComputeT(p));
transpose(ComputeT(p4a) - ComputeT(p));
transpose(ComputeT(p5a) - ComputeT(p));
transpose(ComputeT(p6a) - ComputeT(p));
transpose(ComputeT(p7a) - ComputeT(p))
];


M = zeros([10 7]);

for i = 1:10
   for j = 1:7
       M(i,j) = T_M(j,i) / (D(j));
   end
end

M; % M is being outputted for troubleshooting






