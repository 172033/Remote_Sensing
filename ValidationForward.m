
close all;
clear;

% ***** READ REFERENCE DATA *****

% number of rows to read:
nor = 1000;

SIC0 = csvread('SIC0_noHeader.csv', 1, 4, [1 4 nor 38]);
SIC1 = csvread('SIC1_noHeader.csv', 1, 4, [1 4 nor 38]);

% guess for MY ice fraction:
my = 0.5;


% ***** STORE nor ROW VECTORS P IN A MATRIX *****

P_SIC0 = [SIC0(:,3) SIC0(:,12) SIC0(:,13) SIC0(:,10) SIC0(:,5) SIC0(:,21) my*ones(nor,1)];
P_SIC1 = [SIC1(:,3) SIC1(:,12) SIC1(:,13) SIC1(:,10) SIC1(:,5) SIC1(:,21) my*ones(nor,1)];


% ***** STORE REFERENCE DATA BRIGHTNESS TEMPERATURE VECTORS IN A MATRIX *****

% (they are stored vertical polarization first, because that's how the forward model outputs it)
T_SIC0 = [SIC0(:,23) SIC0(:,22) SIC0(:,27) SIC0(:,26) SIC0(:,29) SIC0(:,28) SIC0(:,31) SIC0(:,30) SIC0(:,33) SIC0(:,32)];
T_SIC1 = [SIC1(:,23) SIC1(:,22) SIC1(:,27) SIC1(:,26) SIC1(:,29) SIC1(:,28) SIC1(:,31) SIC1(:,30) SIC1(:,33) SIC1(:,32)];


% ***** COMPUTE BRIGHTNESS TEMPERATURE VECTORS FROM P USING FORWARD MODEL *****

%T0 = zeros(nor,10);
T1 = zeros(nor,10);

% for i=1:nor
%     T0(i,:)=transpose(ComputeT(P_SIC0(i,:)));
% end

for i=1:nor
    T1(i,:)=transpose(ComputeT(P_SIC1(i,:)));
end


% ***** DETERMINE THE SIGNED RELATIVE ERROR OF THE COMPUTED BRIGHTNESS TEMPERATURES *****

%E0 = zeros(nor,10);
E1 = zeros(nor,10);

% for i=1:nor
%    for j=1:10 
%        E0(i,j)=(T0(i,j)-T_SIC0(i,j));
%    end
% end

for i=1:nor
   for j=1:10 
       E1(i,j)=(T1(i,j)-T_SIC1(i,j));
   end
end


% ***** PLOT THE ERROR FOR EACH CHANNEL *****

x = linspace(1,10,10);


% f1=figure;
% hold on;
% for i=1:nor
%     scatter(x, E0(i,:), 'filled')
% end
% hold off;
% 
% set(gcf,'units','centimeters','position',[5,5,22,12]);
% 
% ylabel('Absolute error in K');
% xlim([0.5 10.5]);
% xticklabels({'6.93 v','6.93 h','10.65 v','10.65 h','18.70 v','18.70 h','23.80 v','23.80 h','36.50 v','36.50 h'});
% xlabel('Channels of the Radiometer');
% title('Difference of computed and referenced brightness temperatures, SIC=0');

% e4=histc(E0(:,4),(-50:50));
% e5=histc(E0(:,5),(-50:50));
% e6=histc(E0(:,6),(-50:50));
% e8=histc(E0(:,8),(-50:50));
% e10=histc(E0(:,10),(-50:50));
% 
% 
% f1a=figure;
% hold on;
% plot((-50:50),e4, 'LineWidth', 1.5);
% plot((-50:50),e5, 'LineWidth', 1.5);
% plot((-50:50),e6, 'LineWidth', 1.5);
% plot((-50:50),e8, 'LineWidth', 1.5);
% plot((-50:50),e10, 'LineWidth', 1.5);
% hold off;
% 
% set(gcf,'units','centimeters','position',[5,5,22,12]);
% 
% xlabel('Absolute error in K');
% ylabel('Occurence rate');
% title('Distribution of absolute errors in individual radiometer channels, SIC=0');
% legend('10.65 h', '18.70 v', '18.70 h', '23.80 h', '36.50 h');

f2=figure
hold on;
for i=1:nor
    scatter(x, E1(i,:), 'filled')
end
hold off;

set(gcf,'units','centimeters','position',[5,5,22,12]);

ylabel('Absolute error in K');
xlim([0.5 10.5]);
xticklabels({'6.93 v','6.93 h','10.65 v','10.65 h','18.70 v','18.70 h','23.80 v','23.80 h','36.50 v','36.50 h'});
xlabel('Channels of the Radiometer');
title('Difference of computed and referenced brightness temperatures, SIC=1');









