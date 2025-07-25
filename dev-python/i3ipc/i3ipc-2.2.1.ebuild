# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=8

PYTHON_COMPAT=( python3_{11..13} python3_13t )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="An improved Python library for i3wm extensions"
HOMEPAGE="https://github.com/altdesktop/i3ipc-python"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

IUSE="X"

RDEPEND="|| ( x11-wm/i3 x11-wm/i3-gaps gui-wm/sway )
	X? ( dev-python/python-xlib[${PYTHON_USEDEP}] )
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_prepare(){
	if ! use X
	then
		PATCHES=( "${FILESDIR}"/no-xlib.patch )
	fi

	distutils-r1_src_prepare
}
