%------------------Standard atmospheric values and std---------------------
% Computing standard atmospheric values from annual NWP model predictions
% of parameters: wind speed, water vapour, cloud liquid water, sea surface 
% temperature, ice temperature (upper layer).   

% number of rows to read:
nor_SIC0 = 6988;
nor_SIC1 = 15965;

% reading data from reference files
SIC0 = csvread('SIC0_noHeader.csv', 1, 4, [1 4 nor_SIC0 38]); % open water data set
SIC1 = csvread('SIC1_noHeader.csv', 1, 4, [1 4 nor_SIC1 38]); % high ice concentration data set
SIC0_p = [SIC0(:,3) SIC0(:,12) SIC0(:,13) SIC0(:,10) SIC0(:,5)]; % selecting parameters: ws,vw,clw,sst,ist11, open water  
SIC1_p = [SIC1(:,3) SIC1(:,12) SIC1(:,13) SIC1(:,10) SIC1(:,5)]; % selecting parameters: ws,vw,clw,sst,ist11, high ice concentration

% Calculating mean and std for each data set
STANDARD_ATM_SIC0 = [mean(SIC0_p(:,1)) mean(SIC0_p(:,2)) mean(SIC0_p(:,3)) mean(SIC0_p(:,4)) mean(SIC0_p(:,5))]; 
STANDARD_ATM_SIC1 = [mean(SIC1_p(:,1)) mean(SIC1_p(:,2)) mean(SIC1_p(:,3)) mean(SIC1_p(:,4)) mean(SIC1_p(:,5))];

% Calculating weighted mean and standard deviation
w_0 = 0.3044;
w_1 = 0.6956;

p_mean = zeros(1,5);
sigma_square = zeros(1,5);
std = zeros(1,5);
for i = 1:5
p_mean(i) = (sum(SIC0_p(:,i)*w_0) + sum(SIC1_p(:,i)*w_1)) / (nor_SIC0*w_0 + nor_SIC1*w_1); 
sigma_square(i) = var(SIC0_p(:,i))*w_0 + var(SIC1_p(:,i))*w_1;
std(i) = sqrt(sigma_square(i));
end
