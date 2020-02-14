function config()
%% 2D east-west test
%
cwd = fileparts(mfilename('fullpath'));

p.format = 'hdf5';
p.nml = [cwd,'/config.nml'];
p.eqdir = [cwd, '/../../gemini_sim/test2d_eq'];
p.simdir = [cwd, '/../../gemini_sim/test2d_fang'];
p.xdist = 200e3;    %eastward distance
p.ydist = 600e3;    %northward distance
p.lxp = 80;
p.lyp = 1;
p.glat = 67.11;
p.glon = 212.95;
p.I = 90;
p.nmf = 5e11;
p.nme = 2e11;

p = merge_struct(p, read_config(p.nml));
% import geomagindices as gi
% gi.get_indices('2013-02-20T05', smoothdays=81)
p.activ = [108.9, 111.0, 5];

model_setup_equilibrium(p)
end % function
