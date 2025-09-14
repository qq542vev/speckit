#!/usr/bin/env sh

### File: sh_spec.sh
##
## shによる*.shファイルの検証。
##
## Usage:
##
## ------ Text ------
## shellspec sh_spec.sh
## ------------------
##
## Metadata:
##
##   id - c87ddc38-29e3-4964-b1b1-4416c05aac08
##   author - <qq542vev at https://purl.org/meta/me/>
##   version - 1.0.0
##   created - 2025-06-03
##   modified - 2025-09-09
##   copyright - Copyright (C) 2025-2025 qq542vev. All rights reserved.
##   license - <GNU GPLv3 at https://www.gnu.org/licenses/gpl-3.0.txt>
##   depends - sh
##
## See Also:
##
##   * <Project homepage at https://github.com/qq542vev/sslk>
##   * <Bag report at https://github.com/qq542vev/sslk/issues>

eval "$(shellspec - -c) exit 1"

Include "${SHELLSPEC_HELPERDIR}/lib/sslkit.sh"

Describe 'Test: *.sh' sslkit category:shellscript
	if [ -z "${SSLKIT_SH_CMD+_}" ]; then
		Skip if 'not exists sh' sslkit_not_exists_all sh
	fi

	sh_test() {
		# shellcheck disable=SC2016
		sslkit_find_file '
			for file in "${@}"; do
				${SSLKIT_SH_CMD:-sh} -n ${SSLKIT_SH_ARGS-} -- "${file}" || exit="${exit-${?}}"
			done

			exit "${exit-0}"
		' '?*.sh'
	}

	Example 'sh -n *.sh'
		When call sh_test
		The status should eq 0
	End
End
