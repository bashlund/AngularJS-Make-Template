#!/bin/bash
pushd build
py=$(command -v python2 &> /dev/null && which python2 || which python)
$py -m SimpleHTTPServer 8080
popd
