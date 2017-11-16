
%******************************
% Computation of tweaked vector p for next iteration
%
% INPUT
% 
% p is a 7 element row vector with values for:
% wind speed, water vapour, liquid water, sea surface temperature, ice temperature, ice concentration, multiyear ice fraction

% p0 is the start guess for p using a standard atmosphere
% 
% Spi is a 7-by-7 matrix, and
% it is the inversion of the covariance matrix for the standard atmosphere used in p0
%
% Sei is a 10-by-10 matrix, and
% it is the inversion of the covariance matrix for the radiometer's individual channels
% 
% M is the 10-by-7 matrix of partial derivatives
% 
% TD is a 10 element row vector denoting the difference between the computed and the measured brightness temperatures
%
% OUTPUT
% 
% p_new is a 7 element row vector, and it contains the tweaked vector p for the next iteration step
%*******************************

function [p_new] = ComputePnew(Spi, Sei, M, p0, p, TD)

p_new = p + transpose(inv(Spi + transpose(M)*Sei*M)*(transpose(M)*Sei*transpose(TD) + Spi*transpose(p0-p)));

