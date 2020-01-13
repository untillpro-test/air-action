#!/bin/sh -l

echo "Hello $1!!!"

echo "### ls -la"
ls -la

echo "### git --version"
git --version

echo "### printenv"
printenv
