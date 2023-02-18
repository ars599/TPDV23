function isotherm=ra_isotherm(temp,Z,isovalue)
% It is constant temperature depth. i.e. 20 deg. C isotherm defines depth at which temperature 
% is 20C, often denoted as Z20 or D20 
%===========================================================%
% RA_ISOTHERM  $Id: ra_isotherm.m, 2015/02/20 $
%          Copyright (C) CORAL-IITKGP, Ramkrushn S. Patel 2014.
%
% AUTHOR: 
% Ramkrushn S. Patel (ramkrushn.scrv89@gmail.com)
% Roll No: 13CL60R05
% Place: IIT Kharagpur.
% This is a part of M. Tech project under the supervision of DR. ARUN CHAKRABORTY
%===========================================================%
% 
% USAGE: isotherm=ra_isotherm(temp,Z,isovalue)
%
% DESCRIPTION:  This function determines Isotherms from profile data sets. If you have 3D 
% data sets i.e. level, lat and lon and want to compute the Isotherm, then this function will 
% be very handy. Because this function is specifically designed for those cases. However, 
% it can evaluate isotherms from profile data too.
%
% INPUTS: 
% temp = Temperature profiles over the study region [deg. C], either 3D or vector
% Z = Levels [m], Must be vector
% isovalue = temperature at which you want to compute isotherms [deg. C], Must be scalar
%
% OUTPUT: 
% isotherm = Isotherms depth, spatial output [m]
% 
% DISCLAIMER: 
% Albeit this function is designed only for academic purpose, it can be implemented in 
% research. Nonetheless, author does not guarantee the accuracy.
% 
% ACKNOWLEDGMENT:
% Author is grateful to MathWorks for developing in built functions.
% ***********************************************************************************************%
% Taking care of sufficient input agrument
if ((nargin < 2) || (nargin > 3))
   error('ra_isotherm.m: Must pass at least two parameters')
end 
% Optional value
if (nargin == 2)
    isovalue=[];
    str = 'U R using default value for Isotherms (20C)';
    warning(['ra_isotherm.m:', str])  %#ok<WNTAG>
end
if (isempty(isovalue))
    isovalue=20;
end
% Dimension Check
[lv, lt, ln]=size(temp);  
if (lv ~= length(Z))
    error('ra_isotherm.m: Check_Z - level must be same as TEMP')
end
if (numel(isovalue) ~= 1) 
    error('ra_isotherm.m: check ISOVALUE - must be scalar')
end
% Post processing
T=reshape(temp, lv, lt*ln);
oce=~isnan(temp(1, :)); % Not land portion since land portion is NAN
land=isnan(temp(1, :)); % Land portion location
T(:, land)=[];
[~, n5]=size(T);
% Isotherms Depth computation
therm=NaN(n5, 1);
for ii=1:n5
    t=T(:, ii);
    pos1=find( t < isovalue);
    if ((numel(pos1) > 0) && (pos1(1) > 1))
        p2=pos1(1);
        p1=p2-1;
        therm(ii)=interp1(t([p1, p2]), Z([p1, p2]), isovalue);
    else
        therm(ii)=NaN;
    end
end
isotherm=NaN(1, lt*ln);
isotherm(oce)=therm;
isotherm=reshape(isotherm, lt, ln);