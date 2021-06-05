function matlabbatch = load_batch(bnr, sdata)
  
  %% Load batch for VDM calculation  
  if bnr == 1
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.data.presubphasemag.phase = ...
      {[sdata.ses_dir, "/fmap/", sdata.sub(1:6), '_', sdata.ses, "_phasediff.nii,1"]};
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.data.presubphasemag.magnitude = ...
      {[sdata.ses_dir, "/fmap/", sdata.sub(1:6), '_', sdata.ses,  "_magnitude1.nii,1"]};
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.session.epi = ...
      {[sdata.ses_dir, "/func/", sdata.sub(1:6), '_', sdata.ses, "_task-rest_bold.nii,1"]};
    
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.et = [4.92 7.38];
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.maskbrain = 1;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.blipdir = 1;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.tert = 0.0597409;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.epifm = 0;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.ajm = 0;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.uflags.method = 'Mark3D';
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.uflags.fwhm = 10;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.uflags.pad = 0;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.uflags.ws = 1;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.mflags.template = {'C:\Users\maudo\Documents\Projects\OpenNeuro\spm12-r7771\toolbox\FieldMap\T1.nii'};
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.mflags.fwhm = 5;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.mflags.nerode = 2;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.mflags.ndilate = 4;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.mflags.thresh = 0.5;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.mflags.reg = 0.02;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.matchvdm = 1;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.sessname = 'VDM';
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.writeunwarped = 0;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.anat = '';
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.matchanat = 0;
  
  
  %% Load batch for VDM application
  elseif bnr == 2
    matlabbatch{1}.spm.tools.fieldmap.applyvdm.data.scans = ...
      cellstr(spm_select('ExtFPList',[sdata.ses_dir, "/func/"],"^sub.*task-rest.*",Inf));
    
    matlabbatch{1}.spm.tools.fieldmap.applyvdm.data.vdmfile = ...
      {[sdata.ses_dir, '\fmap\vdm5_sc', sdata.sub(1:6), '_', sdata.ses, '_phasediff.nii,1']};
    
    matlabbatch{1}.spm.tools.fieldmap.applyvdm.roptions.pedir = 2;
    matlabbatch{1}.spm.tools.fieldmap.applyvdm.roptions.which = [2 1];
    matlabbatch{1}.spm.tools.fieldmap.applyvdm.roptions.rinterp = 4;
    matlabbatch{1}.spm.tools.fieldmap.applyvdm.roptions.wrap = [0 0 0];
    matlabbatch{1}.spm.tools.fieldmap.applyvdm.roptions.mask = 1;
    matlabbatch{1}.spm.tools.fieldmap.applyvdm.roptions.prefix = 'u';
  endif
  
endfunction