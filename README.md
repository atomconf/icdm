# Accurate PARAFAC2 Decomposition for Temporal Irregular Tensors with Missing Values
This is a code for "Accurate PARAFAC2 Decomposition for Temporal Irregular Tensors with Missing Values", submitted to ICDM 2022.
Authors: anonymous authors
Version: 1.0

## Code Information
All codes are written by MATLAB R2020b.
This repository contains the code for ATOM, an accurate method for PARAFAC2 decomposition on irregular tensors with missing values.
Given an irregular tensor with missing values, ATOM accurately finds latent factors by decomposition.

- The code of ATOM is in `src` directory.

## Library
We need the following library to run our proposed method.
Please refer to the following, too.
 - `Tensor Toolbox v3.0`
 > * Reference: B. W. Bader, T. G. Kolda et al., “Matlab tensor toolbox version 3.0-dev,” Available online, Oct. 2017. [Online]. Available: <https://www.tensortoolbox.org>

After you download `Tensor Toolbox v3.0`, you should put the directory of `Tensor Toolbox v3.0` in `library` directory.
Without the Tensor Toolbox library, ATOM is not run.

## Demo
We provide demo scripts for ATOM on a synthetic tensor and real-world tensors.

### Run for synthetic data
We provide a demo script for generating synthetic tensor data and running ATOM.
First, you run MATLAB, and type the following commands in MATLAB.

Before you run our proposed method, you should add paths into MATLAB environment. Please type the following command in MATLAB:
    `addPaths`

Or, you manually add paths for `src` and `library` directories.

Then, type the following command to run the demo for the synthetic data:
    ```
    run demo_synthetic.m
    ```
### Run for real-world data
Among real-world datasets used in our paper, we provide demo scripts for two datasets, Japan Stock and ML-100k datasets.

You run MATLAB, and type the following commands in MATLAB.

Before you run our proposed method, you should add paths into MATLAB environment. Please type the following command in MATLAB:
    `addPaths`

If you run a demo script for Japan Stock data, you first download Japan Stock from the following [link](https://drive.google.com/file/d/1whN5pZvo4ybVNHvg1z3rfsOO-QjF_WMk/view?usp=sharing)
After download, you extract the zip file, and move .mat files to `data` directory.
We provide a demo script to run our method ATOM for Japan Stock dataset.
Then, type the following command to run the demo:
    `run demo_real_dense.m`

We provide a demo script to run our method ATOM for ML-100k dataset.
Then, type the following command to run the demo:
    `run demo_real_sparse.m`

If data cannot be loaded, check the path and change the path in lines 7 and 11 of the code `demo_real_dense.m` and lines 8 and 15 of the code `demo_real_sparse.m`, respectively.
