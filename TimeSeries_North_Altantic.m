
% *****measured brightness temperatures************************************

% (6.93v, 6.93h, 10.65v, 10.65h, 18.70v, 18.70h, 23.80v, 23.80h, 36.50v, 36.50h)

%*****Inverse Algorithmon time series with open water North Altantic data set**** 

close all;
clear

% Reading data

nor = 6988;

t=csvread('SIC0_TimeSeries_NA.csv', 1, 1, [1 1 nor 37]);

%*****SELECTION OF DATA FOR NORTH ATLANTIC *****

for i=1:nor
    if (t(i,1)~= 45) || (t(i,2)~= -45)
        t(i, :)=zeros;
    end
end

t(~any(t,2), :) = [];

z = length(t);

TB=[t(:,26) t(:,25) t(:,30) t(:,29) t(:,32) t(:,31) t(:,34) t(:,33) t(:,36) t(:,35)];



% ***** CORRECT REFERENCE DATA BRIGHTNESS TEMPERATURE VECTORS *****

      % 6.93v       6.93h       10.65v      10.65h        18.70v      18.70h      23.80v        23.80h      36.50v      36.50h
COR = [ -0.2825,    -1.722,     -2.599,     -0.4337,      -12.4,      4.790,      -11.06,       0.3257,     -2.915,     -1.976;
        2.492e-2,   7.361e-2,   7.253e-2,   5.056e-2,     17.17e-2,   -3.272e-2,  14.22e-2,     5.029e-2,   4.981e-2,   5.914e-2;
        -0.6722e-4, -2.194e-4,  -2.034e-4,  -1.544e-4,    -4.294e-4,  0.7558e-4,  -3.354e-4,    -1.554e-4,  -1.264e-4,  -1.674e-4
      ];

  
for j=1:10
    for i=1:z
        TB(i,j)= - COR(3,j)*TB(i,j)^2 - (COR(2,j)-1)*TB(i,j) - COR(1,j);
    end
end


% ***** COMPUTE P FROM BRIGHTNESS TEMPERATURE USING INVERSE MODEL *****
 
pz = zeros(z,7);

for i = 1:z
    [p,S] = InverseModel(TB(i,:));
    pz(i,:) = p;
end

% use sst for part a)
p_SST= pz(:,4);

% part b)
% water vapor, liquid water, wind
jan = [pz(1:46, 2) pz(1:46, 3) pz(1:46, 1)];
jul = [pz(282:329, 2) pz(282:329, 3) pz(282:329, 1)];


% ****** Removal of Outliers (part a) ****************

th_upper=300;                            %Set the Threshold value
j_upper=0;

for i=1:z
      if p_SST(i) > th_upper
        p_SST(i)=NaN;               %Set to NaN value if condition satisfy
        j_upper=j_upper+1;
      end
end

th_lower=270;                             %Set the Threshold value
j_lower=0;

for i=1:z
      if p_SST(i) < th_lower
        p_SST(i)=NaN;                %Set to NaN value if condition satisfy
        j_lower=j_lower+1;
      end
end

j_upper; % possibility to output no. of ouliers
j_lower;

% ***** Plot of Inverse model algorithm on Time series (Part a) ****

figure
x = [1:1:z];
plot(x,smooth(p_SST,10), 'LineWidth', 1.5);

xlim([1 z]);
xticks([1 46 89 142 185 236 282 329 377 425 473 523]);
xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sept','Oct','Nov','Dec'});
grid on;
xlabel('Time Series');
ylabel('Sea Surface Temperature (K)');
title('Seasonal cycle of Sea Surface Temperature at 45N, 45W (North Altantic) SIC=0');


% ***** compute mean and std dev (part b) *****

jan_std = [std(jan(:,1)) std(jan(:,2)) std(jan(:,3))]
jul_std = [std(jul(:,1)) std(jul(:,2)) std(jul(:,3))]
%jan_mean = [mean(jan(:,1)) mean(jan(:,2)) mean(jan(:,3))]
%jul_mean = [mean(jul(:,1)) mean(jul(:,2)) mean(jul(:,3))]





