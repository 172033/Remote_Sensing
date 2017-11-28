% *****measured brightness temperatures************************************
% (6.93v, 6.93h, 10.65v, 10.65h, 18.70v, 18.70h, 23.80v, 23.80h, 36.50v, 36.50h)

nor_SIC0 = 6988;
nor_SIC1 = 15965;

SIC0 = csvread('SIC0_noHeader.csv', 1, 25, [1 25 nor_SIC0 37]);
SIC1 = csvread('SIC1_noHeader.csv', 1, 25, [1 25 nor_SIC1 37]);

% SIC0
TB = [SIC0(:,1) SIC0(:,2) SIC0(:,5) SIC0(:,6) SIC0(:,7) SIC0(:,8) SIC0(:,9) SIC0(:,10) SIC0(:,11) SIC0(:,12)];

%SIC1
%TB = [SIC1(:,1) SIC1(:,2) SIC1(:,5) SIC1(:,6) SIC1(:,7) SIC1(:,8) SIC1(:,9) SIC1(:,10) SIC1(:,11) SIC1(:,12)];

% Calculating p from SIC0 using inverse model
p_SIC0 = zeros(nor_SIC0,7);
S_SIC0 = zeros(7,7,nor_SIC0);
for i = 1: nor_SIC0
[p,S] = InverseModel(TB(i,:));
p_SIC0(i,:) = p;
S_SIC0(:,:,i) = S;
end

