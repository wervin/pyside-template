#!/bin/bash

source <(grep = config.ini)
echo Configuring $APP_NAME v$APP_VERSION_MAJOR.$APP_VERSION_MINOR.$APP_VERSION_REVISION by $APP_AUTHOR

# Configuring info.json
cp demo/info.json.in demo/info.json
sed -i "s/@APP_NAME@/${APP_NAME}/g" demo/info.json
sed -i "s/@APP_AUTHOR@/${APP_AUTHOR}/g" demo/info.json
sed -i "s/@APP_VERSION_MAJOR@/${APP_VERSION_MAJOR}/g" demo/info.json
sed -i "s/@APP_VERSION_MINOR@/${APP_VERSION_MINOR}/g" demo/info.json
sed -i "s/@APP_VERSION_REVISION@/${APP_VERSION_REVISION}/g" demo/info.json

# Configuring demo.spec
cp demo.spec.in demo.spec
sed -i "s/@APP_NAME@/${APP_NAME}/g" demo.spec
sed -i "s/@APP_AUTHOR@/${APP_AUTHOR}/g" demo.spec
sed -i "s/@APP_VERSION_MAJOR@/${APP_VERSION_MAJOR}/g" demo.spec
sed -i "s/@APP_VERSION_MINOR@/${APP_VERSION_MINOR}/g" demo.spec
sed -i "s/@APP_VERSION_REVISION@/${APP_VERSION_REVISION}/g" demo.spec