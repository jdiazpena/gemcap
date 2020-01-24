function [state, E] = model_setup_interp(simID, simroot, p)
narginchk(3,3)
validateattributes(simID, {'char'}, {'vector'}, mfilename, 'name of simulation',1)
validateattributes(simroot, {'char'}, {'vector'}, mfilename, 'output directory top',2)
validateattributes(p, {'struct'}, {'scalar'}, mfilename, 'parameters', 3)
eqID = [simID, '_eq'];

%% check directories
assert(isfolder(simroot), [simroot, ' is not a directory'])
eq_dir = [simroot, filesep, eqID];
assert(isfolder(eq_dir), [eq_dir, ' is not a directory'])
outdir = [simroot, filesep, [simID, '_in']];

%ADD PATHS FOR FUNCTIONS
cwd = fileparts(mfilename('fullpath'));
gemdir = [cwd, '/../../gemini'];
assert(isfolder(gemdir), [gemdir, ' not found'])
for d = {'script_utils', 'setup', 'setup/gridgen', 'vis'}
  addpath([gemdir, filesep, d{:}])
end

%% GRID GENERATION
xg = makegrid_cart_3D(p.xdist, p.lxp, p.ydist, p.lyp, p.I, p.glat, p.glon);

% these new variables are just for your information, they are written to disk by eq2dist().
[nsi, vs1i, Tsi, xgin, ns, vs1, Ts] = eq2dist(eq_dir, simID, xg, outdir);

state.nsi = nsi;
state.vs1i = vs1i;

state.Tsi = Tsi;
state.xgin = xgin;
state.ns = ns;
state.vs1 = vs1;
state.Ts = Ts;

%% potential boundary conditions

if p.lxp == 1 || p.lyp == 1
  E = Efield_BCs_2d(p, outdir, 'hdf5', [cwd, '/config.nml']);
else % 3D
  E = Efield_BCs_3d(p, outdir, 'hdf5', [cwd, '/config.nml']);
end

if ~nargout, clear('state', 'E'), end
end % function
