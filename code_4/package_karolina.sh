#!/bin/bash

cd ~/R4HPC/code_4
pwd

## module names can vary on different platforms
module load R
echo "loaded R"

Rscript package_installs.R
