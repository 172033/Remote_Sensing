function [S] = ComputeS(Spi, Sei, M)

S = inv(Spi + transpose(M)*Sei*M);

