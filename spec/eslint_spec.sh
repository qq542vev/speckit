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

set -f

Describe '*.mdファイルの検証'
	eslint_test() (
		# shellcheck disable=SC2016
		code='
			IFS="${SSKIT_IFS-${IFS}}"

			npx eslint ${SSKIT_ESLINT_ARGS-} -- "${@}"
		'
		IFS="${SSKIT_IFS-${IFS}}"

		# shellcheck disable=SC2086
		find . ${SSKIT_FIND_ARGS-} '(' -name '?*.js' -o -name '?*.[cm]js' ')' -type f -exec sh -fc "${code}" sh '{}' +
	)

	Example 'eslint *.js *.cjs *.mjs'
		When call eslint_test
		The status should eq 0
	End
End
