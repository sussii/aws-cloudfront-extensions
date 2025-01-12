#!/bin/bash
# This assumes all of the OS-level configuration has been completed and git repo has already been cloned
#
# This script should be run from the repo's deployment directory
# cd deployment
# ./build-s3-dist.sh
#
# Check to see if input has been provided:
# if [ "$1" ]; then
#     echo "Usage: ./build-s3-dist.sh"
#     exit 1
# fi

set -e

title() {
    echo "------------------------------------------------------------------------------"
    echo $*
    echo "------------------------------------------------------------------------------"
}

run() {
    >&2 echo ::$*
    $*
}


# Get reference for all important folders
template_dir="$PWD"
source_dir="$template_dir/../lambda"
lib_dir="$template_dir/../lambda/lib"
build_dist_dir="$lib_dir/lambda-assets"


# packaging lambda
echo "------------------------------------------------------------------------------"
echo "[Init] Clean existed dist folders"
echo "------------------------------------------------------------------------------"

echo "rm -rf $build_dist_dir"
rm -rf $build_dist_dir
echo "mkdir -p $build_dist_dir"
mkdir -p $build_dist_dir
echo "rm -rf $source_dir/cache_invalidator/lib"
rm -rf $source_dir/cache_invalidator/lib
echo "rm -rf $source_dir/cache_invalidator/package"
rm -rf $source_dir/cache_invalidator/package

echo "find $source_dir -iname \"dist\" -type d -exec rm -r \"{}\" \; 2> /dev/null"
find "$source_dir" -iname "dist" -type d -exec rm -r "{}" \; 2> /dev/null
echo "find ../ -type f -name 'package-lock.json' -delete"
find "$source_dir" -type f -name 'package-lock.json' -delete
echo "find ../ -type f -name '.DS_Store' -delete"
find "$source_dir" -type f -name '.DS_Store' -delete
echo "find $source_dir -iname \"package\" -type d -exec rm -r \"{}\" \; 2> /dev/null"
find "$source_dir" -iname "package" -type d -exec rm -r "{}" \; 2> /dev/null

echo "------------------------------------------------------------------------------"
echo "[Packing] Cache Invalidator"
echo "------------------------------------------------------------------------------"
cd "$source_dir"/cache_invalidator
pip3 install -r requirements.txt --target ./package
cd "$source_dir"/cache_invalidator/package
zip -q -r9 "$build_dist_dir"/cache_invalidator.zip .
cd "$source_dir"/cache_invalidator
cp -r "$source_dir"/lib .
zip -g -r "$build_dist_dir"/cache_invalidator.zip cache_invalidator.py lib
