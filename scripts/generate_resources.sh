#!/bin/bash

source .env/bin/activate

echo Generating resources...

pyside6-rcc -o demo/demo_core/__resources__.py demo/resources.qrc

echo Successfully generated resources