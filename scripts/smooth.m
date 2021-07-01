function sdata = smooth(sdata)  
  spm_jobman('initcfg');
  matlabbatch = {};
  
  % smoothing batch
  matlabbatch{1}.spm.spatial.smooth.data   = cellstr(spm_select('FPList', sdata.func_fp, '^ru.*nii$'));
  matlabbatch{1}.spm.spatial.smooth.fwhm   = [4 4 4];
  matlabbatch{1}.spm.spatial.smooth.dtype  = 0;
  matlabbatch{1}.spm.spatial.smooth.im     = 0;
  matlabbatch{1}.spm.spatial.smooth.prefix = 's';
  
  if sdata.save_mlb == true
    save(fullfile("job_files", ["smooth_", sdata.ses ,".mat"]), "matlabbatch");
  endif
  
  % run batch
  if sdata.run == true
    spm_jobman('run',matlabbatch);
  endif

endfunction