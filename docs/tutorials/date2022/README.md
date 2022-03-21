# DATE-2022 Tutorial M04.4 - SODA-OPT

Part of SODA toturial in the DATE2022 conference: 

https://www.date-conference.com/tutorial/m04

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
virtualenv venv
source venv/bin/activate
pip install -r requirements.txt
```

Enter the DATE tutorial directory with vscode or another tool capable of rendering jupyter notebooks

```
vscode soda-opt/docs/tutorials/date2022/docker-version
# Open this folder with vscode
```

Open the tutorial file `tutorial.ipynb`
