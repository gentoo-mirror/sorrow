# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
VALA_MIN_API_VERSION="0.26"

inherit git-r3 cmake-utils vala gnome2-utils

DESCRIPTION="A searchable command palette in every modern GTK+ application"
HOMEPAGE="https://github.com/p-e-w/plotinus"
SRC_URI=""
EGIT_REPO_URI="https://github.com/p-e-w/plotinus.git"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="$(vala_depend)
>=x11-libs/gtk+-3.20.9"
RDEPEND="${DEPEND}"

src_prepare() {
	vala_src_prepare
	sed -i -e "/NAMES/s:valac:${VALAC}:" cmake/FindVala.cmake || die
	echo "GTK3_MODULES=\"${EPREFIX}/usr/$(get_libdir)/libplotinus.so\"" > "${S}"/99plotinus
	cmake-utils_src_prepare
}

src_install() {
	default
	cmake-utils_src_install
	rm -r ${D}/usr/lib/
	dolib.so "${BUILD_DIR}"/libplotinus.so
	doenvd "${S}"/99plotinus
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
