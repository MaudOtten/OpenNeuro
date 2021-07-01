root_dir =  "C:/Users/maudo/Documents/Projects/OpenNeuro/";
#root_dir = "/mnt/c/Users/maudo/Documents/Projects/OpenNeuro/";
cd(root_dir);
cwd = pwd;


# Load spm
install_spm;

spm('defaults', 'FMRI');
spm_get_defaults('cmdline',true);

% Set path variables
sdata.root_dir = cwd; % "C:/Users/maudo/Documents/Projects/OpenNeuro/"
sdata.data_dir = fullfile(sdata.root_dir, 'ds-spm');
sdata.sub = "sub-01";

% To save batches (job_files/*.mat), set to 1
sdata.save_mlb = true;
sdata.run = true;

% Check nr of sessions in data directory
[~, sessions] = spm_select('FPList', fullfile(sdata.data_dir, sdata.sub), 'dummy.xxx');

% go to script dir
cd(fullfile(cwd, 'scripts'));
addpath(genpath(fullfile(root_dir, 'scripts', 'third_party')));

% Perform preprocessing
for i = 1:size(sessions)
  sdata.ses = sprintf("ses-%02d", i);
  sdata.ses_dir = fullfile(sdata.data_dir, sdata.sub, sdata.ses);
  
  % calculate VDM, realign and unwarp EPI
  sdata = realign_unwarp(sdata);
  
  % segment T1w scan, skull-strip data based on segmentation
  sdata = segment_strip(sdata);
  
  % estimate anatomical noise, normalize EPI
  sdata = estimate_noise(sdata);
  
  % coregister T1w segmentation and EPI to subject-specific template
  sdata = coregister(sdata);

endfor

endm = "That's it folks!"

% Analysis