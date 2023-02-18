%* The data is download and prepared from ORA-S4
% https://www.cen.uni-hamburg.de/en/icdc/data/ocean/easy-init-ocean/ecmwf-ocean-reanalysis-system-4-oras4.html
%* There are some scripts that download and used to make the scripts workshop
%* have the script to calculate sigmaT at 0 bar
% https://www.teos-10.org/
%* The isopycnal script is mimic from the isothermo scirpt
%*     to obtain the final isopycnal out Research Assistent, An-yi Huang, from University Taipei has modified to fix for the purpose
%*     more details please email An-yi Huang 
% https://au.mathworks.com/matlabcentral/fileexchange/41733-3d-surface-plot-for-data-visualization
% https://au.mathworks.com/matlabcentral/fileexchange/53372-isotherms-computation?s_tid=FX_rc2_behav
%* We then also download the script for colour map
% https://au.mathworks.com/matlabcentral/fileexchange/42450-custom-colormap?s_tid=prof_contriblnk
% Erik Kvaleberg (2023). Custom colormap (https://www.mathworks.com/matlabcentral/fileexchange/42450-custom-colormap), MATLAB Central File Exchange. Retrieved February 18, 2023.
clear all; close all; clc;

%% Data
load an_yi.mat

nlvl=size(lvl,1);
nlon=size(lon,1);
nlat=size(lat,1);
[lonn,latt]=meshgrid(lon,lat);

%% Calculation

sigma0 = gsw_sigma0(SA,CT);
sigma0 = permute(sigma0,[3 2 1]);

isovalue=25;
isopycnal=ra_isopycnal(sigma0,lvl,isovalue);

%% Plot
close all;
%surf(isopycnal);
%title('isopycnal');

% figure settings
lon1=120; [~,lon1p]=min(abs(lon1-lon));
lon2=280; [~,lon2p]=min(abs(lon2-lon));
lat1=-50; [~,lat1p]=min(abs(lat1-lat));
lat2=40; [~,lat2p]=min(abs(lat2-lat));
flon={'120°E','140°E','160°E','180°','160°W','140°W','120°W','100°W','80°W'};
flat={'50°S','40°S','30°S','20°S','10°S','0°','10°N','20°N','30°N','40°N'};

% 2D
figure(1); hold on;
set(gcf,'color','w','units','centimeters','Position',[29.5 1.5 28 17]);
tot = tiledlayout(1,1,'TileSpacing','compact','Padding','compact');

nexttile; hold on;
surf(lon,lat,isopycnal); shading interp;
caxis([0 300]); colormap(jet(256));
colorbar('ytick',50:50:250,'fontsize',12,'ticklength',0.028);

axis([lon1 lon2 lat1 lat2]);
grid on; %box on;
set(gca,'tickdir','out','zdir','reverse','linew',1,'GridLineStyle','-',...
    'ticklength',[0.01 0.01],'fontsize',12);
set(gca,'xtick',lon1:20:lon2,'ytick',lat1:10:lat2,'ztick',0:50:300);
set(gca,'xticklabel',flon,'yticklabel',flat);
view([-40 60]);

zlabel('Depth (m)','fontsize',14)

title('ORA-S4: Period over 1958-2014','isopycnal: \sigma=25','Color','black',...
    'fontsize',16,'FontAngle','italic');

FNAM='Isopycnal_3D.png';
disp(FNAM); pause(1);
exportgraphics(tot,FNAM,'BackgroundColor','w','Resolution',150);
%print('-r150','-dpng',FNAM);
pause(1); close(1);


