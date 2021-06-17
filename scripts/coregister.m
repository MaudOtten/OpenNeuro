function matlabbatch = coregister(bnr, sdata)
  %% Load batch for coregistration
  matlabbatch{1}.spm.spatial.coreg.estwrite.ref = '<UNDEFINED>';
  
  matlabbatch{1}.spm.spatial.coreg.estwrite.source = '<UNDEFINED>';
  
  matlabbatch{1}.spm.spatial.coreg.estwrite.other = {''};
  matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.cost_fun = 'nmi';
  matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.sep = [4 2];
  matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
  matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.fwhm = [7 7];
  matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.interp = 4;
  matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.wrap = [0 0 0];
  matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.mask = 0;
  matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.prefix = 'r';

  if sdata.save_mlb == 1
    save(["job_files/coregister_", sdata.ses ,".mat"], "matlabbatch");
  endif
  
  % run batch
  spm_jobman("run", matlabbatch)
  
endfunction