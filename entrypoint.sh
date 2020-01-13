#!/bin/sh -l

echo "Hello $1!!!"

echo "### sh --version"
sh --version

echo "### ls -la"
ls -la

echo "### ls -ld"
ls -ld

echo "### file -h /bin/sh"
file -h /bin/sh

echo "### find -L /bin -samefile /bin/sh"
find -L /bin -samefile /bin/sh

echo `git`
