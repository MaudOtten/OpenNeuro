function sdata = estimate_noise(sdata)
  spm_jobman('initcfg');
  matlabbatch = {};

  sdata.func_fp = fullfile(sdata.ses_dir, 'func');
  
  wm_seg = spm_select('FPList', sdata.anat_fp, '^c2s.*nii$');
  csf_seg = spm_select('FPList', sdata.anat_fp, '^c3s.*nii$');
  
  cd(sdata.anat_fp);
  
  matlabbatch{1}.spm.util.imcalc.input = cellstr([wm_seg; csf_seg]);
  matlabbatch{1}.spm.util.imcalc.output = 'noisemask.nii';
  matlabbatch{1}.spm.util.imcalc.expression = '(i1 > 0.99) | (i2 > 0.99)';

  matlabbatch{1}.spm.util.imcalc.options.dmtx   = 0;
  matlabbatch{1}.spm.util.imcalc.options.mask   = 0;
  matlabbatch{1}.spm.util.imcalc.options.interp = 0;
  matlabbatch{1}.spm.util.imcalc.options.dtype  = 4;
  
  if sdata.save_mlb == true
    save(fullfile(sdata.root_dir, "scripts", "job_files", ["estimatenoise_", sdata.ses ,".mat"]), "matlabbatch");
  endif
  
  if sdata.run == true
    spm_jobman('run',matlabbatch);
  endif

  clear matlabbatch
  
  meanEPI = spm_vol(fullfile(sdata.func_fp, spm_select('List', sdata.func_fp, '^meanu.*nii$')));
  noiseMask = spm_vol(fullfile(sdata.anat_fp, 'noisemask.nii'));
  resliceParams = struct('mean', false, 'interp', 0, 'which', 1, 'prefix', 'r');
  spm_reslice([meanEPI noiseMask], resliceParams);

  cd(sdata.func_fp);

  rest4D = load_untouch_nii(spm_select('FPList', sdata.func_fp, '^u.*nii$'));
  mask3D = load_untouch_nii(fullfile(sdata.anat_fp, 'rnoisemask.nii'));

  [x,y,z,t] = size(rest4D.img);
  rest2D    = reshape(rest4D.img, x*y*z, t);
  rest2D    = double(rest2D)';

  mask2D    = reshape(mask3D.img, 1, numel(mask3D.img));

  clear rest4D mask3D

  disp('|| Extracting first 5 principal components from noise mask');

  noiseData = rest2D(:, logical(mask2D));
  zNoise    = zscore(noiseData); 
  [u,~,~]   = svd(zNoise*zNoise');
  anatNoise = u(:,1:5);

  disp('|| Finished component extraction. Saving...');

  save anatNoise anatNoise
  
  cd(fullfile(root_dir, 'scripts'))
endfunction