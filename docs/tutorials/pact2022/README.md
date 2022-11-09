# PACT-2022 Tutorial - SODA-OPT

Part of the *SODA Synthesizer: Accelerating Data Science Applications with an end-to-end Silicon Compiler* toturial in the PACT2022 conference: 

* [Tutorial website](https://pact22.cs.illinois.edu/tutorials.html#tut1-1)


* Presentation date: Sunday, Oct 09, 2022 
* Time: 9:00 AM to 5:45 PM (CDT)

In this section you will learn how to use our compiler frontend to perform hardware software partitioning of high-level applications and automatic optimization of selected kernels.

# Instructions for docker users

Download this project on a machine **capable of running docker containers**

```
git clone https://gitlab.pnnl.gov/sodalite/soda-opt
```

Navigate to the turorial folder

```
cd soda-opt/docs/tutorials/pact2022/docker-version
```

Update/download the `soda` docker image

```
docker pull agostini01/soda
```

Create a python environment with needed dependencies

```
# Option 1 - using virtualenv
#    with virtualenv, vscode current_project_root_folder must contain the .venv_pact2022 folder
virtualenv .venv_pact2022
source .venv_pact2022/bin/activate
pip install tensorflow pandas lxml

# Option 2 - using conda
conda create --name pact2022 tensorflow-cpu pandas lxml
conda activate pact2022
```

Enter the PACT tutorial directory with vscode or another tool capable of rendering jupyter notebooks.

```
vscode soda-opt/docs/tutorials/pact2022/docker-version
# Open this folder with vscode
```

Open the tutorial file `tutorial.ipynb` and select the correct virtual env.
If required, **grant permissions for vscode to install any missing dependencies**.

# Instructions for users without docker access

Please follow the tutorial using the files and folders available [here](docs/tutorials/pact2022/docker-version-executed).
