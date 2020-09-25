function setup()
%% configure paths to work with MatGemini

cwd = fileparts(mfilename('fullpath'));
gemini_matlab = fullfile(cwd, "../mat_gemini");
if ~isfolder(gemini_matlab)
  cmd = "git -C " + fullfile(cwd, "..") + " clone https://github.com/gemini3d/mat_gemini.git";
  disp(cmd)
  ret = system(cmd);
  assert(ret==0, 'problem downloading Gemini Matlab functions')
end
run(fullfile(gemini_matlab, "setup.m"))

end
