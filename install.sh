#!/bin/bash

## install script. run once only. ##


# add bbk function that handles all your bookmarks!

cat <<HEREDOC >> ~/.bashrc
#### bbkinstall: added by bk ####
function bbk {
	cd \${bbk[\$1]}
}
HEREDOC

echo "Installation finished."
