#!/usr/bin/env sh

### File: markuplint_spec.sh
##
## markuplintによる*.html, *.xhtmlの検証。
##
## Usage:
##
## ------ Text ------
## shellspec markuplint_spec.sh
## ------------------
##
## Metadata:
##
##   id - e01e7a20-0c6f-44fc-a602-63f5067430d5 
##   author - <qq542vev at https://purl.org/meta/me/>
##   version - 1.0.0
##   created - 2025-09-14
##   modified - 2025-09-14
##   copyright - Copyright (C) 2025-2025 qq542vev. All rights reserved.
##   license - <GNU GPLv3 at https://www.gnu.org/licenses/gpl-3.0.txt>
##   depends - markuplint
##
## See Also:
##
##   * <Project homepage at https://github.com/qq542vev/sslk>
##   * <Bag report at https://github.com/qq542vev/sslk/issues>

eval "$(shellspec - -c) exit 1"

for inc in "${SHELLSPEC_HELPERDIR}/lib/sslkit.sh" "${SHELLSPEC_SPECFILE}/../lib/sslkit.sh"; do
	[ -n "${SSLKIT_MODULE_LODAD+_}" ] && break

	if [ -f "${inc}" ]; then
		Include "${inc}"
	fi
done

Describe 'Test: *.html, *xhtml' sslkit category:html
	if [ -z "${SSLKIT_MARKUPLINLT_CMD+_}" ]; then
		Skip if 'not exists markuplint' sslkit_not_exists_all markuplint
	fi

	markuplint_test() {
		# shellcheck disable=SC2016
		sslkit_find_file '${SSLKIT_MARKUPLINLT_CMD:-markuplint} ${SSLKIT_MARKUPLINLT_ARGS-} -- "${@}"' '?*.html' '?*.xhtml'
	}

	Example "markuplint *.html *.xhtml"
		When call markuplint_test
		The status should eq 0
	End
End
