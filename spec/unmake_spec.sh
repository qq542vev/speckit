#!/usr/bin/env sh

### File: unmake_spec.sh
##
## unmakeによるmakeファイルの検証。
##
## Usage:
##
## ------ Text ------
## shellspec unmake_spec.sh
## ------------------
##
## Metadata:
##
##   id - 3467972e-beba-4092-bc13-70e093831860
##   author - <qq542vev at https://purl.org/meta/me/>
##   version - 1.0.0
##   created - 2025-10-04
##   modified - 2025-10-04
##   copyright - Copyright (C) 2025-2025 qq542vev. All rights reserved.
##   license - <GPL-3.0-only at https://www.gnu.org/licenses/gpl-3.0.txt>
##   depends - unmake
##   conforms-to - <https://github.com/shellspec/shellspec/blob/master/docs/references.md>
##
## See Also:
##
##   * <Project homepage at https://github.com/qq542vev/speckit>
##   * <Bag report at https://github.com/qq542vev/speckit/issues>

eval "$(shellspec -) exit 1"

for inc in "${SHELLSPEC_HELPERDIR}/speckit.sh" "${SHELLSPEC_HELPERDIR}/lib/speckit.sh" "${SHELLSPEC_SPECFILE%/*}/speckit.sh"; do
	[ -z "${SPECKIT_MODULE_LOADED+_}" ] || break

	if [ -f "${inc}" ]; then
		Include "${inc}"
	fi
done

Describe 'unmake' speckit category:makefile
	if [ -z "${SPECKIT_UNMAKE_CMD+_}" ]; then
		Skip if 'not exists unmake' speckit_not_exists_all unmake
	fi

	unmake_test() {
		# shellcheck disable=SC2016
		speckit_find_file '${SPECKIT_UNMAKE_CMD:-unmake} ${SPECKIT_UNMAKE_ARGS-} -- "${@}"' 'makefile' '?*.mk'
	}

	Example 'makefile'
		When call unmake_test
		The status should eq 0
	End
End
