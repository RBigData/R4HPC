#!/bin/bash

cd ~/R4HPC/code_0
pwd

## module names can vary on different platforms
module load R
echo "loaded R"

Rscript package_installs.R
