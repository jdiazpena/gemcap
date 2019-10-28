% Note: run this script from the same environment you compiled the main
% Gemini program in. On Windows, that usually means WSL.

%LOWRES 2D grid generation
xdist=1200e3;    %eastward distance
ydist=600e3;    %northward distance
lxp=1;
lyp=15;
glat=74.73;
glon=265.095; % 94.905 W
gridflag=0;
I=90;
UT=11.0;
dmy=[1,23,2012];
% [f107a, f107, ap] = activ;
% python
% import geomagindices as gi
% gi.get_indices('2012-01-23T11', smoothdays=81)
activ=[88.896, 139.8, 3];


%ADD PATHS FOR FUNCTIONS
cwd = fileparts(mfilename('fullpath'));
addpath([cwd, '/../gemini/script_utils']);
addpath([cwd, '/../gemini/setup']);
addpath([cwd, '/../gemini/setup',filesep,'gridgen'])
addpath([cwd, '/../gemini/vis']);


%% GRID GENERATION
xg = makegrid_cart_3D(xdist,lxp,ydist,lyp,I,glat,glon);
% GENERATE INITIAL CONDITIONS FOR A PARTICULAR EVENT
nmf=5e11;
nme=2e11;
[ns,Ts,vsx1] = eqICs3D(xg,UT,dmy,activ,nmf,nme);
% Note: should be rewritten to include the neutral module form the fortran code


%WRITE THE GRID AND INITIAL CONDITIONS
simlabel = '2D_eq';
outdir='../gemini_sim/inputs/2D_eq/';
writegrid(xg, outdir);
time=UT*3600;   %doesn't matter for input files
writedata(dmy,time,ns,vsx1,Ts,outdir,simlabel);

