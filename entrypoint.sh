#!/bin/sh -l

#set -e

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

echo "### touch test1"
touch test1
echo $?

if [ "$GITHUB_REF" = 'refs/heads/develop' ]; then
	echo "## Merge to master"
	echo "### fetch origin master"
	git fetch origin master 2>&1
	echo "### git checkout master"
	git checkout master 2>&1
	echo $?
	echo "### git merge develop"
	git merge develop
	echo $?
	echo "### git push"
	git push
	echo $?
fi
