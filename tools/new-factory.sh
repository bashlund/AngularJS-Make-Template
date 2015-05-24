#/bin/bash
# Author Thomas Backlund

# This script adds a new factoryo the ng/ tree

templates=./tools/templates

if [ "$1" = "" ] || [ "$2" = "" ] || [ "$3" = "" ]; then
    echo "Usage $0 ModuleName pathRelative to ./ng controllerName"
    echo "Exampel: $0 BuildModule /build/mind mindFactory"
    exit 1
fi

modulename=$1
path="./ng"$2
name=$3

if [ ! -d $path ]; then
    echo "Directory $path does not exist, attempting to create it."
    mkdir -p $path
fi

cat $templates/factory/factory.js | sed "s/factoryName/$name/g" | sed "s/ModuleName/$modulename/g" > $path/${name}.js
echo Done
