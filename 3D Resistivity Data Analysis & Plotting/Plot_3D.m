clear all
close all
clc

%% Set Grid & name of plot


setZlim = [2180 2200];              %set the Y limit of the plot, must start with min
setYlim = [-10 120];                %set the X limit of the plot, must start with min
setXlim = [0 120];


%% Determine the x y z and r values for each line

% Data for line 1
data1 = load('data1.txt'); % col1 = x, col2 = y, col3 = z value that I set col4 = log10 Resistivity, ohm-m
position_R1 = 0  ;    % Position of line from line 1 on Google Earth in meters
    X1 = position_R1*ones(length(data1),1); 
    Y1 = data1(:,1)'; % Distance along the line
    Z1 = data1(:,2); % Depth
    R1 = data1(:,3); % Resitivity value
    
% % Data for line 2
 data2 = load('data2.txt'); % col1 = x, col2 = y, col3 = z value that I set col4 = log10 Resistivity, ohm-m
 position_R2 = 30  ;  % Position of line from line 1 on Google Earth in meters
    X2 = position_R2*ones(length(data2),1); 
    Y2 = data2(:,1); % Distance along the line
    Z2 = data2(:,2); % Depth
    R2 = data2(:,3); % Resitivity value

 % Data for line 3
 data3 = load('data3.txt'); % col1 = x, col2 = y, col3 = z value that I set col4 = log10 Resistivity, ohm-m
 position_R3 = 60  ;  % Position of line from line 1 on Google Earth in meters
    X3 = position_R3*ones(length(data3),1); 
    Y3 = data3(:,1); % Distance along the line
    Z3 = data3(:,2); % Depth
    R3 = data3(:,3); % Resitivity value
    
% Data for line 4
data4 = load('data4.txt'); % col1 = x, col2 = y, col3 = z value that I set col4 = log10 Resistivity, ohm-m
position_R4 = 90 ;    % Position of line from line 1 on Google Earth in meters
    X4 = position_R4*ones(length(data4),1); 
    Y4 = data4(:,1); % Distance along the line
    Z4 = data4(:,2); % Depth
    R4 = data4(:,3); % Resitivity value
    
% Data for line 5
data5 = load('data5.txt'); % col1 = x, col2 = y, col3 = z value that I set col4 = log10 Resistivity, ohm-m
position_R6 = 120 ;   % Position of line from line 1 on Google Earth in meters
    X5 = position_R6*ones(length(data5),1); 
    Y5 = data5(:,1); % Distance along the line
    Z5 = data5(:,2); % Depth
    R5 = data5(:,3); % Resitivity value

% GoogleEarth Images
img = imread('GE.png');     % Load GoogleEarth image no lines

%% Plot 

set(findall(gcf,'-property','FontSize'),'FontSize',14 ); 
set(findall(gcf,'-property','FontName'),'FontName','Ariel' ) ;

sz = 300; %size of circles in scatter plot

% Scatter plots of each ERT line 

% sqaures
figure(1)
scatter3(X1,Y1,Z1,sz,R1,'square','filled');
hold on
scatter3(X2,Y2,Z2,sz,R2,'square','filled');
scatter3(X3,Y3,Z3,sz,R3,'square','filled');
scatter3(X4,Y4,Z4,sz,R4,'square','filled');
scatter3(X5,Y5,Z5,sz,R5,'square','filled');
scatter3( 64 , 57 , 2181, sz, ' v ' , 'k','filled')
text( 63 , 60 , 2182 ,'RS','FontSize', 14)

line(zeros(1,2),0:110:110, 2180*ones(1,2),'LineWidth',5,'Color','red')
line(30*ones(1,2),0:110:110, 2180*ones(1,2),'LineWidth',5,'Color','red')
line(25*ones(1,2),-10:130:120, 2180*ones(1,2),'LineWidth',5,'Color','#FFAA00')
line(60*ones(1,2),0:110:110, 2180*ones(1,2),'LineWidth',5,'Color','red')
line(90*ones(1,2),0:110:110, 2180*ones(1,2),'LineWidth',5,'Color','red')
line(120*ones(1,2),0:110:110, 2180*ones(1,2),'LineWidth',5,'Color','red')

% Plots a GoogleEarth Image on top of scatter plots
if 1
xImage = [0 120; 0 120];   %# The x data for the image corners
yImage = [-15 -15; 130 130];             %# The y data for the image corners
zImage = [2180 2180; 2180 2180];   %# The z data for the image corners
surf(xImage,yImage,zImage,'CData',img,'FaceColor','texturemap'); %Plots the image in the scatter plot
alpha 0.85              % transparency
end

hold off

%% Save & adjust figure

% Scatter Plot Features
set(findall(gcf,'-property','FontSize'),'FontSize',12 ) 
set(findall(gcf,'-property','FontName'),'FontName','Ariel' ) 

c = colorbar('Position', [0.92 0.3 0.02 0.5]);
caxis ([1 3]);
colormap jet
ylabel(c, 'Log_{10} Resistivity (\Omegam)' ,'FontSize',12 )
ylim(setYlim);            
xlim(setXlim);
zlim(setZlim);
set(gca, 'YDir','reverse');
xticks([0:30:120]);
xticklabels({'R1','R2','R3','R4','R5'})
yticks([-10:20:140]');
zticks([2180:5:2200]);
ylabel('Distance Along Lines 1-5 (m) ');

 
%get y label to parallel the y axis
yh = get(gca,'YLabel'); % Handle of the y label
set(yh, 'Units', 'Normalized')
pos = get(yh, 'Position');
set(yh, 'Position',pos.*[0.4,-0.3,0],'Rotation',-35)
view(-20,30)

zlabel('Elevation (m)');
title('Rosette Spring ERT Lines 1-5 ','FontSize',14)

pbaspect([2 2 1])         % aspect ratio for axes

view(-15,10)

set(findall(gcf,'-property','FontSize'),'FontSize',16 ) 
set(findall(gcf,'-property','FontName'),'FontName','Ariel' )
