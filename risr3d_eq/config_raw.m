cwd = fileparts(mfilename('fullpath'));
simroot = [cwd,'/../../gemini_sim'];

p.format = 'raw';
p.simID = 'risr3d';
p.nml = [cwd,'/config_raw.nml'];
p.xdist = 100e3;    %eastward distance
p.ydist = 600e3;    %northward distance
p.lxp = 10;
p.lyp = 20;
p.glat = 74.73;
p.glon = 265.095; % 94.905 W
p.I = 90;
p.nmf = 5e11;
p.nme = 2e11;

% [f107a, f107, ap] = activ;
% import geomagindices as gi
% gi.get_indices('2012-01-23T11', smoothdays=81)
p.activ=[88.896, 139.8, 3];

model_setup(p, simroot)