function config()
%% 2D east-west test equilibrium
%

%% boilerplate for each config.m file
cwd = fileparts(mfilename('fullpath'));
gemroot = getenv('GEMINI_ROOT');
addpath([gemroot,'/script_utils'], [gemroot,'/setup'])

p.format = 'h5';
p.nml = [cwd,'/config.nml'];
p.simdir = [cwd, '/../../gemini_sim/test2d_eq'];

p = merge_struct(p, read_nml(p.nml));

%% setup simulation
model_setup_equilibrium(p)

end % function
