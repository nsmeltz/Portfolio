clear all
clc
close all

%% Import Data File

raw_data = readmatrix('rawdata_stg.txt');

% Preprocessing / cleaning
% Name the columns & get data from .stg file -----> J R Ra A B M N

J = raw_data(:,1);         % electrode number
R = raw_data(:,5);         % Resistance
Error = raw_data(:,6);     % Error
RhoA = raw_data(:,8);      % Apparent resistivity 

    
a = raw_data(:,10);        % Electrode number of current injection electrode A
b = raw_data(:,13);        % Electrode number of current injection electrode B
m = raw_data(:,16);        % Electrode number of current measurement electrode M
n = raw_data(:,19);        % Electrode number of current measurement electrode B

%% 1. Plot the pseudosection using raw data (Ra)

data = [J, R, a , b, m, n, RhoA] ;

%Distance = a+((n-a)/2)
X = data(:,3) + ( ( data(:,6) - data(:,3) ) / 2 );

%Pseudodepth = (m-a)/2
Y = abs(( data(:,5) - data(:,3) )/2) ; 

Ra = data(:,7) ;              % raw apparent resistivity values

%plotting
figure(1)
sz = 100;
hold on
scatter(X,Y, sz, log10(Ra),'filled','Marker','s');
scatter(X,Y,10,'k','filled')
text(-5, 40, sprintf('Data points are represented by black dots \n and squares color coded by resistance value'));

%colorbar
colormap jet
c = colorbar;
c.Limits = [0 3];
ylabel(c, 'Log10 Apparent Resistivity [ohm-m]');

%limits & ticks
% set pseudosection plot limits
ylim([0 50]);            
xlim([-10 120]);
xticks([0:10:110]);
yticks([0:10:60]');
box on

%labels
xlabel('Distance Along Line [m]');
ylabel('Pseudodepth');
title('Pseudosection No Filtering');

%figure properties
set(gca, 'YDir','reverse');
set(gcf,'Position',[0 0 1800 500])
set(findall(gcf,'-property','FontSize'),'FontSize',12 ) 
set(findall(gcf,'-property','FontName'),'FontName','Calibri' ) 
set(gca, 'Layer', 'top')

% save figure
saveas(gcf,'pseudosection.png')

%% 2. Export unfiltered data into csv file for input to the geophysical inversion scripts

% Convert stg data from electrode position (m) to electrode number = ((electrode position)/(electrode spacing)) + 1
% Need this format for the geophysical inversion
A = (a/2)+1;
B = (b/2)+1;
M = (m/2)+1;
N = (n/2)+1;

T = table (J, R, A, B, M, N);

writetable(T,'resistivity_data_nofilter.csv')

%% 3. Filtering for RhoA values based on histogram 

data_filtered = data;        % create data_filtered variable

% loop through the data_filtered matrix assign NaN to rows with RhoA out of range(0<= RhoA <100)
for r = 1:length(data)
    if data_filtered(r,7)<0
       data_filtered(r,7) = NaN;
    elseif data_filtered(r,7)>=100
        data_filtered(r,7) = NaN;
    end
end

% delete rows with NaN to keep all data in range 0<= RhoA <=100
% J, R, a , b, m, n, RhoA
data_filtered(any(isnan(data_filtered),2),:) = [];

%% Plot Histogram of Raw Data (RhoA)
%**Note --> each bin includes the left edge, but does not include the right edge
figure(2)
edges = [ -inf 0:100:1000 inf] ;
counts= histcounts(RhoA,edges);
histogram(RhoA,edges)
text([-100,50,150,250,350,450,550,650,750,850,950,1100],counts,num2str(counts'),'vert','bottom','horiz','center'); 
text(700,1500,sprintf('Total Number of Data Points = %.0f \n Recommend Filtering 0<=RhoA<=100 ',length(RhoA)))
box off

title ' Histogram of RhoA Values Before Filtering'
ylabel 'Count'
xlabel 'RhoA Values'
set(gca, 'XTick', 0:100:1000)


set(gcf,'Position',[0 0 1000 800])
set(findall(gcf,'-property','FontSize'),'FontSize',12 ) 
set(findall(gcf,'-property','FontName'),'FontName','Calibri' ) 

% save figure
saveas(gcf,'histogram.png')

%% 4.  Plot RhoA_filtered Pseudosection

% Calculate pseudosection distance & depth
%X = a+((n-a)/2)
X_fil = data_filtered(:,3) + ( ( data_filtered(:,6) - data_filtered(:,3) ) / 2 ); % x distance for all points

%Y = (m-a)/2
Y_fil = abs(( data_filtered(:,5) - data_filtered(:,3) )/2) ; % pseudodepth of all data points

Ra_fil = data_filtered(:,7)              % filtered apparent resistivity values

percent = (length(Ra_fil)/length(Ra))*100

%plotting
figure(3)
sz = 100;
hold on
scatter(X_fil,Y_fil, sz, log10(Ra_fil),'filled','Marker','s');
scatter(X,Y,10,'k','filled')
text(-5, 40, sprintf('Data points are represented by black dots \n The data points that were kept after filtereing are represented \n by squares color coded by resistance value \n Percentage of original data kept = %.2f%%', percent));

%colorbar
colormap jet
c = colorbar;
c.Limits = [0 3];
ylabel(c, 'Log10 Apparent Resistivity [ohm-m]');

%limits & ticks
% set pseudosection plot limits
ylim([0 50]);            
xlim([-10 120]);
xticks([0:10:110]);
yticks([0:10:60]');
box on

%labels
xlabel('Distance Along Line [m]');
ylabel('Pseudodepth');
title('Pseudosection Filtering 0<= RhoA <100');

%figure properties
set(gca, 'YDir','reverse');
set(gcf,'Position',[0 0 1800 500])
set(findall(gcf,'-property','FontSize'),'FontSize',12 ) 
set(findall(gcf,'-property','FontName'),'FontName','Calibri' ) 
set(gca, 'Layer', 'top')

% save figure
saveas(gcf,'pseudosection_filtered.png')

%% 6.  Export filtered data into text file for input to the geophysical inversion scripts
% Convert stg data from electrode position (m) to electrode number = ((electrode position)/(electrode spacing)) + 1
% Need this format for the geophysical inversion
A_fil = (data_filtered(:,3)/2)+1;
B_fil = (data_filtered(:,4)/2)+1;
M_fil = (data_filtered(:,5)/2)+1;
N_fil = (data_filtered(:,6)/2)+1;

T_fil = table (data_filtered(:,1), data_filtered(:,2), A_fil, B_fil, M_fil, N_fil,'VariableName',{'J','R','A','B','M','N'});

writetable(T_fil,'resistivity_data_filtered.csv','WriteVariableNames', true)