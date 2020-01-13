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
