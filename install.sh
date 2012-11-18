#!/bin/bash

## install script. run once only. ##

echo "#### bbkinstall: added by bk ####"

# add bbk function that handles all your bookmarks!

cat <<HEREDOC >> bashrc
function bbk {
	cd ${bbk[$1]}
}
HEREDOC



