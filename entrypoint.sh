#!/bin/sh -l

echo "Hello $1!!!"

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
	echo "### merge to master"
	git checkout master
	git merge develop
	git push
fi
