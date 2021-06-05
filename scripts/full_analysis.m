# Load spm
#run install_spm.m

# Run VDM calc on each session
data_dir = "C:/Users/maudo/Documents/Projects/OpenNeuro/test_data/";
sdata.sub = "sub-01/";


for i = 1:5
  sdata.ses = sprintf("ses-%02d", i);
  sdata.ses_dir = [data_dir, sdata.sub, sdata.ses];
  
  matlabbatch = load_batch(1, sdata);
  save(["calc_VDM_", sdata.ses ,".mat"], "matlabbatch");
  spm_jobman("run", matlabbatch)
  
  matlabbatch = load_batch(2, sdata);
  save(["app_VDM_", sdata.ses ,".mat"], "matlabbatch");
  spm_jobman("run", matlabbatch)
endfor


# Perform preprocessing

# Analysis