#! /bin/bash

############# INPUT PARSING
samples_dir=$1 #3T_bedpostx_hcp/Unpaired_twins/"$i"_bedpostx/merged
mask_brain_dwi=$2 #3T_bedpostx_hcp/Unpaired_twins/"$i"_bedpostx/nodif_brain.nii.gz
seed_surface=$3 #Seeds_white_surface/"$i"_lFEF_peak_white_2.5_sphere.gii
seed_reference=$4 #Reference_images/"$i"_dti_FA.nii.gz
mask_avoid=$5 #Termination_masks/CC-CSF-Ventricles-Cerebellum/"$i"_cc_csf_ventricles_cerebellum_lh.nii.gz
mask_target=$6 #Targets_lists_clic_confirmatory/"$i"_targets_list_lh.txt
mask_termination=$7 #Termination_masks/Pial/"$i"_lh.pial_DWI_space.gii
ouputdir=$8 #probtrackx_outputs/Unpaired_twins/"$i"_probtrackx_lFEF
meshspace=caret
nstreamlines=50000
max_steps=3200
steplength=0.3125

############# MAIN
probtrackx2_gpu		--samples=${samples_dir} \
			--mask=${mask_brain_dwi} \
			--seed=${seed_surface} \
			--seedref=${seed_reference} \
			--avoid=${mask_avoid} \
			--targetmasks=${mask_target} \
			--stop=${mask_termination}  \
			--dir=${ouputdir}   \
			--meshspace=${meshspace} \
			--nsamples=${nstreamlines} \
			--nsteps=${max_steps} \
			--steplength=${steplength} \
			--loopcheck \
			--forcedir --opd --os2t --s2tastext \
			--verbose=2 \
			--modeuler;
