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

echo "### touch test"
touch test
echo $?

if [ "$GITHUB_REF" = 'refs/heads/develop' ]; then
	echo "## Merge to master"
	echo "### git fetch origin master"
	git fetch origin master 2>&1
	echo $?
	echo "### git checkout master"
	git checkout master 2>&1
	echo $?
	echo "### git merge $GITHUB_SHA"
	git merge $GITHUB_SHA 2>&1
	echo $?
	echo "### git push"
	git push 2>&1
	echo $?
fi
