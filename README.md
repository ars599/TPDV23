# TPDV workshop at Monash (2023)

```
please try to play the code. if you have any question please leave message at issue.
```

# Introduction and resources

** Before using the scripts: 

* The data is download and prepared from ORA-S4
% https://www.cen.uni-hamburg.de/en/icdc/data/ocean/easy-init-ocean/ecmwf-ocean-reanalysis-system-4-oras4.html

* There are some scripts that download and used to make the scripts workshop
* have the script to calculate sigmaT at 0 bar
% https://www.teos-10.org/

* The isopycnal script is mimic from the isothermo scirpt
     to obtain the final isopycnal out Research Assistent, An-yi Huang, from University Taipei has modified to fix for the purpose
     more details please email An-yi Huang  (b810641@gmail.com) 
% https://au.mathworks.com/matlabcentral/fileexchange/41733-3d-surface-plot-for-data-visualization
% https://au.mathworks.com/matlabcentral/fileexchange/53372-isotherms-computation?s_tid=FX_rc2_behav

* We then also download the script for colour map
% https://au.mathworks.com/matlabcentral/fileexchange/42450-custom-colormap?s_tid=prof_contriblnk
% Erik Kvaleberg (2023). Custom colormap (https://www.mathworks.com/matlabcentral/fileexchange/42450-custom-colormap), MATLAB Central File Exchange. Retrieved February 18, 2023.




# MATLAB scripts
** How to use it
 
```
1) From NetCDF
fn='so_oras4_1m_1958-2015_grid_1x1_mean.nc';
lev=ncread(fn,'depth'); nlev=size(lev,1);
lon=ncread(fn,'lon'); nlon=size(lon,1);
lat=ncread(fn,'lat'); nlat=size(lat,1);
[lonn,latt]=meshgrid(lon,lat);
SA = ncread(fn,'so');

fn='thetao_oras4_1m_1958-2015_grid_1x1.mean.nc';
CT = ncread(fn,'thetao');

save('an_yi.mat','SA','CT','lon','lat','lvl')

2) From mat file
load an_yi.mat

3) calculate the sigma then calculate isopycnal
sigma0 = gsw_sigma0(SA,CT);
iso20=ra_isopycnal(sigma0,Z,isovalue);

*** get_sigma_v3.m is the final version

```


** Output in 2D (due to the copy right here we only dispaly the results based on 2D)

![](https://github.com/ars599/TPDV23/blob/main/Isopycnal_2D.png)

