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
##   depends - find
##
## See Also:
##
##   * <Project homepage at https://github.com/qq542vev/sslk>
##   * <Bag report at https://github.com/qq542vev/sslk/issues>

eval "$(shellspec - -c) exit 1"

set -f

Describe 'Test: *.sh'
	sh_test() (
		# shellcheck disable=SC2016
		code='
			IFS="${SSKIT_IFS-${IFS}}"

			for file in "${@}"; do
				sh -n ${SSKIT_SH_ARGS-} -- "${file}" || exit="${exit-${?}}"
			done

			exit "${exit-0}"
		'
		IFS="${SSKIT_IFS-${IFS}}"

		# shellcheck disable=SC2086
		find . ${SSKIT_FIND_ARGS-} -name '?*.sh' -type f -exec sh -fc "${code}" sh '{}' +
	)

	Example "sh -n -- '${1}'"
		When call sh_test
		The status should eq 0
	End
End
