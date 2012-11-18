#!/bin/bash

# simple shell script that manages bookmarks to your directories


if [[ $1 == 'add' ]] ; then
	if $(shopt -u | grep -q autocd) ; then 
		echo "Run shopt and enable autocd option in bash before running bbk."
		exit 1
	fi

	if $(grep -q "bbkinstall" $HOME/.bashrc) ; then 
		echo "Please run the install script first before adding bookmarks with bbk."
		exit 1
	fi

	if [[ $# -lt 3 ]] ; then
		echo "Not enough arguments"
		echo "Usage: bbk [add|install|remove|list|bookmark] [name] [directory]"
	else 
		if [[ $1 == 'add' ]] ; then
			if $(ls -d $3 &> /dev/null) ; then
				if grep -q ^$2 bookmarks ; then
					echo "Bookmark already exists! Use another name."
					exit 1
				fi	       
				echo $2:$3 >> bookmarks	
				echo "bbk[$2]=$3" >> $HOME/.bashrc
				echo "Bookmark added and installed."
				. .bashrc
			else 
				echo "Invalid directory provided."
				echo "Usage: bbk [add|remove|list] [name] [directory]"
			fi
		fi

	fi

fi

if [[ $1 == 'list' ]] ; then 
	sed 's/:/ -> /' bookmarks
fi

if [[ $1 == 'remove' ]] ; then
	if [[ $# -lt 2 ]] ; then
		echo "Not enough arguments"
		echo "Usage: bbk remove [name]"
	else 
		if [[ $1 == 'remove' ]] ; then 
			if grep -q "^$2:" bookmarks ; then
				NEW=$(sed "/^$2:/d" bookmarks | awk 'NR > 1 { print h } { h = $0 } END { ORS = ""; print h }')
				echo -n $NEW > bookmarks
				echo "Bookmarked removed."
			else 
				echo "Bookmark does not exist."
			fi
		fi
	fi
fi

if [[ $1 == 'removeall' ]] ; then
	echo -n > bookmarks
fi

if $(grep -q "^$1:" bookmarks) ; then
	GOTO=$(grep "^$1:" bookmarks | cut -d ":" -f2)
	echo $GOTO
fi
       	
