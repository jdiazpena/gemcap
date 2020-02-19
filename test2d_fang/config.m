function config()
%% 2D east-west test
%

%% boilerplate for each config.m file
cwd = fileparts(mfilename('fullpath'));
gemroot = getenv('GEMINI_ROOT');
addpath([gemroot,'/script_utils'], [gemroot,'/setup'])

% convenience
simroot = [cwd, '/../../gemini_sim'];

p.format = 'h5';
p.nml = [cwd,'/config.nml'];
p.eqdir = [simroot, '/test2d_eq'];
p.eqnml = [p.eqdir, '/inputs/config.nml'];
p.simdir = [simroot, '/test2d_fang'];

p = merge_struct(p, read_nml(p.nml));

%% perturbations
p.Etarg = 50e-3;  % [V/m]

% normalized widths
p.Efield_fracwidth = 1/7;
p.precip_latwidth = 1/4;
p.precip_lonwidth = 1/4;

%% setup simulation
model_setup_interp(p)

end % function
