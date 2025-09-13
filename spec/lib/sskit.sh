#!/usr/bin/env sh

### File: sskit.sh
##
## 関数セットのファイル。
##
## Usage:
##
## ------ Text ------
## Include sskit.sh
## ------------------
##
## Metadata:
##
##   id - 28e2faed-9430-43e2-a266-5f0a1a473463
##   author - <qq542vev at https://purl.org/meta/me/>
##   version - 1.0.0
##   created - 2025-09-12
##   modified - 2025-09-14
##   copyright - Copyright (C) 2025-2025 qq542vev. All rights reserved.
##   license - <GNU GPLv3 at https://www.gnu.org/licenses/gpl-3.0.txt>
##
## See Also:
##
##   * <Project homepage at https://github.com/qq542vev/sslk>
##   * <Bag report at https://github.com/qq542vev/sslk/issues>

sskit_find() (
	# shellcheck disable=SC2016
	code='IFS=${SSKIT_IFS-${IFS}};'"${1}"
	shift
	set -f
	IFS="${SSKIT_IFS-${IFS}}"

	# shellcheck disable=SC2086
	find . ${SSKIT_FIND_ARGS-} "${@}" -exec sh -fc "${code}" sh '{}' +
)

sskit_find_file() {
	sskit_find_file__code="${1}"
	shift

	eval "set -- $(sskit_find_name "${@}")"

	sskit_find "${sskit_find_file__code}" "${@}" -type f
}

sskit_find_dir() {
	sskit_find_dir__code="${1}"
	shift

	eval "set -- $(sskit_find_name "${@}")"

	sskit_find "${sskit_find_dir__code}" "${@}" -type d
}

sskit_find_name() {
	if [ "${#}" -ne 0 ]; then
		printf "'(' -name '%s'" "${1}"
		shift

		if [ "${#}" -ne 0 ]; then
			printf " -o -name '%s'" "${@}"
		fi

		printf " ')'"
	fi
}

sskit_exists_cmd() {
	set -- "$(command -v "${1}"; printf '_')"
	set -- "${1%?_}"

	if ! [ -f "${1}" ] || ! [ -x "${1}" ]; then
		return 1
	fi
}

sskit_not_exists_all() {
	while [ "${#}" -ne 0 ]; do
		! sskit_exists_cmd "${1}" || return 1
		shift
	done
}

sskit_not_exists_any() {
	while [ "${#}" -ne 0 ]; do
		sskit_exists_cmd "${1}" || return 0
		shift
	done

	return 1
}
