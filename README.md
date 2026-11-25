<h1 align="center">FSL Probabilistic Tractography Algorithm</h1>

<p align="center">
  Runs FSL probtrackx2 (GPU) surface-seeded probabilistic tractography from BedpostX samples, with avoid, target and termination masks, for one hemisphere.
</p>

<p align="center">
  <a href="https://github.com/brainlife/abcd-spec"><img src="https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg" alt="ABCD Spec v1.1"></a>
  <a href="https://doi.org/10.25663/brainlife.app.863"><img src="https://img.shields.io/badge/Brainlife-brainlife.app.863-blue.svg" alt="Run on brainlife.io"></a>
</p>

## At a glance

<!-- brainlife-app:begin (generated from the App manifest; edit the manifest, not this block) -->

> **Runs FSL probtrackx2 (GPU) surface-seeded probabilistic tractography from BedpostX samples, with avoid, target and termination masks, for one hemisphere.**

Wraps probtrackx2_gpu with fixed settings (50000 samples, 3200 steps, 0.3125 mm step, loop check, modified Euler, caret mesh space) and outputs streamline density and seed-to-target counts. Seeds come from a GIFTI surface for the chosen hemisphere, with the FA map as seed reference. Used for surface-based tractography of prefrontal pathways (Bedini et al., 2026). Needs BedpostX output and all masks in diffusion space.

| | |
|---|---|
| **Inputs** | `neuro/FSLBedpostX` · `neuro/mask` ×2 · `neuro/surface/data` ×3 · `neuro/tensor` |
| **Outputs** | `raw` |
| **Container** | `brainlife/fsl:6.0.1` |
| **Resources** | 2 CPUs · 3.5 h walltime |
| **Run it** | [doi.org/10.25663/brainlife.app.863](https://doi.org/10.25663/brainlife.app.863) |

#### Inputs

| Input | Datatype | Required | Description |
|---|---|---|---|
| `bedpostx` | `neuro/FSLBedpostX` | yes | FSL BedpostX output (merged samples). |
| `brain_mask` | `neuro/mask` | yes | Brain mask in diffusion space. |
| `seed_surface` | `neuro/surface/data` | yes | Seed surfaces (GIFTI) for the left and right hemispheres. |
| `seed_reference` | `neuro/tensor` | yes | Tensor maps; FA is used as the seed reference image. |
| `mask_avoid` | `neuro/mask` | yes | Exclusion (avoid) mask. |
| `mask_target` | `neuro/surface/data` | yes | Target masks list for seed-to-target counts. |
| `mask_termination` | `neuro/surface/data` | yes | Termination surfaces (e.g. pial) for each hemisphere. |

#### Outputs

| Output | Datatype | Description |
|---|---|---|
| `probtrackx_outputs` | `raw` | probtrackx2 output directory (fdt_paths, waytotal and seed-to-target counts). |

<details>
<summary><b>Parameters</b> (1)</summary>

| Parameter | Type | Default | Description |
|---|---|---|---|
| `hemisphere` | enum |  | Hemisphere to track (selects the left or right seed and termination files). Options: `1`, `2`. |

</details>

<!-- brainlife-app:end -->

## Running the App

### On brainlife.io

Open the App at [doi.org/10.25663/brainlife.app.863](https://doi.org/10.25663/brainlife.app.863), choose `neuro/FSLBedpostX`, `neuro/mask`, `neuro/surface/data`, `neuro/tensor`, `neuro/mask`, `neuro/surface/data`, `neuro/surface/data` from your project, set the parameters and press **Execute**. The results are saved to your project as `raw`.

### Locally

You need [Singularity/Apptainer](https://apptainer.org/) (the App runs in `brainlife/fsl:6.0.1`), [`jq`](https://jqlang.github.io/jq/).

1. Clone this repository.
2. Create `config.json` with the paths to your inputs and the parameters:

   ```json
   {
       "bedpostx": "/path/to/bedpostx/bedpostx",
       "brain_mask": "/path/to/brain_mask/brain_mask",
       "seed_surface_left": "/path/to/seed_surface/seed_surface_left",
       "seed_surface_right": "/path/to/seed_surface/seed_surface_right",
       "fa": "/path/to/seed_reference/fa",
       "md": "/path/to/seed_reference/md",
       "rd": "/path/to/seed_reference/rd",
       "ad": "/path/to/seed_reference/ad",
       "cl": "/path/to/seed_reference/cl",
       "cp": "/path/to/seed_reference/cp",
       "cs": "/path/to/seed_reference/cs",
       "tensors": "/path/to/seed_reference/tensors",
       "kurtosis": "/path/to/seed_reference/kurtosis",
       "ga": "/path/to/seed_reference/ga",
       "mk": "/path/to/seed_reference/mk",
       "ak": "/path/to/seed_reference/ak",
       "rk": "/path/to/seed_reference/rk",
       "rgb": "/path/to/seed_reference/rgb",
       "mask_avoid": "/path/to/mask_avoid/mask_avoid",
       "left": "/path/to/mask_target/left",
       "right": "/path/to/mask_target/right",
       "mask_termination_left": "/path/to/mask_termination/mask_termination_left",
       "mask_terminationright": "/path/to/mask_termination/mask_terminationright",
       "hemisphere": ""
   }
   ```

3. Run `./main`.

## Citing

If you use this App, please cite it, the software it builds on and brainlife.io:

- FSL Probabilistic Tractography Algorithm. brainlife.io App. [doi:10.25663/brainlife.app.863](https://doi.org/10.25663/brainlife.app.863)
- Bedini M, Olivetti E, Avesani P, Baldauf D. Surface-based Tractography uncovers 'What' and 'Where' Pathways in Prefrontal Cortex. Cortex (2026). [doi:10.1016/j.cortex.2026.03.016](https://doi.org/10.1016/j.cortex.2026.03.016)
- Behrens TEJ, Berg HJ, Jbabdi S, Rushworth MFS, Woolrich MW. Probabilistic diffusion tractography with multiple fibre orientations: What can we gain? NeuroImage 34(1):144-155 (2007). [doi:10.1016/j.neuroimage.2006.09.018](https://doi.org/10.1016/j.neuroimage.2006.09.018)
- Jenkinson et al. FSL. *NeuroImage* 62:782-790 (2012). [doi:10.1016/j.neuroimage.2011.09.015](https://doi.org/10.1016/j.neuroimage.2011.09.015)
- Hayashi S, Caron BA, Heinsfeld AS, et al. brainlife.io: a decentralized and open-source cloud platform to support neuroscience research. *Nature Methods* 21:809–813 (2024). [doi:10.1038/s41592-024-02237-2](https://doi.org/10.1038/s41592-024-02237-2)
- Avesani P, McPherson B, Hayashi S, et al. The open diffusion data derivatives, brain data upcycling via integrated publishing of derivatives and reproducible open cloud services. *Scientific Data* 6:69 (2019). [doi:10.1038/s41597-019-0073-y](https://doi.org/10.1038/s41597-019-0073-y)

## Authors

Maintained by [@mbedini](https://github.com/mbedini).
