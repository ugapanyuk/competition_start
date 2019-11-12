#!/bin/bash

# ++++++++++++++++++++++++++++++++++++++++++++
# $1 - root path
# $2 - project folder name
# $3 - hithub repo name
# $4 - path to github ssh key
#
# run example:
# bash newproj.sh /home/osboxes/repos/sport competitions_sendy git@github.com:ugapanyuk/competitions_sendy.git ~/.ssh/github__id_rsa_private.txt
#
# !!! git@github.com - is required for using with ssh key 
# ++++++++++++++++++++++++++++++++++++++++++++

cd $1

export FOLDER=$2
export LC_ALL=en_US.UTF-8

# create folder and content
rm -rf $FOLDER
mkdir $FOLDER
cd $FOLDER
mkdir -p {data/{external,processed,raw},models,notebooks,reports/figures,scripts,submissions}
touch {models,notebooks,reports/figures,scripts,submissions}/.gitkeep
touch README.md requirements.txt
wget https://raw.githubusercontent.com/drivendata/cookiecutter-data-science/master/%7B%7B%20cookiecutter.repo_name%20%7D%7D/.gitignore -nv
# pip freeze > requirements.txt
# conda env export > conda.yaml
# pipreqs .
# cp Quickstart.ipynb $FOLDER ???
tree .

git config --global user.email "Gapanyuk.Yury@yandex.ru"
git config --global user.name "ugapanyuk"

#Start the ssh-agent in the background an add key
eval "$(ssh-agent -s)"
ssh-add $4

# initialise repository
# git lfs usage is recommended https://git-lfs.github.com
git init
#git branch -u origin/master
git status

git lfs install
git lfs track "*.csv"
git lfs track "*.csv.gz"
git add .gitignore .gitattributes
git add --force .

git status

git commit -m "create repository"

git remote add origin $3
git push -u origin master

