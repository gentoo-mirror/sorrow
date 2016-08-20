# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=(python3_4 python3_5)
PYTHON_REQ_USE='threads(+),ssl(+)'
inherit python-any-r1 waf-utils git-r3

DESCRIPTION="A Tox client written in Vala/GTK+3"
HOMEPAGE="https://ricin.im/"
EGIT_REPO_URI="https://github.com/RicinApp/Ricin.git"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-lang/vala:0.32
	>=dev-libs/json-glib-1.0
	dev-libs/glib:2
	dev-util/intltool
	>=x11-libs/libnotify-0.7.6
	>=net-libs/libsoup-2.4
	net-libs/tox
	x11-libs/gtk+:3
"
RDEPEND="${DEPEND}"

src_configure() {
	export VALAC=/usr/bin/valac-0.32
	waf-utils_src_configure
}

src_install() {
	waf-utils_src_install
	# The name of the binary is capitalised by default.
	mv ${D}/usr/bin/Ricin ${D}/usr/bin/ricin
}

