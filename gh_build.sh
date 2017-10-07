#!/bin/bash -x

SRC_DIR="."
BUILD_DIR=/tmp/realitycheck-build
REPO=git@github.com:realitykeys/realitycheck.git
ME=`basename "$0"`

if [ ! -f "$SRC_DIR/$ME" ]
then
    echo "Expected files not found in $SRC_DIR"
    exit 1
fi

if [ ! -d $BUILD_DIR ]
then 
    mkdir $BUILD_DIR
    git clone $REPO $BUILD_DIR
    pushd $BUILD_DIR
    git checkout gh-pages
    popd
fi

pushd $BUILD_DIR
git pull
git merge master -m "Update to latest master"
popd
rsync -avz --delete $SRC_DIR/docs/ $BUILD_DIR/docs/
rsync -avz --delete $SRC_DIR/truffle/build/ $BUILD_DIR/truffle/build/

cd $BUILD_DIR
git add .
git commit -m "Update to latest build"
#git push
