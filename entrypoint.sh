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

if [ "$GITHUB_REF" = 'refs/heads/develop' ]; then
	echo "## Merge to master"
	echo "### git checkout master"
	git checkout master
	echo $?
	echo "### git merge develop"
	git merge develop
	echo $?
	echo "### git push"
	git push
	echo $?
fi
