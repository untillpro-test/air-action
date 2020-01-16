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
	echo "::warning::Unexpected hidden directory: \"$d\""
	exit 2
done

#!/bin/sh

# Reject sources which do not have "Copyright" word in first comment
check_dir () {
	for p in "$1"/*; do
		if [ -d "$p" ]; then
			check_dir "$p"
		else
			case "$p" in
				*.go)
					if ! cat "$p" | tr '\n' ' ' | grep -Eq "^\s*\/[\/\*](\s|[\/\*])*Copyright\b"; then
						echo "::warning::Missing Copyright in first comment in file: \"$p\""
						exit 3
					fi
				;;
			esac
		fi
	done
}
check_dir .

gocnt=`ls -1 *.go 2>/dev/null | wc -l`
if [[ $gocnt != 0 || -f "go.mod" ]]; then
	echo "::debug::Go project detected"

	export GOPRIVATE="${GOPRIVATE:+$GOPRIVATE,}github.com/untillpro-test,github.com/untillpro,github.com/vitkud"
	# go env -w GOPRIVATE=github.com/untillpro/*
	if [ -z "${GITHUB_TOKEN}" ]; then
		git config --global url."https://${GITHUB_TOKEN}:x-oauth-basic@github.com/untillpro-test".insteadOf "https://github.com/untillpro-test"
		git config --global url."https://${GITHUB_TOKEN}:x-oauth-basic@github.com/untillpro".insteadOf "https://github.com/untillpro"
		git config --global url."https://${GITHUB_TOKEN}:x-oauth-basic@github.com/vitkud".insteadOf "https://github.com/vitkud"
	fi

	go build ./...
	go test ./...
fi

# Automatically merge from develop to master
if [ "$GITHUB_REF" = 'refs/heads/develop' ]; then
	echo "## Merge to master"
	git fetch origin master
	git checkout master
	git merge $GITHUB_SHA
	git push 2>&1
fi
