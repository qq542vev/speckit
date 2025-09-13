#!/usr/bin/env sh

### File: shellcheck_spec.sh
##
## shellcheckによる*.shファイルの検証。
##
## Usage:
##
## ------ Text ------
## shellspec shellcheck_spec.sh
## ------------------
##
## Metadata:
##
##   id - 854d83d4-1a36-43c1-acb8-cb52ca0bf421
##   author - <qq542vev at https://purl.org/meta/me/>
##   version - 1.0.0
##   created - 2025-06-03
##   modified - 2025-09-10
##   copyright - Copyright (C) 2025-2025 qq542vev. All rights reserved.
##   license - <GNU GPLv3 at https://www.gnu.org/licenses/gpl-3.0.txt>
##   depends - find, shellcheck
##
## See Also:
##
##   * <Project homepage at https://github.com/qq542vev/sslk>
##   * <Bag report at https://github.com/qq542vev/sslk/issues>

eval "$(shellspec - -c) exit 1"

Include "${SHELLSPEC_HELPERDIR}/lib/sslkit.sh"

Describe 'Test: *.sh' sslkit category:shellscript
	if [ -z "${SSLKIT_SHELLCHECK_CMD+_}" ]; then
		Skip if 'not exists shellcheck' sslkit_not_exists_all shellcheck
	fi

	shellcheck_test() {
		# shellcheck disable=SC2016
		sslkit_find_file '${SSLKIT_SHELLCHECK_CMD:-shellcheck} -f gcc -s sh ${SSLKIT_SHELLCHECK_ARGS-} -- "${@}"' '?*.sh'
	}

	Example 'shellcheck *.sh'
		When call shellcheck_test
		The status should eq 0
	End
End
