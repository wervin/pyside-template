#!/bin/bash

source .env/bin/activate

echo Generating resources...

cd demo
pyside6-rcc -o demo_core/__resources__.py resources.qrc

echo Launch application...
python -O main.py