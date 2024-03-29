This folder is to store any data that is added to the project manually. For example, if some entities needed to be matched manually to merge two datasets, the information created manually should be stored here, alongside details of how this was done in this `README.md`. 

A `.gitignore` folder is added to prevent files being tracked by Git or uploaded to GitHub. However, details of where the data can be found should be included in this file, as well as code to automatically download the data from a repository. 

Where the main data of a project is created manually (i.e. human coding), the data should be stored in `data_raw`. This repository is intended for small auxillary data which may need to be used in a project but doesn't fit into `data_raw` or `data_processed`.
