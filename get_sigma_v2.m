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
clear all; close all;

%SA = ncread('so_oras4_1m_1958-2015_grid_1x1_mean.nc','so');
%CT = ncread('thetao_oras4_1m_1958-2015_grid_1x1.mean.nc','thetao');
%save('an_yi.mat','SA','CT')

load an_yi.mat

sigma0 = gsw_sigma0(SA,CT);
% check the sigma
% surf(sigma0(:,:,10)'); zlim([20 30]);clim([23 28]);colorbar

Z = [ 5.02159 15.07854 25.16046 35.27829 45.44776 55.69149 66.04198 ...
    76.54591 87.27029 98.31118 109.8062 121.9519 135.0285 149.4337 ...
    165.7285 184.6975 207.4254 235.3862 270.5341 315.3741 372.9655 ...
    446.8009 540.5022 657.3229 799.5496 967.9958 1161.806 1378.661 ...
    1615.291 1868.071 2133.517 2408.583 2690.78 2978.166 3269.278 ...
    3563.041 3858.676 4155.628 4453.502 4752.021 5050.99 5350.272 ];

sigma0 = permute(sigma0,[3 2 1]);

isovalue=25.;
iso20=ra_isopycnal(sigma0,Z,isovalue);

% Generate figure
figure('units','normalized','outerposition',[0 0 1 1]);

surf(lon,lat,depth,iso20)

surf(iso20(40:130,120:280)); set(gca, 'ZDir','reverse'); 
view([-35 60])

zlabel('Depth (m)');
[t,s] = title('ORA-S4: Period over 1958-2014', 'isopycnal: \sigma=25', 'Color','black');
t.FontSize = 16; s.FontAngle = 'italic';
shading interp

%c = cmap([-.8  -.2   1]); %c = flipud(c);
%margins = [7 7 15 11]; % N S E W
%A = imread('https://www.mathworks.com/matlabcentral/answers/uploaded_files/853000/image.png');
%A = A(1+margins(1):end-margins(2),1+margins(4):end-margins(3),:);
%CT0 = permute(mean(im2double(A),1),[2 3 1]);
%CT0 = CT0([true; ~all(diff(CT0,1,1)==0,2)],:); % remove duplicate rows

% CT0 is now a fixed-length color table
% make it whatever length we want
%N = 32; % specify the number of colors in table
%na = size(CT0,1);
%CT = interp1(linspace(0,1,na),CT0,linspace(0,1,N));

CT = jet(256);
CT(1:find(CT(:,1)==0.5),1) = 0.5;

% CT = flipud(CT); % reverse colour
colormap(CT);
colorbar; % colorbar('horiz');

 % saving new image
   saveas(gcf,'ora_s4_sigma25.png');