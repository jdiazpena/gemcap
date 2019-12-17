function [state, E] = model_setup_interp_2d(simID, eqID)
narginchk(0,2)
if nargin < 1, simID = 'risr2d'; end  % name of the new simulation
if nargin < 2, eqID = [simID, '_eq']; end
%% user parameters
params.realbits = 64;
params.fracwidth = 1/7;
%% 2D grid generation parameters
% FIXME: for now, make a little smaller than equilibrium sim to avoid going
% outside its bounds with ghost cells
xdist = 1200e3;    %eastward distance
ydist = 600e3;    %northward distance
lxp = 1;
lyp = 150;
glat = 74.73;
glon = 265.095; % 94.905 W
I = 90;

cwd = fileparts(mfilename('fullpath'));
simroot = [cwd, '/../../gemini_sim'];
assert(isfolder(simroot), [simroot, ' is not a directory'])

eq_dir = [simroot, filesep, eqID];
assert(isfolder(eq_dir), [eq_dir, ' is not a directory'])

outdir = [simroot, filesep, simID];

%ADD PATHS FOR FUNCTIONS
gemdir = [cwd, '/../../gemini'];
assert(isfolder(gemdir), [gemdir, ' not found'])
for d = {'script_utils', 'setup', 'setup/gridgen', 'vis'}
  addpath([gemdir, filesep, d{:}])
end
%% GRID GENERATION
xg = makegrid_cart_3D(xdist, lxp, ydist, lyp, I, glat, glon);

% these new variables are just for your information, they are written to disk by eq2dist().
[nsi, vs1i, Tsi, xgin, ns, vs1, Ts] = eq2dist(eq_dir, simID, xg, outdir, params.realbits);

state.nsi = nsi;
state.vs1i = vs1i;
state.Tsi = Tsi;
state.xgin = xgin;
state.ns = ns;
state.vs1 = vs1;
state.Ts = Ts;

%% potential boundary conditions

E = Efield_BCs_2d(params, outdir, 'raw', [cwd, '/config.nml']);

if ~nargout, clear('state', 'E'), end
end % function