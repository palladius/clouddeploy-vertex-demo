#!/bin/bash

# to update old version: conda update -n base conda

echo "Activating 🐍 Conda.."

conda create -n vsc python=3.8 jupyter notebook
conda activate vsc

#  pip3 install ipykernel ?!?
pip3 install -r requirements.txt
