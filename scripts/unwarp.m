function matlabbatch = realign_unwarp(sdata)
  spm_jobman('initcfg');
  matlabbatch = {};
  
  %% Load batch for VDM calculation
  matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.data.presubphasemag.phase = ...
    {[sdata.ses_dir, "\\fmap\\", sdata.sub(1:6), '_', sdata.ses, "_phasediff.nii,1"]};
  matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.data.presubphasemag.magnitude = ...
    {[sdata.ses_dir, "\\fmap\\", sdata.sub(1:6), '_', sdata.ses,  "_magnitude1.nii,1"]};
  matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.session.epi = ...
    {[sdata.ses_dir, "\\func\\", sdata.sub(1:6), '_', sdata.ses, "_task-rest_bold.nii,1"]};
  
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
  matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.mflags.template = {fullfile(spm('Dir'), 'toolbox', 'FieldMap', 'T1.nii')};
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
  
  # save batch (adjust bool in full_analysis.m)
  if sdata.save_mlb == true
    save(["job_files\\calcVDM_", sdata.ses ,".mat"], "matlabbatch");
  
  % run batch
  spm_jobman("run", matlabbatch)

  
  matlabbatch = {};
  
  %% Load batch for realignment and VDM unwarp
  matlabbatch{1}.spm.spatial.realignunwarp.data(1).scans = ...
    cellstr(spm_select('ExtFPList',[sdata.ses_dir, "\\func\\"],"^sub.*task-rest.*",Inf));
  
  matlabbatch{1}.spm.spatial.realignunwarp.data(1).pmscan = ...
    cellstr(spm_select('FPList', [sdata.ses_dir, '\\fmap\\'], '^vdm.*nii$'))
  
  % All further parameters are taken directly from original paper of Pritschet (2020):
  % https://github.com/tsantander/PritschetSantander2020_NI_Hormones
  
  matlabbatch{1}.spm.spatial.realignunwarp.eoptions.quality = 1;
  matlabbatch{1}.spm.spatial.realignunwarp.eoptions.sep     = 4;
  matlabbatch{1}.spm.spatial.realignunwarp.eoptions.fwhm    = 5;
  matlabbatch{1}.spm.spatial.realignunwarp.eoptions.rtm     = 0;
  matlabbatch{1}.spm.spatial.realignunwarp.eoptions.einterp = 7;
  matlabbatch{1}.spm.spatial.realignunwarp.eoptions.ewrap   = [0 0 0];
  matlabbatch{1}.spm.spatial.realignunwarp.eoptions.weight  = '';

  matlabbatch{1}.spm.spatial.realignunwarp.uweoptions.basfcn   = [12 12];
  matlabbatch{1}.spm.spatial.realignunwarp.uweoptions.regorder = 1;
  matlabbatch{1}.spm.spatial.realignunwarp.uweoptions.lambda   = 100000;
  matlabbatch{1}.spm.spatial.realignunwarp.uweoptions.jm       = 0;
  matlabbatch{1}.spm.spatial.realignunwarp.uweoptions.fot      = [4 5];
  matlabbatch{1}.spm.spatial.realignunwarp.uweoptions.sot      = [];
  matlabbatch{1}.spm.spatial.realignunwarp.uweoptions.uwfwhm   = 4;
  matlabbatch{1}.spm.spatial.realignunwarp.uweoptions.rem      = 1;
  matlabbatch{1}.spm.spatial.realignunwarp.uweoptions.noi      = 5;
  matlabbatch{1}.spm.spatial.realignunwarp.uweoptions.expround = 'Average';
  
  matlabbatch{1}.spm.spatial.realignunwarp.uwroptions.uwwhich = [2 1];
  matlabbatch{1}.spm.spatial.realignunwarp.uwroptions.rinterp = 7;
  matlabbatch{1}.spm.spatial.realignunwarp.uwroptions.wrap    = [0 0 0];
  matlabbatch{1}.spm.spatial.realignunwarp.uwroptions.mask    = 1;
  matlabbatch{1}.spm.spatial.realignunwarp.uwroptions.prefix  = 'u';

  if sdata.save_mlb == 1
    save(["job_files\\realignunwarp_", sdata.ses ,".mat"], "matlabbatch");
  endif
  
  % run batch
  spm_jobman("run", matlabbatch)

endfunction