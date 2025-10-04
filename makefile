#!/usr/bin/make -f

### File: makefile
##
## package.jsonを更新する。
##
## Usage:
##
## ------ Text ------
## make -f makefile
## ------------------
##
## Metadata:
##
##   id - 0250ed4c-a865-44cf-9684-d7f470accd1c 
##   author - <qq542vev at https://purl.org/meta/me/>
##   version - 0.0.1
##   created - 2025-09-16
##   modified - 2025-10-04
##   copyright - Copyright (C) 2025-2025 qq542vev. All rights reserved.
##   license - <GPL-3.0-only at https://www.gnu.org/licenses/gpl-3.0.txt>
##   depends - find, jq 
##   conforms-to - <https://pubs.opengroup.org/onlinepubs/9799919799/utilities/make.html>
##
## See Also:
##
##   * <Project homepage at https://github.com/qq542vev/speckit>
##   * <Bag report at https://github.com/qq542vev/speclit/issues>

.POSIX:

.PHONY: all help version

.SILENT: help version

# Macro
# =====

VERSION = 0.0.1

all: package.json

package.json: spec
	find LICENSE.txt README.md spec -type f -exec jq -n --args '$$ARGS.positional[]' '{}' + | jq -s --slurpfile pkg $(@) '$$pkg[0] + {files: sort}' >$(@).new
	mv -f -- $(@).new $(@)

LICENSE.txt:
	curl -sSfLo $(@) -- 'https://www.gnu.org/licenses/gpl-3.0.txt'

help:
	echo "package.jsonを更新する。"
	echo
	echo "USAGE:"
	echo "  make [OPTION...] [MACRO=VALUE...] [TARGET...]"

version:
	echo $(VERSION)
