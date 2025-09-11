#!/usr/bin/env sh

### File: spec_spec.sh
##
## shellspecによる*_spec.shの検証。
##
## Usage:
##
## ------ Text ------
## shellspec shellspec_spec.sh
## ------------------
##
## Metadata:
##
##   id - dc64e0cc-a435-4391-86d9-417a72926e90
##   author - <qq542vev at https://purl.org/meta/me/>
##   version - 1.0.0
##   created - 2025-06-03
##   modified - 2025-09-11
##   copyright - Copyright (C) 2025-2025 qq542vev. All rights reserved.
##   license - <GNU GPLv3 at https://www.gnu.org/licenses/gpl-3.0.txt>
##   depends - find, shellspec
##
## See Also:
##
##   * <Project homepage at https://github.com/qq542vev/sslk>
##   * <Bag report at https://github.com/qq542vev/sslk/issues>

eval "$(shellspec - -c) exit 1"

Describe '*_spec.shの検証' sskit category:shellspec
	Set 'noglob:on'

	shellspec_test() (
		# shellcheck disable=SC2016
		code='
			IFS="${SSKIT_IFS-${IFS}}"

			shellspec --syntax-check ${SSKIT_MARKDOWNLINT_ARGS-} -- "${@}" >/dev/null
		'
		IFS="${SSKIT_IFS-${IFS}}"

		# shellcheck disable=SC2086
		find . ${SSKIT_FIND_ARGS-} -name '?*_spec.sh' -type f -exec sh -fc "${code}" sh '{}' +
	)

	Example 'shellspec --syntax-check *_spec.sh'
		When call shellspec_test
		The status should eq 0
	End
End
