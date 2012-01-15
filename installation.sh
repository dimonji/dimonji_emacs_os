#!/bin/bash
echo "Install autocomplete"
cd ./dist/auto-complete
make install DIR=$HOME/.emacs.d/plugins/autocomplete