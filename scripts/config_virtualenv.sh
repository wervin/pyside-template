#!/bin/bash

echo Removing .env
rm -rf .env
echo Python version: `python3 --version`
echo Initializing .env
python3 -m venv .env
echo Activate .env
source .env/bin/activate
pip install -r requirements.txt
echo Successfully initalized .env