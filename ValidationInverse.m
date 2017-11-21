
close all;
clear all;

% ***** READ REFERENCE DATA *****

% number of rows to read:
nor = 100;

SIC0 = csvread('SIC0_noHeader.csv', 1, 4, [1 4 nor 38]);
SIC1 = csvread('SIC1_noHeader.csv', 1, 4, [1 4 nor 38]);

% guess for MY ice fraction:
my = 0.5;


% ***** STORE nor ROW VECTORS P IN A MATRIX *****

P_SIC0 = [SIC0(:,3) SIC0(:,12) SIC0(:,13) SIC0(:,10) SIC0(:,5) SIC0(:,21) my*ones(nor,1)];
P_SIC1 = [SIC1(:,3) SIC1(:,12) SIC1(:,13) SIC1(:,10) SIC1(:,5) SIC1(:,21) my*ones(nor,1)];


% ***** COMPUTE BRIGHTNESS TEMPERATURE VECTORS FROM P USING FORWARD MODEL *****

T0 = zeros(nor,10);
T1 = zeros(nor,10);

for i=1:nor
    T0(i,:)=transpose(ComputeT(P_SIC0(i,:)));
end

for i=1:nor
    T1(i,:)=transpose(ComputeT(P_SIC1(i,:)));
end


% ***** COMPUTE P FROM BRIGHTNESS TEMPERATURE USING INVERSE MODEL *****

P0 = zeros(nor,7);
P1 = zeros(nor,7);

for i=1:nor
    P0(i,:)=InverseModel(T0(i,:));
end

for i=1:nor
    P1(i,:)=InverseModel(T1(i,:));
end


% ***** DETERMINE THE SIGNED RELATIVE ERROR OF THE COMPUTED PARAMETERS *****

E0 = zeros(nor,7);
E1 = zeros(nor,7);

for i=1:nor
   for j=1:7
       E0(i,j)=(P0(i,j)-P_SIC0(i,j))/P_SIC0(i,j);
   end
end

for i=1:nor
   for j=1:7 
       E1(i,j)=(P1(i,j)-P_SIC1(i,j))/P_SIC1(i,j);
   end
end


% ***** PLOT THE ERROR FOR EACH PARAMETER *****

x = linspace(1,7,7);



f1=figure;
hold on;
for i=1:nor
    scatter(x, E0(i,:), 'filled')
end
hold off;

set(gcf,'units','centimeters','position',[5,5,20,12]);

ylim([-3 3]);
yticks([-3 -2 -1 0 1 2 3]);
ylabel('Relative error');
xlim([0.5 7.5]);
xticklabels({'ws','tcwv','tclw','sst','skt','ci','my'});
xlabel('Compared Parameters');
title('Difference of computed and referenced parameters, SIC=0');



f2=figure
hold on;
for i=1:nor
    scatter(x, E1(i,:), 'filled')
end
hold off;

set(gcf,'units','centimeters','position',[5,5,20,12]);

ylim([-3 3]);
yticks([-3 -2 -1 0 1 2 3]);
ylabel('Relative error');
xlim([0.5 7.5]);
xticklabels({'ws','tcwv','tclw','sst','skt','ci','my'});
xlabel('Compared Parameters');
title('Difference of computed and referenced parameters, SIC=1');

















