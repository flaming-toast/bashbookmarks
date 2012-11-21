#### bbkinstall: added by bk ####
function bbk {

if [[ $1 == 'add' ]] ; then 
	if [[ $# -lt 3 ]] ; then
		echo "Not enough arguments"
		echo "Usage: bbk [add|install|remove|list|bookmark] [name] [directory]"
		return
	else 
		if ls -d $3 &> /dev/null ; then
			if grep -q ^$2 ~/.bookmarks 2>/dev/null ; then
				echo "Bookmark already exists! Use another name."
				return
			fi	       
			echo $2:$3 >> ~/.bookmarks	
			echo "bbk['$2']='$3'" >> ~/.bashrc
			. ~/.bashrc
			echo "Bookmark added and installed."
			return
		else 
			echo "Invalid directory provided."
			echo "Usage: bbk [add|remove|list] [name] [directory]"
			return
		fi
	fi

fi

if [[ $1 == 'list' ]] ; then 
	sed 's/:/ -> /' ~/.bookmarks
	return
fi
. ~/.bashrc
echo ${bbk[$1]}	
cd ${bbk[$1]}	

}
typeset -A bbk
