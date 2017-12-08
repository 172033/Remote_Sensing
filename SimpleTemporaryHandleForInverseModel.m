% *****measured brightness temperatures************************************
% (6.93v, 6.93h, 10.65v, 10.65h, 18.70v, 18.70h, 23.80v, 23.80h, 36.50v, 36.50h)

%% Working with open water data set
% 
% % Reading data
% nor_SIC0 = 6988;
% SIC0 = csvread('SIC0_noHeader.csv', 1, 25, [1 25 nor_SIC0 37]);
% 
% % SIC0 brightness temperatures
% TB = [SIC0(:,2) SIC0(:,1) SIC0(:,6) SIC0(:,5) SIC0(:,8) SIC0(:,7) SIC0(:,10) SIC0(:,9) SIC0(:,12) SIC0(:,11)];
% 
% % ***** CORRECT REFERENCE DATA BRIGHTNESS TEMPERATURE VECTORS *****
% 
% % 6.93v
% j = 1;
% c0 = -0.2825;
% c1 = 2.492*10^-2;
% c2 = -0.6722*10^-4;
% 
% for i=1:nor_SIC0
%     h = TB(i,j);
%     TB(i,j)= - c2*h^2 - (c1-1)*h - c0;
% end
% 
% % 6.93h
% j = 2;
% c0 = -1.722;
% c1 = 7.361*10^-2;
% c2 = -2.194*10^-4;
% 
% for i=1:nor_SIC0
%     h = TB(i,j);
%     TB(i,j)= - c2*h^2 - (c1-1)*h - c0;
% end
% 
% % 10.65v
% j = 3;
% c0 = -2.599;
% c1 = 7.253*10^-2;
% c2 = -2.034*10^-4;
% 
% for i=1:nor_SIC0
%     h = TB(i,j);
%     TB(i,j)= - c2*h^2 - (c1-1)*h - c0;
% end
% 
% % 10.65h
% j = 4;
% c0 = -0.4337;
% c1 = 5.056*10^-2;
% c2 = -1.544*10^-4;
% 
% for i=1:nor_SIC0
%     h = TB(i,j);
%     TB(i,j)= - c2*h^2 - (c1-1)*h - c0;
% end
% 
% % 18.70v
% j = 5;
% c0 = -12.4;
% c1 = 17.17*10^-2;
% c2 = -4.294*10^-4;
% 
% for i=1:nor_SIC0
%     h = TB(i,j);
%     TB(i,j)= - c2*h^2 - (c1-1)*h - c0;
% end
% 
% % 18.70h
% j = 6;
% c0 = 4.790;
% c1 = -3.272*10^-2;
% c2 = 0.7558*10^-4;
% 
% for i=1:nor_SIC0
%     h = TB(i,j);
%     TB(i,j)= - c2*h^2 - (c1-1)*h - c0;
% end
% 
% % 23.80v
% j = 7;
% c0 = -11.06;
% c1 = 14.22*10^-2;
% c2 = -3.354*10^-4;
% 
% for i=1:nor_SIC0
%     h = TB(i,j);
%     TB(i,j)= - c2*h^2 - (c1-1)*h - c0;
% end
% 
% % 23.80h
% j = 8;
% c0 = 0.3257;
% c1 = 5.029*10^-2;
% c2 = -1.554*10^-4;
% 
% for i=1:nor_SIC0
%     h = TB(i,j);
%     TB(i,j)= - c2*h^2 - (c1-1)*h - c0;
% end
% 
% % 36.50v
% j = 9;
% c0 = -2.915;
% c1 = 4.981*10^-2;
% c2 = -1.264*10^-4;
% 
% for i=1:nor_SIC0
%     h = TB(i,j);
%     TB(i,j)= - c2*h^2 - (c1-1)*h - c0;
% end
% 
% % 36.50h
% j = 10;
% c0 = -1.976;
% c1 = 5.914*10^-2;
% c2 = -1.674*10^-4;
% 
% for i=1:nor_SIC0
%     h = TB(i,j);
%     TB(i,j)= - c2*h^2 - (c1-1)*h - c0;
% end
% 
% 
% % Computing p and S from SIC0 using inverse model
% p_SIC0 = zeros(nor_SIC0,7);
% S_SIC0 = zeros(7,7,nor_SIC0);
% for i = 1: nor_SIC0
% [p,S] = InverseModel(TB(i,:));
% p_SIC0(i,:) = p;
% S_SIC0(:,:,i) = S;
% end



%% Working with high ice concentration data set

% Reading data
nor_SIC1 = 15965;
SIC1 = csvread('SIC1_noHeader.csv', 1, 25, [1 25 nor_SIC1 37]);
 
% SIC1 brightness temperatures
TB = [SIC1(:,2) SIC1(:,1) SIC1(:,6) SIC1(:,5) SIC1(:,8) SIC1(:,7) SIC1(:,10) SIC1(:,9) SIC1(:,12) SIC1(:,11)];

% ***** CORRECT REFERENCE DATA BRIGHTNESS TEMPERATURE VECTORS *****

% 6.93v
j = 1;
c0 = -0.2825;
c1 = 2.492*10^-2;
c2 = -0.6722*10^-4;

for i=1:nor_SIC1
    h = TB(i,j);
    TB(i,j)= - c2*h^2 - (c1-1)*h - c0;
end

% 6.93h
j = 2;
c0 = -1.722;
c1 = 7.361*10^-2;
c2 = -2.194*10^-4;

for i=1:nor_SIC1
    h = TB(i,j);
    TB(i,j)= - c2*h^2 - (c1-1)*h - c0;
end

% 10.65v
j = 3;
c0 = -2.599;
c1 = 7.253*10^-2;
c2 = -2.034*10^-4;

for i=1:nor_SIC0
    h = TB(i,j);
    TB(i,j)= - c2*h^2 - (c1-1)*h - c0;
end

% 10.65h
j = 4;
c0 = -0.4337;
c1 = 5.056*10^-2;
c2 = -1.544*10^-4;

for i=1:nor_SIC1
    h = TB(i,j);
    TB(i,j)= - c2*h^2 - (c1-1)*h - c0;
end

% 18.70v
j = 5;
c0 = -12.4;
c1 = 17.17*10^-2;
c2 = -4.294*10^-4;

for i=1:nor_SIC1
    h = TB(i,j);
    TB(i,j)= - c2*h^2 - (c1-1)*h - c0;
end

% 18.70h
j = 6;
c0 = 4.790;
c1 = -3.272*10^-2;
c2 = 0.7558*10^-4;

for i=1:nor_SIC1
    h = TB(i,j);
    TB(i,j)= - c2*h^2 - (c1-1)*h - c0;
end

% 23.80v
j = 7;
c0 = -11.06;
c1 = 14.22*10^-2;
c2 = -3.354*10^-4;

for i=1:nor_SIC1
    h = TB(i,j);
    TB(i,j)= - c2*h^2 - (c1-1)*h - c0;
end

% 23.80h
j = 8;
c0 = 0.3257;
c1 = 5.029*10^-2;
c2 = -1.554*10^-4;

for i=1:nor_SIC1
    h = TB(i,j);
    TB(i,j)= - c2*h^2 - (c1-1)*h - c0;
end

% 36.50v
j = 9;
c0 = -2.915;
c1 = 4.981*10^-2;
c2 = -1.264*10^-4;

for i=1:nor_SIC1
    h = TB(i,j);
    TB(i,j)= - c2*h^2 - (c1-1)*h - c0;
end

% 36.50h
j = 10;
c0 = -1.976;
c1 = 5.914*10^-2;
c2 = -1.674*10^-4;

for i=1:nor_SIC1
    h = TB(i,j);
    TB(i,j)= - c2*h^2 - (c1-1)*h - c0;
end

% Computing p and S from SIC0 using inverse model
p_SIC1 = zeros(nor_SIC1,7);
S_SIC1 = zeros(7,7,nor_SIC1);
for i = 1: nor_SIC1
[p,S] = InverseModel(TB(i,:));
p_SIC1(i,:) = p;
S_SIC1(:,:,i) = S;
end


