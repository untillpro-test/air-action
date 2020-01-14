#!/bin/sh -l

set -e

echo "Hello $1!!!"

echo "## System info"

echo "### ls -la"
ls -la

echo "### git --version"
git --version

echo "### printenv"
printenv

echo "### cat $GITHUB_EVENT_PATH"
cat $GITHUB_EVENT_PATH
echo

echo "GITHUB_REF = $GITHUB_REF"

echo "### touch test3"
touch test3
echo $?

if [ "$GITHUB_REF" = 'refs/heads/develop' ]; then
	echo "## Merge to master"
	git fetch origin master
	git checkout master
	git merge $GITHUB_SHA
	git push 2>&1
fi
