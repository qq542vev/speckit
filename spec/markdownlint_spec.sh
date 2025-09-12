#!/usr/bin/env sh

### File: markdownlint_spec.sh
##
## markdownlintによる*.mdファイルの検証。
##
## Usage:
##
## ------ Text ------
## shellspec markdownlint_spec.sh
## ------------------
##
## Metadata:
##
##   id - 2165f734-37a7-474e-b260-4b7b162d4c4b 
##   author - <qq542vev at https://purl.org/meta/me/>
##   version - 1.0.0
##   created - 2025-06-03
##   modified - 2025-09-10
##   copyright - Copyright (C) 2025-2025 qq542vev. All rights reserved.
##   license - <GNU GPLv3 at https://www.gnu.org/licenses/gpl-3.0.txt>
##   depends - find, npx, markdownlint
##
## See Also:
##
##   * <Project homepage at https://github.com/qq542vev/sslk>
##   * <Bag report at https://github.com/qq542vev/sslk/issues>

eval "$(shellspec - -c) exit 1"

Include "${SHELLSPEC_HELPERDIR}/sskit.sh"

Describe '*.mdファイルの検証' sskit category:markdown
	Skip if 'not exists npx' sskit_not_exists_all npx

	markdownlint_test() {
		# shellcheck disable=SC2016
		sskit_find_file 'npx ${SSKIT_NPX_ARGS-} markdownlint ${SSKIT_MARKDOWNLINT_ARGS-} -- "${@}"' '?*.md' '?*.markdown'
	}

	Example 'markdownlint *.md'
		When call markdownlint_test 
		The status should eq 0
	End
End
