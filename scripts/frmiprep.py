# run bash install for freesurfer first (from $HOME on wsl Ubuntu-20.04)
# export FREESURFER_HOME=$HOME/freesurfer
# export SUBJECTS_DIR=$FREESURFER_HOME/subjects
# source $FREESURFER_HOME/SetUpFreeSurfer.sh

import subprocess

check_fs = subprocess.run("which freeview", capture_output=True, shell=True)
assert check_fs.returncode == 0



