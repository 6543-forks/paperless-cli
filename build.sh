#!/bin/bash
set -euf -o pipefail

GOVVVBIN=$(which govvv)
GOBIN=$(which go)
ECHOBIN=$(which echo)
SEDBIN=$(which sed)

GOPKGPATH=$($GOBIN list ./cmd)
GOLDFLAGS=$($GOVVVBIN -flags)
GOLDFLAGS=$($ECHOBIN $GOLDFLAGS | $SEDBIN -e 's|main|'$GOPKGPATH'|g')

$ECHOBIN "Building..."
$GOBIN build -ldflags="$GOLDFLAGS"
$ECHOBIN "Build complete."