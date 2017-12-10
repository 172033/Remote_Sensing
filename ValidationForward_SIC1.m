
close all;
clear;

% ***** READ REFERENCE DATA *****

% number of rows to read - do not change!
%nor = 7982;

% read all rows and all relevant columns:
SIC1_full = csvread('SIC1_noHeader.csv', 1, 4, [1 4 15964 38]);

% use only winter months (Oct-May) for SIC1
SIC1_winter = [SIC1_full(1717:6244,:); SIC1_full(8097:11892,:); SIC1_full(12511:14984,:); SIC1_full(15827:15964,:)];
l=length(SIC1_winter)/2;

% for the validation of the forward model, only every second row will be used:
SIC1 = zeros(l,35);

for i=1:l
    SIC1(i,:) = SIC1_winter(2*i,:);
end

% guess for MY ice fraction:
my = 0;


% ***** STORE nor ROW VECTORS P IN A MATRIX *****

P_SIC1 = [SIC1(:,3) SIC1(:,12) SIC1(:,13) SIC1(:,10) SIC1(:,5) SIC1(:,21) my*ones(l,1)];


% ***** STORE REFERENCE DATA BRIGHTNESS TEMPERATURE VECTORS IN A MATRIX *****

% (they are stored vertical polarization first, because that's how the forward model outputs it)
T_SIC1 = [SIC1(:,23) SIC1(:,22) SIC1(:,27) SIC1(:,26) SIC1(:,29) SIC1(:,28) SIC1(:,31) SIC1(:,30) SIC1(:,33) SIC1(:,32)];


% ***** CORRECT REFERENCE DATA BRIGHTNESS TEMPERATURE VECTORS *****

      % 6.93v       6.93h       10.65v      10.65h        18.70v      18.70h      23.80v        23.80h      36.50v      36.50h
COR = [ -0.2825,    -1.722,     -2.599,     -0.4337,      -12.4,      4.790,      -11.06,       0.3257,     -2.915,     -1.976;
        2.492e-2,   7.361e-2,   7.253e-2,   5.056e-2,     17.17e-2,   -3.272e-2,  14.22e-2,     5.029e-2,   4.981e-2,   5.914e-2;
        -0.6722e-4, -2.194e-4,  -2.034e-4,  -1.544e-4,    -4.294e-4,  0.7558e-4,  -3.354e-4,    -1.554e-4,  -1.264e-4,  -1.674e-4
      ];

  
for j=1:10
    for i=1:l
        T_SIC1(i,j)= - COR(3,j)*T_SIC1(i,j)^2 - (COR(2,j)-1)*T_SIC1(i,j) - COR(1,j);
    end
end


% ***** COMPUTE BRIGHTNESS TEMPERATURE VECTORS FROM P USING FORWARD MODEL *****

T1 = zeros(l,10);

for i=1:l
    T1(i,:)=transpose(ComputeT(P_SIC1(i,:)));
end


% ***** DETERMINE THE SIGNED RELATIVE ERROR OF THE COMPUTED BRIGHTNESS TEMPERATURES *****

E1 = zeros(l,10);

for i=1:l
   for j=1:10 
       E1(i,j)=(T1(i,j)-T_SIC1(i,j));
   end
end


% ***** PLOT THE ERROR FOR EACH CHANNEL *****


e1=histc(E1(:,1),(-50:50))/(l/2);
e2=histc(E1(:,2),(-50:50))/(l/2);
e3=histc(E1(:,3),(-50:50))/(l/2);
e4=histc(E1(:,4),(-50:50))/(l/2);
e5=histc(E1(:,5),(-50:50))/(l/2);
e6=histc(E1(:,6),(-50:50))/(l/2);
e7=histc(E1(:,7),(-50:50))/(l/2);
e8=histc(E1(:,8),(-50:50))/(l/2);
e9=histc(E1(:,9),(-50:50))/(l/2);
e10=histc(E1(:,10),(-50:50))/(l/2);


f1a=figure;
hold on;
plot((-50:50),e1, 'LineWidth', 1.5);
plot((-50:50),e2, 'LineWidth', 1.5, 'Color', [30 160 170]./255);
plot((-50:50),e3, 'LineWidth', 1.5);
plot((-50:50),e4, 'LineWidth', 1.5);
plot((-50:50),e5, 'LineWidth', 1.5);
plot((-50:50),e6, 'LineWidth', 1.5);
plot((-50:50),e7, 'LineWidth', 1.5);
plot((-50:50),e8, 'LineWidth', 1.5, 'Color', [70 130 70]./255);
plot((-50:50),e9, 'LineWidth', 1.5, 'Color', [17 30 108]./255);
plot((-50:50),e10, 'LineWidth', 1.5, 'Color', [253 106 2]./255);
hold off;

set(gcf,'units','centimeters','position',[5,5,22,12]);

xlabel('Absolute error in K');
ylabel('Normalized occurence rate');
title('Distribution of absolute errors in individual radiometer channels, SIC=1');
legend('6.93 v', '6.93 h', '10.65 v', '10.65 h', '18.70 v', '18.70 h', '23.80 v', '23.80 h', '36.50 v', '36.50 h');







