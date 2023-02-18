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

SA = ncread('so_oras4_1m_1958-2015_grid_1x1_mean.nc','so');
CT = ncread('thetao_oras4_1m_1958-2015_grid_1x1.mean.nc','thetao');

lat = ncread('thetao_oras4_1m_1958-2015_grid_1x1.mean.nc','lat');
lon = ncread('thetao_oras4_1m_1958-2015_grid_1x1.mean.nc','lon');
lvl = ncread('thetao_oras4_1m_1958-2015_grid_1x1.mean.nc','depth');
% save('an_yi.mat','SA','CT','lat','lon','lvl')

sigma0 = gsw_sigma0(SA,CT);

lvl = [ 5.02159 15.07854 25.16046 35.27829 45.44776 55.69149 66.04198 ...
    76.54591 87.27029 98.31118 109.8062 121.9519 135.0285 149.4337 ...
    165.7285 184.6975 207.4254 235.3862 270.5341 315.3741 372.9655 ...
    446.8009 540.5022 657.3229 799.5496 967.9958 1161.806 1378.661 ...
    1615.291 1868.071 2133.517 2408.583 2690.78 2978.166 3269.278 ...
    3563.041 3858.676 4155.628 4453.502 4752.021 5050.99 5350.272 ];
Z = lvl';

sigma0 = permute(sigma0,[3 2 1]);

isovalue=25;
iso20=ra_isopycnal(sigma0,Z,isovalue);

%iso20(isnan(iso20))=0;

surf(iso20); set(gca, 'ZDir','reverse');
title('isopycnal');
shading interp

colormap(flipud(cmap([0 1 1],10,5,0)))
colorbar
