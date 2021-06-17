clc
clear all

cd('../')
cwd = pwd

# Load spm
install_spm

spm('defaults', 'FMRI');
spm_get_defaults('cmdline',true);

% Set path variables
sdata.root_dir = cwd; % "C:/Users/maudo/Documents/Projects/OpenNeuro/"
sdata.data_dir = [sdata.root_dir, "\\ds-spm\\"];
sdata.sub = "sub-01\\";

% To save batches (job_files/*.mat), set to 1
sdata.save_mlb = true;

% Check nr of sessions in data directory
[~, sessions] = spm_select('FPList', [sdata.data_dir, sdata.sub], 'dummy.xxx');

% go to script dir
cd([cwd, '\\scripts'])

% Perform preprocessing
for i = 1:size(sessions)(1)
  sdata.ses = sprintf("ses-%02d", i);
  sdata.ses_dir = [sdata.data_dir, sdata.sub, sdata.ses];
  
  % calculate VDM, realign and unwarp EPI
  %realign_unwarp(sdata);
  
  % segment T1w scan, skull-strip data based on segmentation
  %segment_strip(sdata);

endfor



% Analysis