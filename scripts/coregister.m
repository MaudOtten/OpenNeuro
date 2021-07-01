function sdata = coregister(sdata)
  spm_jobman('initcfg');
  matlabbatch = {};
  
  % coregister segmented image (gm, wm, csf) to mean functional scan
  matlabbatch{1}.spm.spatial.coreg.estimate.ref = cellstr(spm_select('FPList', sdata.func_fp, '^meanu.*nii$'));
  
  matlabbatch{1}.spm.spatial.coreg.estimate.source = cellstr(spm_select('FPList', sdata.anat_fp, '^ss-ms.*nii$'));
  
  matlabbatch{1}.spm.spatial.coreg.estimate.other             = {''};
  matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.cost_fun = 'nmi';
  matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.sep      = [4 2];
  matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.tol      = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
  matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.fwhm     = [7 7]; 

  % save batch
  if sdata.save_mlb == 1
    save(fullfile("job_files", ["coreg_anat2func_", sdata.ses ,".mat"]), "matlabbatch");
  endif
  
  % run batch
  if sdata.run == true
    spm_jobman('run',matlabbatch);
  endif

  clear matlabbatch
  
  
  spm_jobman('initcfg');
  matlabbatch = {};
  
  %% Load batch for coregistration
  matlabbatch{1}.spm.spatial.coreg.estwrite.ref = cellstr(spm_select('FPList', fullfile(sdata.data_dir, 'derivatives'), '^2mm_template.*nii$'));
  
  matlabbatch{1}.spm.spatial.coreg.estwrite.source = cellstr(spm_select('FPList', sdata.anat_fp, '^ss-ms.*nii$'));
  
  meanrest = cellstr(spm_select('FPList', sdata.func_fp, '^meanu.*nii$'));
  fullrest = cellstr(spm_select('FPList', sdata.func_fp, '^us.*nii$'));
  
  matlabbatch{1}.spm.spatial.coreg.estwrite.other = [meanrest; fullrest];
  matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.cost_fun = 'nmi';
  matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.sep = [4 2];
  matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
  matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.fwhm = [7 7];
  matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.interp = 4;
  matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.wrap = [0 0 0];
  matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.mask = 0;
  matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.prefix = 'r';

  % save batch
  if sdata.save_mlb == 1
    save(fullfile("job_files", ["coreg_all2temp_", sdata.ses ,".mat"]), "matlabbatch");
  endif
  
  % run batch
  if sdata.run == 1
    spm_jobman('run',matlabbatch);
  endif
  
endfunction