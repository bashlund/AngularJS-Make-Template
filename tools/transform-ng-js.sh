#/bin/bash
# Author Thomas Backlund

# Run this from project root as ./tools/transform-ng-js ng/dir1/dir2/a.js
#
# This tool parses the given JS script and does some search and replace.
# $(DIR) is substituted for the relative directory of where the JS file
# is located.

read -rd '' TPL1 << EOF
(function() {\n
"use strict";
EOF
read -rd '' TPL2 << EOF
})();
EOF

# Given as the first argument, it is relative to the project root
filepath=$1

# Remove prefixing "ng/" from filepath to make the DIR
# and escape slashes (for later)
DIR=$(dirname $filepath | sed 's/\//\\\//g' | sed 's/^ng\\\///')

# Substitute and output result on stdout
echo -e $TPL1
cat $filepath | sed 's/\$(DIR)/'"$DIR"'/g'
echo -e $TPL2
