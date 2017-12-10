
close all;
clear;

% ***** READ REFERENCE DATA *****

% number of rows to read:
nor = 6988/2;

% read all rows:
SIC0_full = csvread('SIC0_noHeader.csv', 1, 4, [1 4 2*nor 38]);

% for the validation, only every second row will be used:
SIC0 = zeros(nor,35);

for i=1:nor
    SIC0(i,:) = SIC0_full(2*i,:);
end

% guess for MY ice fraction:
my = 0.5;


% ***** STORE nor ROW VECTORS P IN A MATRIX *****

P_SIC0 = [SIC0(:,3) SIC0(:,12) SIC0(:,13) SIC0(:,10) SIC0(:,5) SIC0(:,21) my*ones(nor,1)];


% ***** STORE REFERENCE DATA BRIGHTNESS TEMPERATURE VECTORS IN A MATRIX *****

% (they are stored vertical polarization first, because that's how the forward model outputs it)
T_SIC0 = [SIC0(:,23) SIC0(:,22) SIC0(:,27) SIC0(:,26) SIC0(:,29) SIC0(:,28) SIC0(:,31) SIC0(:,30) SIC0(:,33) SIC0(:,32)];


% ***** CORRECT REFERENCE DATA BRIGHTNESS TEMPERATURE VECTORS *****

      % 6.93v       6.93h       10.65v      10.65h        18.70v      18.70h      23.80v        23.80h      36.50v      36.50h
COR = [ -0.2825,    -1.722,     -2.599,     -0.4337,      -12.4,      4.790,      -11.06,       0.3257,     -2.915,     -1.976;
        2.492e-2,   7.361e-2,   7.253e-2,   5.056e-2,     17.17e-2,   -3.272e-2,  14.22e-2,     5.029e-2,   4.981e-2,   5.914e-2;
        -0.6722e-4, -2.194e-4,  -2.034e-4,  -1.544e-4,    -4.294e-4,  0.7558e-4,  -3.354e-4,    -1.554e-4,  -1.264e-4,  -1.674e-4
      ];

  
for j=1:10
    for i=1:nor
        T_SIC0(i,j)= - COR(3,j)*T_SIC0(i,j)^2 - (COR(2,j)-1)*T_SIC0(i,j) - COR(1,j);
    end
end


% ***** COMPUTE BRIGHTNESS TEMPERATURE VECTORS FROM P USING FORWARD MODEL *****

T0 = zeros(nor,10);

for i=1:nor
    T0(i,:)=transpose(ComputeT(P_SIC0(i,:)));
end


% ***** DETERMINE THE SIGNED RELATIVE ERROR OF THE COMPUTED BRIGHTNESS TEMPERATURES *****

E0 = zeros(nor,10);

for i=1:nor
   for j=1:10 
       E0(i,j)=(T0(i,j)-T_SIC0(i,j));
   end
end


% ***** PLOT THE ERROR FOR EACH CHANNEL *****


e1=histc(E0(:,1),(-40:40))/nor;
e2=histc(E0(:,2),(-40:40))/nor;
e4=histc(E0(:,4),(-40:40))/nor;
e5=histc(E0(:,5),(-40:40))/nor;
e6=histc(E0(:,6),(-40:40))/nor;
e8=histc(E0(:,8),(-40:40))/nor;
e10=histc(E0(:,10),(-40:40))/nor;


f1a=figure;
hold on;
plot((-40:40),e1, 'LineWidth', 1.5);
plot((-40:40),e2, 'LineWidth', 1.5);
plot((-40:40),e4, 'LineWidth', 1.5);
plot((-40:40),e5, 'LineWidth', 1.5);
plot((-40:40),e6, 'LineWidth', 1.5);
plot((-40:40),e8, 'LineWidth', 1.5);
plot((-40:40),e10, 'LineWidth', 1.5);
hold off;

set(gcf,'units','centimeters','position',[5,5,22,12]);

xlabel('Absolute error in K');
ylabel('Normalized occurence rate');
title('Distribution of absolute errors in individual radiometer channels, SIC=0');
legend('6.93 v', '6.93 h', '10.65 h', '18.70 v', '18.70 h', '23.80 h', '36.50 h');



