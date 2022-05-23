clc
clear all
close all

%% Import Data table
data_table = readtable('RockPhysics_vs_NMR_DeltaVWC.txt');
data_time = table2timetable(data_table,'RowTimes','Date');
data_clean = table2array(data_time);

%% Assign Dates to Arrays

%May 26th
May26_y = data_clean(1:4,1);
May26_x = data_clean(1:4,2);

%June 29th
June29_y = data_clean(5:8,1);
June29_x = data_clean(5:8,2);

%July 10th
July10_y = data_clean(9:12,1);
July10_x = data_clean(9:12,2);

%Aug 17th
Aug17_y = data_clean(13:16,1);
Aug17_x = data_clean(13:16,2);

%Aug 23rd
Aug23_y = data_clean(17:20,1);
Aug23_x = data_clean(17:20,2);


%% Scatter Plot Data
figure(1)

sz = 50 ; %marker size

p1 = scatter(May26_x,May26_y,sz,'filled','d','r','MarkerEdgeColor','k');
hold on
p2 = scatter(June29_x,June29_y,sz,'filled','d','b','MarkerEdgeColor','k');

p3 = scatter(July10_x,July10_y,sz,'filled','d','y','MarkerEdgeColor','k');

p4 = scatter(Aug17_x,Aug17_y,sz,'filled','d','c','MarkerEdgeColor','k');

p5 = scatter(Aug23_x,Aug23_y,sz,'filled','d','g','MarkerEdgeColor','k');


%% Linear Regression
model = polyfit(data_clean(:,2),data_clean(:,1),1);

% Display evaluated equation y = m*x + b
disp(['Equation is y = ' num2str(model(1)) '*x + ' num2str(model(2))])

summary = fitlm(data_clean(:,2),data_clean(:,1))
x = [-1:0.001:1];
F = 0.082217*x + -0.0078645 ;
p6 = plot(x,F,'b');  % Plots the best fit line

%% Y=X Line
p7 = refline(1,0); % plots the One to One line
p7.Color = 'r';



% Graph Formatting
yline(0,'k')
xline(0,'k')
title('Measured \DeltaVWC vs RockPhysics Modeled \DeltaVWC','fontsize',16); 
xlabel('Measured \DeltaVWC','fontsize',16);
ylabel('RockPhysics Modeled \DeltaVWC','fontsize',16);
legend([p1 p2 p3 p4 p5 p6 p7],{'May26th','June29th','July10th','Aug17th','Aug23rd','y = 0.082217*x + -0.0078645','y = x'},'Location','Northwest','fontsize',16)
%legend([p2 p3 p4 p5 p6 p7],{'June29th','July10th','Aug17th','Aug23rd','y = 0.082217*x + -0.0078645','y = x'},'Location','Northwest','fontsize',16)
grid on
xlim([-0.1 0.1])
ylim([-0.1 0.1])


hold off

set(gcf,'Position',[0 0 800 800])
set(findall(gcf,'-property','FontSize'),'FontSize',12 ) 
set(findall(gcf,'-property','FontName'),'FontName','Calibri' ) 
set(gca, 'Layer', 'top')

