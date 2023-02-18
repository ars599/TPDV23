function isopycnal=ra_isopycnal(sigma,Z,isovalue)
% It is constant sigmaerature depth. i.e. 20 deg. C isopycnal defines depth at which sigmaerature 
% is 20C, often denoted as Z20 or D20 
%===========================================================%
% RA_ISOpycnal  $Id: ra_isopycnal.m, 2015/02/20 $
%          Copyright (C) CORAL-IITKGP, Ramkrushn S. Patel 2014.
%
% AUTHOR: 
% Ramkrushn S. Patel (ramkrushn.scrv89@gmail.com)
% Roll No: 13CL60R05
% Place: IIT Kharagpur.
% This is a part of M. Tech project under the supervision of DR. ARUN CHAKRABORTY
%===========================================================%
% 
% USAGE: isopycnal=ra_isopycnal(sigma,Z,isovalue)
%
% DESCRIPTION:  This function determines Isopycnals from profile data sets. If you have 3D 
% data sets i.e. level, lat and lon and want to compute the Isopycnal, then this function will 
% be very handy. Because this function is specifically designed for those cases. However, 
% it can evaluate isopycnals from profile data too.
%
% INPUTS: 
% sigma = sigma profiles over the study region [deg. C], either 3D or vector
% Z = Levels [m], Must be vector
% isovalue = sigma at which you want to compute isopycnals [Sigma], Must be scalar
%
% OUTPUT: 
% isopycnal = Isopycnals depth, spatial output [m]
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
   error('ra_isopycnal.m: Must pass at least two parameters')
end 
% Optional value
if (nargin == 2)
    isovalue=[];
    str = 'U R using default value for Isopycnals (20C)';
    warning(['ra_isopycnal.m:', str])  %#ok<WNTAG>
end
if (isempty(isovalue))
    isovalue=20;
end
% Dimension Check
[lv, lt, ln]=size(sigma);  
if (lv ~= length(Z))
    error('ra_isopycnal.m: Check_Z - level must be same as sigma')
end
if (numel(isovalue) ~= 1) 
    error('ra_isopycnal.m: check ISOVALUE - must be scalar')
end
% Post processing
T=reshape(sigma, lv, lt*ln);
oce=~isnan(sigma(1, :)); % Not land portion since land portion is NAN
land=isnan(sigma(1, :)); % Land portion location
T(:, land)=[];
[~, n5]=size(T);
% Isopycnals Depth computation
pycnal=NaN(n5, 1);
for ii=1:n5
    t=T(:, ii);
    pos1=find( t>isovalue );
    if ((numel(pos1) > 0) && (pos1(1) > 1))
        p2=pos1(1);
        p1=p2-1;
        pycnal(ii)=interp1(t([p1, p2]), Z([p1, p2]), isovalue);
    else
        pycnal(ii)=NaN;
    end
end
isopycnal=NaN(1, lt*ln);
isopycnal(oce)=pycnal;
isopycnal=reshape(isopycnal, lt, ln);

