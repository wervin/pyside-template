#!/bin/bash

echo Removing build...
rm -rf build
echo Removing dist...
rm -rf dist

source .env/bin/activate

echo Building application...

pyside6-rcc -o demo/demo_core/__resources__.py demo/resources.qrc
export PYTHONOPTIMIZE=1
pyinstaller --distpath dist --workpath build --noconfirm demo.spec

echo Successfully built application