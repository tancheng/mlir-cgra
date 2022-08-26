# DATE-2022 Tutorial M04.4 - SODA-OPT

Part of SODA toturial in the DATE2022 conference: 

https://www.date-conference.com/tutorial/m04


* Presentation date: March 21, 2022
* Time: 3:15pm - 4:00pm (CET)

In this section you will learn how to use our compiler frontend to perform hardware software partitioning of high-level applications and automatic optimization of selected kernels.

# Instructions for docker users

Download this project on a machine capable of running docker containers

```
git clone https://gitlab.pnnl.gov/sodalite/soda-opt
```

Navigate to the turorial folder

```
cd soda-opt/docs/tutorials/date2022/docker-version
```

Create a python environment with needed dependencies

```
# Option 1 - using virtualenv
#    with virtualenv, vscode current_project_root_folder must contain the .venv_date2022 folder
virtualenv .venv_date2022
source .venv_date2022/bin/activate
pip install tensorflow pandas lxml

# Option 2 - using conda
conda create --name date2022 tensorflow-cpu pandas lxml
conda activate date2022
```

Enter the DATE tutorial directory with vscode or another tool capable of rendering jupyter notebooks

```
vscode soda-opt/docs/tutorials/date2022/docker-version
# Open this folder with vscode
```

Open the tutorial file `tutorial.ipynb`

# Instructions for users without docker access

Please follow the tutorial using the files and folders available [here](docs/tutorials/date2022/docker-version-executed).
