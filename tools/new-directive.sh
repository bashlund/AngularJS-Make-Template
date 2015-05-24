#/bin/bash
# Author Thomas Backlund

# This script adds a new directive to the ng/ tree
# Usage ./new-directive.sh path name
# where path is relative to ./ng
# and name is the name of the directive as myName

templates=./tools/templates

if [ "$1" = "" ] || [ "$2" = "" ] || [ "$3" = "" ]; then
    echo "Usage $0 ModuleName pathRelative to ./ng directiveName"
    echo "Exampel: $0 BuildModule /build/mind mindDirective"
    exit 1
fi

modulename=$1
path="./ng"$2
name=$3

if [ ! -d $path ]; then
    echo "Directory $path does not exist, attempting to create it."
    mkdir -p $path
fi

path=$path/$name

if [ -d $path ]; then
    echo "Error: Directory $path already exists"
    exit 1
fi

mkdir $path
cat $templates/directive/directive.js | sed "s/directiveName/$name/g" | sed "s/ModuleName/$modulename/g" > $path/$name.js
cat $templates/directive/controller.js | sed "s/directiveName/$name/g" | sed "s/ModuleName/$modulename/g" > $path/${name}Controller.js
cat $templates/directive/directive.html > $path/$name.html
cat $templates/directive/directive.less > $path/$name.less
echo Done
