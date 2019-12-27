#!/bin/bash -
set -o nounset                              # Treat unset variables as an error

PB=/usr/local/perlbrew
if [ -d $PB ]; then
	export PERLBREW_ROOT="$PB"
	source $PB/etc/bashrc
    perlbrew use perl-5.16.2
fi

