#!/bin/sh

ROOT_PATH=~/.config

#unset install
#read -p "Install stuff (y/n)?" choice
#case "$choice" in 
#  y|Y ) continue;;
#  n|N ) install="no";;
#    * ) exit 1;;
#esac

BUILD_DIR=build

rm -fr $BUILD_DIR
mkdir $BUILD_DIR

for dir in *; do
	if [ -f $dir/build.sh ]; then
		echo "Building $dir"
		$dir/build.sh $dir $BUILD_DIR
	fi
done


for file in `find $BUILD_DIR -type f -name '*.symlink'`; do
	NAME=`basename $file .symlink`
	echo "Linking $NAME"
	ln -bf --symbolic $ROOT_PATH/$file ~/$NAME;
done


#echo "Creating links"
# Configure links
#for dir in *; do
#	if [ -f $dir/$dir.symlink ]; then
#		(		
#			set -x #echo on
#			ln -bf --symbolic $ROOT_PATH/$dir/$dir.symlink ~/.$dir;
#		)
#	fi
#done


#if [ -z $install ]
#then
#    (
#	echo "Installing stuff"
#	set -x #echo on
#	sudo apt-get install sl yaml-mode haskell-mode
#    )
#fi


#unset install config_path