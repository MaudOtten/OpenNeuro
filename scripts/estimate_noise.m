function matlabbatch = estimate_noise(sdata)
  spm_jobman('initcfg');
  matlabbatch = {};

  anat_fp = [sdata.ses_dir, '/anat']
  
  wm_seg = spm_select('FPList', anat_fp, '^c2s.*nii$');
  csf_seg = spm_select('FPList', anat_fp, '^c3s.*nii$');
  
  cd(anat_fp);
  
  matlabbatch{1}.spm.util.imcalc.input = cellstr([wm_seg; csf_seg]);
  matlabbatch{1}.spm.util.imcalc.output = 'noisemask.nii';
  matlabbatch{1}.spm.util.imcalc.expression = '(i1 > 0.99) | (i2 > 0.99)';

  matlabbatch{1}.spm.util.imcalc.options.dmtx   = 0;
  matlabbatch{1}.spm.util.imcalc.options.mask   = 0;
  matlabbatch{1}.spm.util.imcalc.options.interp = 0;
  matlabbatch{1}.spm.util.imcalc.options.dtype  = 4;
  
  spm_jobman('run',matlabbatch);

  
  
  meanEPI       = spm_vol(['../data.functional.mean/' spm_select('FPList', '../data.functional.mean', '^meanuf.*nii$')]);
  noiseMask     = spm_vol([pwd '/noisemask.nii']);
  resliceParams = struct('mean', false, 'interp', 0, 'which', 1, 'prefix', 'r');
  spm_reslice([meanEPI noiseMask], resliceParams);

  cd('../data.functional.rest');

  rest4D = load_nii([pwd '/ufrest4D.nii.gz']);
  mask3D = load_nii('../data.anatomical.mask/rnoisemask.nii');

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