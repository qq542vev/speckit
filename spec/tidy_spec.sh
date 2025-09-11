#!/usr/bin/env sh

### File: tidy_spec.sh
##
## tidyによる*.html, *.xhtmlの検証。
##
## Usage:
##
## ------ Text ------
## shellspec tidy_spec.sh
## ------------------
##
## Metadata:
##
##   id - 6a58f8b0-02fe-4dd0-87c7-7d7ca64a85af
##   author - <qq542vev at https://purl.org/meta/me/>
##   version - 1.0.0
##   created - 2025-06-02
##   modified - 2025-09-09
##   copyright - Copyright (C) 2025-2025 qq542vev. All rights reserved.
##   license - <GNU GPLv3 at https://www.gnu.org/licenses/gpl-3.0.txt>
##   depends - find, tidy 
##
## See Also:
##
##   * <Project homepage at https://github.com/qq542vev/sslk>
##   * <Bag report at https://github.com/qq542vev/sslk/issues>

eval "$(shellspec - -c) exit 1"

set -f

Describe 'Test: *.html, *xhtml'
	tidy_test() {
		# shellcheck disable=SC2016
		code='
			IFS="${SSKIT_IFS-${IFS}}"

			tidy -eq --show-filename yes ${SSKIT_TIDY_ARGS-} -- "${@}"
		'
		IFS="${SSKIT_IFS-${IFS}}"

		# shellcheck disable=SC2086
		find . ${SSKIT_FIND_ARGS-} '(' -name '?*.html' -o -name '?*.xhtml' ')' -type f -exec sh -fc "${code}" sh '{}' +
	}

	Example "tidy -eq -- *.html *.xhtml"
		When call tidy_test
		The status should not eq 2
	End
End
