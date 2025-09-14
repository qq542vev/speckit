#!/usr/bin/env sh

### File: desktop-file-validate_spec.sh
##
## desktop-file-validateによる*.desktopファイルの検証。
##
## Usage:
##
## ------ Text ------
## shellspec desktop-file-validate_spec.sh
## ------------------
##
## Metadata:
##
##   id - 74502681-fffb-4891-ae9e-e5c368d3797e
##   author - <qq542vev at https://purl.org/meta/me/>
##   version - 1.0.0
##   created - 2025-06-03
##   modified - 2025-09-09
##   copyright - Copyright (C) 2025-2025 qq542vev. All rights reserved.
##   license - <GNU GPLv3 at https://www.gnu.org/licenses/gpl-3.0.txt>
##   depends - desktop-file-validate
##
## See Also:
##
##   * <Project homepage at https://github.com/qq542vev/sslk>
##   * <Bag report at https://github.com/qq542vev/sslk/issues>

eval "$(shellspec - -c) exit 1"

Include "${SHELLSPEC_HELPERDIR}/lib/sslkit.sh"

Describe 'Test: *.desktop' sslkit category:desktop
	if [ -z "${SSLKIT_DESKTOP_FILE_VALIDATE_CMD+_}" ]; then
		Skip if 'not exists desktop-file-validate' sslkit_not_exists_all desktop-file-validate
	fi

	desktopfilevalidate_test() {
		# shellcheck disable=SC2016
		sslkit_find_file '${SSLKIT_DESKTOP_FILE_VALIDATE_CMD:-desktop-file-validate} ${SSLKIT_DESKTOP_FILE_VALIDATE_ARGS-} -- "${@}"' '?*.desktop'
	}

	Example 'desktop-file-validate *.desktop'
		When call desktopfilevalidate_test
		The status should eq 0
	End
End
