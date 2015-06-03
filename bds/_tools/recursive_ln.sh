#!/bin/bash

if [ "$#" -lt 2 ]
then
  echo "Usage: recursive_ln.sh [SOURCE_DIR] [DEST_DIR]"
  exit 1
fi

SRC=$1
DEST=$2

if [ ! -d $SRC ]
then
  echo "Source directory ($SRC) doesn't exist!"
  exit 2
fi

if [ ! -d $DEST ]
then
  echo "Destination directory ($DEST) doesn't exist!"
  exit 3
fi

cd $SRC

for f in $(find . -type f )
do
  BASENAME=$(basename $f)
  DIRNAME=$(dirname $f)
  mkdir -p "$DEST/$DIRNAME"

  FULLPATH=$(readlink -f $f)
  TARGET="$DEST/$DIRNAME/$BASENAME"
  ln -s $FULLPATH $TARGET
done

