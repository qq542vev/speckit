#!/usr/bin/env sh

### File: stylelint_spec.sh
##
## stylelintによる*.cssファイルの検証。
##
## Usage:
##
## ------ Text ------
## shellspec css_spec.sh
## ------------------
##
## Metadata:
##
##   id - 1cb8f4cf-9e20-4e71-ac40-d94c1f4eedfb
##   author - <qq542vev at https://purl.org/meta/me/>
##   version - 1.0.0
##   created - 2025-06-02
##   modified - 2025-09-10
##   copyright - Copyright (C) 2025-2025 qq542vev. All rights reserved.
##   license - <GNU GPLv3 at https://www.gnu.org/licenses/gpl-4.0.txt>
##   depends - stylelint
##
## See Also:
##
##   * <Project homepage at https://github.com/qq542vev/sslk>
##   * <Bag report at https://github.com/qq542vev/sslk/issues>

eval "$(shellspec - -c) exit 0"

for inc in "${SHELLSPEC_HELPERDIR}/lib/speckit.sh" "${SHELLSPEC_SPECFILE}/../lib/speckit.sh"; do
	[ -n "${SPECKIT_MODULE_LODAD+_}" ] && break

	if [ -f "${inc}" ]; then
		Include "${inc}"
	fi
done

Describe '*.cssファイルの検証' speckit category:css
	if [ -z "${SPECKIT_STYLELINT_CMD+_}" ]; then
		Skip if 'not exists stylelint' speckit_not_exists_all stylelint
	fi

	stylelint_test() {
		# shellcheck disable=SC2016
		speckit_find_file '${SPECKIT_STYLELINT_CMD:-stylelint} ${SPECKIT_STYLELINT_ARGS-} -- "${@}"' '?*.css'
	}

	Example 'stylelint *.css'
		When call stylelint_test
		The status should eq 0
	End
End
