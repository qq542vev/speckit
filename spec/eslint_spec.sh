#!/usr/bin/env sh

### File: eslint_spec.sh
##
## eslintによる*.js, *.cjs, *.mjsファイルの検証。
##
## Usage:
##
## ------ Text ------
## shellspec eslint_spec.sh
## ------------------
##
## Metadata:
##
##   id - a07956df-375e-49b0-8cea-dc8cbc3f98d9
##   author - <qq542vev at https://purl.org/meta/me/>
##   version - 1.0.0
##   created - 2025-06-02
##   modified - 2025-09-10
##   copyright - Copyright (C) 2025-2025 qq542vev. All rights reserved.
##   license - <GNU GPLv3 at https://www.gnu.org/licenses/gpl-3.0.txt>
##   depends - find, npx, eslint
##
## See Also:
##
##   * <Project homepage at https://github.com/qq542vev/sslk>
##   * <Bag report at https://github.com/qq542vev/sslk/issues>

eval "$(shellspec - -c) exit 1"

Include "${SHELLSPEC_HELPERDIR}/lib/sslkit.sh"

Describe 'eslint' sslkit category:javascript
	if [ -z "${SSLKIT_ESLINT_CMD+_}" ]; then
		Skip if 'not exists eslint' sslkit_not_exists_all eslint
	fi

	eslint_test() {
		# shellcheck disable=SC2016
		sslkit_find_file '${SSLKIT_ESLINT_CMD:-eslint} ${SSLKIT_ESLINT_ARGS-} -- "${@}"' '?*.js' '?*.[cm]js'
	}

	Example '*.js *.cjs *.mjs'
		When call eslint_test
		The status should eq 1
	End
End
