
close all;
clear;

% ***** READ REFERENCE DATA *****

% number of rows to read:
nor = 6988;

SIC0 = csvread('SIC0_noHeader.csv', 1, 4, [1 4 nor 38]);

% guess for MY ice fraction:
my = 0.5;


% ***** STORE nor ROW VECTORS P IN A MATRIX *****

P_SIC0 = [SIC0(:,3) SIC0(:,12) SIC0(:,13) SIC0(:,10) SIC0(:,5) SIC0(:,21) my*ones(nor,1)];


% ***** COMPUTE BRIGHTNESS TEMPERATURE VECTORS FROM P USING FORWARD MODEL *****

T0 = zeros(nor,10);

for i=1:nor
    T0(i,:)=transpose(ComputeT(P_SIC0(i,:)));
end


% ***** COMPUTE P FROM BRIGHTNESS TEMPERATURE USING INVERSE MODEL *****

P0 = zeros(nor,7);

for i=1:nor
    P0(i,:)=InverseModel(T0(i,:));
end


% ***** DETERMINE THE ERROR OF THE COMPUTED PARAMETERS *****

E0 = zeros(nor,7);

for i=1:nor
   for j=1:7
       E0(i,j)=P0(i,j)-P_SIC0(i,j);
   end
end


% ***** OPTIONAL: REMOVE LINES WITH HIGH SST *****

rem = 0; % initiate no. of removed lines

for i=1:nor
   if SIC0(i,10)>283
       E0(i,:)=NaN;
       rem = rem+1;
   end
end

rem % output no. of removed lines

% ***** PLOT THE ERROR FOR EACH PARAMETER *****

% f4=figure;
% plot(1:length(E0),P_SIC0(:,4), 'LineWidth', 1.5)
% hold on;
% plot(1:length(E0),E0(:,4), 'LineWidth', 1.5)
% hold off;
% 
% ylabel('Temperature [K]');
% xlabel('No. of data point');
% title('Input and error of the sea surface temperature');
% legend('Input SST (p_{original})', 'Error of the estimated SST (e)');


% F0 = E0.*10;
% 
% e1=histc(F0(:,1),(-100:50));
% e2=histc(F0(:,2),(-100:50));
% e3=histc(F0(:,3),(-100:50));
% e4=histc(F0(:,4),(-100:50));
% e5=histc(F0(:,5),(-100:50));
% e6=histc(F0(:,6),(-100:50));
% 
% f1a=figure;
% hold on;
% plot((-100:50),e1, 'LineWidth', 1.5)
% plot((-100:50),e2, 'LineWidth', 1.5)
% plot((-100:50),e3, 'LineWidth', 1.5)
% plot((-100:50),e4, 'LineWidth', 1.5)
% plot((-100:50),e5, 'LineWidth', 1.5)
% plot((-100:50),e6, 'LineWidth', 1.5)
% 
% xlim([-50 25]);
% xlim([-40 10]);
% xticklabels({'-4', '-3', '-2', '-1', '0', '1'});
% legend('wind speed', 'water vapour', 'liquid water', 'sea surface temp.', 'ice temp.', 'ice concentration', 'Location', 'northwest');
% xlabel('Normalized Error');
% ylabel('Occurence Rate');
% title('Error Distribution of computed geophysical parameters, SIC=0');

E0(any(isnan(E0),2),:)=[]; % remove NaN lines for computation of mean and std dev

m = [mean(E0(:,1)) mean(E0(:,2)) mean(E0(:,3)) mean(E0(:,4)) mean(E0(:,5)) mean(E0(:,6)) mean(E0(:,7))]
s = [std(E0(:,1)) std(E0(:,2)) std(E0(:,3)) std(E0(:,4)) std(E0(:,5)) std(E0(:,6)) std(E0(:,7))]


