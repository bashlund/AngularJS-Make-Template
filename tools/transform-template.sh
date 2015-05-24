#/bin/bash
# Author Thomas Backlund
#
# Run this from project root as ./tools/transform-template.sh ng/dir1/dir2/a.tpl.html
#
# This tool transforms the given HTML template into a escaped version that is
# put into cache as: $templateCache.put(ID, CONTENT),
# where ID is identical to the filepath of the template but excluding the prefixing "ng/",
# and content is the escaped HTML template.

read -rd '' TPL1 << EOF
(function() {\n
"use strict";\n
angular.module('TemplateCache').run(function(\$templateCache) {\n
    \$templateCache.put("_ID_", "" +
EOF
read -rd '' TPL2 << EOF
    "");\n
});\n
})();
EOF

# Given as the first argument, it is relative to the project root and must start with "ng/"
filepath=$1

# Remove prefixing "ng/" from filepath to make the ID
# and escape slashes (for later)
ID=$(echo $filepath | sed 's/\//\\\//g' | sed 's/^ng\\\///')

echo -e $TPL1 | sed 's/_ID_/'"${ID}"'/'
cat $filepath | sed 's/\"/\\"/g' | sed 's/^/"/g' | sed 's/$/" +/g'
echo -e $TPL2
