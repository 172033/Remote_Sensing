function [M] = ComputeM(p)

% wind speed
d1 = 1;
% water vapour
d2 = 1;
% liquid water
d3 = 0.001;
% sea surface temp
d4 = 10;
% ice temp
d5 = 2;
% ice concentration
d6 = 0.1;
% multi year ice fraction
d7 = 0.1;


D = [d1 d2 d3 d4 d5 d6 d7];


p1a = p + [d1, 0, 0, 0, 0, 0, 0];
p1b = p - [d1, 0, 0, 0, 0, 0, 0];
p2a = p + [0, d2, 0, 0, 0, 0, 0];
p2b = p - [0, d2, 0, 0, 0, 0, 0];
p3a = p + [0, 0, d3, 0, 0, 0, 0];
p3b = p - [0, 0, d3, 0, 0, 0, 0];
p4a = p + [0, 0, 0, d4, 0, 0, 0];
p4b = p - [0, 0, 0, d4, 0, 0, 0];
p5a = p + [0, 0, 0, 0, d5, 0, 0];
p5b = p - [0, 0, 0, 0, d5, 0, 0];
p6a = p + [0, 0, 0, 0, 0, d6, 0];
p6b = p - [0, 0, 0, 0, 0, d6, 0];
p7a = p + [1, 0, 0, 0, 0, 0, d7];
p7b = p - [1, 0, 0, 0, 0, 0, d7];


T_A = [
transpose(ComputeT(p1a) - ComputeT(p1b));
transpose(ComputeT(p2a) - ComputeT(p2b));
transpose(ComputeT(p3a) - ComputeT(p3b));
transpose(ComputeT(p4a) - ComputeT(p4b));
transpose(ComputeT(p5a) - ComputeT(p5b));
transpose(ComputeT(p6a) - ComputeT(p6b));
transpose(ComputeT(p7a) - ComputeT(p7b))
];


M = zeros([10 7]);

for i = 1:10
   for j = 1:7
       M(i,j) = T_A(j,i) / D(j);
   end
end






