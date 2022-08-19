

remotes::install_github("RBigData/pbdSLAP")
remotes::install_github("RBigData/pbdBASE")
remotes::install_github("RBigData/pbdDMAT")
remotes::install_github("RBigData/pbdML")

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("rhdf5")
