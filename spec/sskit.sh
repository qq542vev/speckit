#!/usr/bin/env sh

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

sskit_not_exists_all() {
	while [ "${#}" -ne 0 ]; do
		type "${1}" >/dev/null 2>&1 && return 1
		shift
	done
}
