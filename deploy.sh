#!/bin/bash

while getopts p option
do
  case $option in
    p) opt_p=TRUE ;;
  esac
done

if [ ! -d "public" ]
then
    echo -e "\033[1;31mDirectory 'public' does not exist. Check whether you are in the hugo root directory.\033[0m"
    exit 0
fi

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Generate the pages.
find public ! -name ".*" -delete
hugo

# Go to the submodule directory.
cd public

# Commit changes.
date="`date`"
git add -A
git commit -m "Rebuild the site on $date"

# Push to origin.
git push origin master

# Back to the original directory.
cd ..

# Commit and push the submodule SHA
git add -A
git commit -m "Update the site on $date"
git push origin master

# Ping Sitemap
if [ "$opt_p" = TRUE ]
then
  curl "http://www.google.com/ping?sitemap=https://danielqsj.github.io/sitemap.xml"
fi
