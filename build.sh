#!/usr/bin/env bash

XCODE_8=/Applications/Xcode_8.3.3.app
XCODE_9=/Applications/Xcode_9.0.app
MSBUILD_VERBOSITY=${MSBUILD_VERBOSITY:-minimal}

if [ ! -d "$XCODE_8" -o ! -d "$XCODE_9" ]; then
	echo "You must have Xcode 8 at $XCODE_9"
	echo "You must have Xcode 9 at $XCODE_9"
	exit 1
fi

function scenario {	
	echo "***"
	echo "*** $1"
	echo "***"
	set -x
	find . \( -name bin -or -name obj \) -and -type d | xargs rm -rf
	xcrun -k
	sudo xcode-select -s "$2" && xcode-select -p && msbuild /v:"$MSBUILD_VERBOSITY" /t:Clean,Build /p:Configuration=Debug
	set +x
}

scenario "SCENARIO 1: Xcode 9 only" "$XCODE_9"
scenario "SCENARIO 2: Xcode 8 as default (Mac) + 9 for iOS" "$XCODE_8"
