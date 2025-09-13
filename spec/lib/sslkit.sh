#!/usr/bin/env sh

### File: sslkit.sh
##
## 関数セットのファイル。
##
## Usage:
##
## ------ Text ------
## Include sslkit.sh
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

sslkit_find() (
	# shellcheck disable=SC2016
	code='IFS=${SSLKIT_IFS-${IFS}};'"${1}"
	shift
	set -f
	IFS="${SSLKIT_IFS-${IFS}}"

	# shellcheck disable=SC2086
	find . ${SSLKIT_FIND_ARGS-} "${@}" -exec sh -fc "${code}" sh '{}' +
)

sslkit_find_file() {
	sslkit_find_file__code="${1}"
	shift

	eval "set -- $(sslkit_find_name "${@}")"

	sslkit_find "${sslkit_find_file__code}" "${@}" -type f
}

sslkit_find_dir() {
	sslkit_find_dir__code="${1}"
	shift

	eval "set -- $(sslkit_find_name "${@}")"

	sslkit_find "${sslkit_find_dir__code}" "${@}" -type d
}

sslkit_find_name() {
	if [ "${#}" -ne 0 ]; then
		printf "'(' -name '%s'" "${1}"
		shift

		if [ "${#}" -ne 0 ]; then
			printf " -o -name '%s'" "${@}"
		fi

		printf " ')'"
	fi
}

sslkit_exists_cmd() {
	set -- "$(command -v "${1}"; printf '_')"
	set -- "${1%?_}"

	if ! [ -f "${1}" ] || ! [ -x "${1}" ]; then
		return 1
	fi
}

sslkit_not_exists_all() {
	while [ "${#}" -ne 0 ]; do
		! sslkit_exists_cmd "${1}" || return 1
		shift
	done
}

sslkit_not_exists_any() {
	while [ "${#}" -ne 0 ]; do
		sslkit_exists_cmd "${1}" || return 0
		shift
	done

	return 1
}
