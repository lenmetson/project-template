# LOAD PACKAGES # 

# This script will download any packages that are missing from the machine being used then load all packages 

need <- c("here", # useful for setting relative paths which translate across machines
          "tidyverse", 
          "osfr") # for downloading data from osf
          
have <- need %in% rownames(installed.packages()) # checks packages you have

if(any(!have)) install.packages(need[!have]) # install missing packages

invisible(lapply(need, library, character.only=T)) # load needed packages

rm(have, need) # remove objects

# OBTAIN DATA # 

# Example for downloading data from OSF - [NOTE TO SELF: check if works]
osf_download(
  x,
  path = here("data", "data_raw"),
  recurse = FALSE,
  conflicts = "error",
  verbose = FALSE,
  progress = FALSE
)
