#!/bin/sh -l

set -o errexit
#set -o xtrace
#set -o verbose

# Reject commits to master
if [ "$GITHUB_REF" = 'refs/heads/master' ]; then
	echo "::warning::Unexpected commit to master branch"
	exit 1
fi

# Reject ".*" folders
for d in .*/; do
	if [[ "$d" = "./" || "$d" = "../" ]]; then
		continue
	fi
	if [[ "$d" = ".git/" || "$d" = ".github/" ]]; then
		continue
	fi
	echo "::warning::Unexpected hidden directory detected: \"$d\""
	exit 1
done

# Automatically merge from develop to master
if [ "$GITHUB_REF" = 'refs/heads/develop' ]; then
	echo "## Merge to master"
	git fetch origin master
	git checkout master
	git merge $GITHUB_SHA
	git push 2>&1
fi
