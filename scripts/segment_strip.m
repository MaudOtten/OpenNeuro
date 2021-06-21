function matlabbatch = segment_strip(sdata)
  spm_jobman('initcfg');
  matlabbatch = {};
  
  anat_fp = fullfile(sdata.ses_dir, 'anat')
  
  %% Load batch for segmentation
  matlabbatch{1}.spm.spatial.preproc.channel.vols = cellstr(spm_select('FPList', anat_fp, '^s.*T1w.nii$'));

  matlabbatch{1}.spm.spatial.preproc.channel.biasreg  = 0.001;
  matlabbatch{1}.spm.spatial.preproc.channel.biasfwhm = 60;
  matlabbatch{1}.spm.spatial.preproc.channel.write    = [0 1];

  matlabbatch{1}.spm.spatial.preproc.tissue(1).tpm    = cellstr(fullfile(spm('Dir'), 'tpm', 'TPM.nii,1'));
  matlabbatch{1}.spm.spatial.preproc.tissue(1).ngaus  = 1;
  matlabbatch{1}.spm.spatial.preproc.tissue(1).native = [1 0];
  matlabbatch{1}.spm.spatial.preproc.tissue(1).warped = [1 1];
  matlabbatch{1}.spm.spatial.preproc.tissue(2).tpm    = cellstr(fullfile(spm('Dir'), 'tpm', 'TPM.nii,2'));
  matlabbatch{1}.spm.spatial.preproc.tissue(2).ngaus  = 1;
  matlabbatch{1}.spm.spatial.preproc.tissue(2).native = [1 0];
  matlabbatch{1}.spm.spatial.preproc.tissue(2).warped = [1 1];
  matlabbatch{1}.spm.spatial.preproc.tissue(3).tpm    = cellstr(fullfile(spm('Dir'), 'tpm', 'TPM.nii,3'));
  matlabbatch{1}.spm.spatial.preproc.tissue(3).ngaus  = 2;
  matlabbatch{1}.spm.spatial.preproc.tissue(3).native = [1 0];
  matlabbatch{1}.spm.spatial.preproc.tissue(3).warped = [1 1];
  matlabbatch{1}.spm.spatial.preproc.tissue(4).tpm    = cellstr(fullfile(spm('Dir'), 'tpm', 'TPM.nii,4'));
  matlabbatch{1}.spm.spatial.preproc.tissue(4).ngaus  = 3;
  matlabbatch{1}.spm.spatial.preproc.tissue(4).native = [1 0];
  matlabbatch{1}.spm.spatial.preproc.tissue(4).warped = [0 0];
  matlabbatch{1}.spm.spatial.preproc.tissue(5).tpm    = cellstr(fullfile(spm('Dir'), 'tpm', 'TPM.nii,5'));
  matlabbatch{1}.spm.spatial.preproc.tissue(5).ngaus  = 4;
  matlabbatch{1}.spm.spatial.preproc.tissue(5).native = [1 0];
  matlabbatch{1}.spm.spatial.preproc.tissue(5).warped = [0 0];
  matlabbatch{1}.spm.spatial.preproc.tissue(6).tpm    = cellstr(fullfile(spm('Dir'), 'tpm', 'TPM.nii,6'));
  matlabbatch{1}.spm.spatial.preproc.tissue(6).ngaus  = 2;
  matlabbatch{1}.spm.spatial.preproc.tissue(6).native = [0 0];
  matlabbatch{1}.spm.spatial.preproc.tissue(6).warped = [0 0];

  matlabbatch{1}.spm.spatial.preproc.warp.mrf     = 1;
  matlabbatch{1}.spm.spatial.preproc.warp.cleanup = 1;
  matlabbatch{1}.spm.spatial.preproc.warp.reg     = [0 0.001 0.5 0.05 0.2];
  matlabbatch{1}.spm.spatial.preproc.warp.affreg  = 'mni';
  matlabbatch{1}.spm.spatial.preproc.warp.fwhm    = 0;
  matlabbatch{1}.spm.spatial.preproc.warp.samp    = 3;
  matlabbatch{1}.spm.spatial.preproc.warp.write   = [1 1];
  
  if sdata.save_mlb == 1
    save(fullfile("job_files", ["segment_", sdata.ses ,".mat"]), "matlabbatch");
  endif
  
  % run batch
  spm_jobman("run", matlabbatch)
  
  
  matlabbatch = {};

  %% Load batch for skull stripping
  gm = cellstr(spm_select('FPList', anat_fp, '^c1s.*T1w.nii$'))
  wm = cellstr(spm_select('FPList', anat_fp, '^c2s.*T1w.nii$'))
  csf = cellstr(spm_select('FPList', anat_fp, '^c3s.*T1w.nii$'))
  
  bcorr = cellstr(spm_select('FPList', anat_fp, '^ms.*T1w.nii$'))
  [~,fn,~] = fileparts(char(bcorr));
  
  matlabbatch{1}.spm.util.imcalc.input          = cellstr([gm; wm; csf; bcorr]);

  matlabbatch{1}.spm.util.imcalc.output         = [anat_fp, '/ss-', fn, '.nii'];
  matlabbatch{1}.spm.util.imcalc.expression     = '(i1 + i2 + i3) .* i4';

  matlabbatch{1}.spm.util.imcalc.options.dmtx   = 0;
  matlabbatch{1}.spm.util.imcalc.options.mask   = 0;
  matlabbatch{1}.spm.util.imcalc.options.interp = 1;
  matlabbatch{1}.spm.util.imcalc.options.dtype  = 4;
  
  if sdata.save_mlb == 1
    save(fullfile("job_files", ["strip_", sdata.ses ,".mat"]), "matlabbatch");
  endif
  
  % run batch
  spm_jobman("run", matlabbatch)

endfunction