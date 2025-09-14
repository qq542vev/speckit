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
##   depends - markdownlint
##
## See Also:
##
##   * <Project homepage at https://github.com/qq542vev/sslk>
##   * <Bag report at https://github.com/qq542vev/sslk/issues>

eval "$(shellspec - -c) exit 1"

for inc in "${SHELLSPEC_HELPERDIR}/lib/speckit.sh" "${SHELLSPEC_SPECFILE}/../lib/speckit.sh"; do
	[ -z "${SPECKIT_MODULE_LODAD+_}" ] || break

	if [ -f "${inc}" ]; then
		Include "${inc}"
	fi
done

Describe '*.mdファイルの検証' speckit category:markdown
	if [ -z "${SPECKIT_MARKDOWNLINT_CMD+_}" ]; then
		Skip if 'not exists markdownlint' speckit_not_exists_all markdownlint
	fi

	markdownlint_test() {
		# shellcheck disable=SC2016
		speckit_find_file '${SPECKIT_MARKDOWNLINT_CMD:-markdownlint} ${SPECKIT_MARKDOWNLINT_ARGS-} -- "${@}"' '?*.md' '?*.markdown'
	}

	Example 'markdownlint *.md'
		When call markdownlint_test 
		The status should eq 0
	End
End
