# ISC-2022 Tutorial - SODA-OPT

Part of the *Modern High-Level Synthesis for Complex Data Science Applications* toturial in the ISC2022 conference: 

* [Tutorial website](https://app.swapcard.com/widget/event/isc-high-performance-2022/planning/UGxhbm5pbmdfODYxMTU1)


* Presentation date: Sunday, May 29, 2022 
* Time: 3:00 PM to 3:45 PM (CEST)

In this section you will learn how to use our compiler frontend to perform hardware software partitioning of high-level applications and automatic optimization of selected kernels.

# Instructions for docker users

Download this project on a machine **capable of running docker containers**

```
git clone https://gitlab.pnnl.gov/sodalite/soda-opt
```

Navigate to the turorial folder

```
cd soda-opt/docs/tutorials/isc2022/docker-version
```

Create a python environment with needed dependencies

```
# Option 1 - using virtualenv
#    with virtualenv, vscode current_project_root_folder must contain the .venv_isc2022 folder
virtualenv .venv_isc2022
source .venv_isc2022/bin/activate
pip install tensorflow-cpu pandas lxml

# Option 2 - using conda
conda create --name isc2022 tensorflow-cpu pandas lxml
conda activate isc2022
```

Enter the ISC tutorial directory with vscode or another tool capable of rendering jupyter notebooks.

```
vscode soda-opt/docs/tutorials/isc2022/docker-version
# Open this folder with vscode
```

Open the tutorial file `tutorial.ipynb` and select the correct virtual env.
If required, grant permissions for vscode to install any missing dependencies.

# Instructions for users without docker access

Please follow the tutorial using the files and folders available [here](docs/tutorials/isc2022/docker-version-executed).
