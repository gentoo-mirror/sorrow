# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Transfers data from the BitTorrent network to another protocol (currently HTTP) which is more suitable for media players."
HOMEPAGE="http://www.beroal.in.ua/prg/bittorrent2player/"
SRC_URI="http://www.beroal.in.ua/prg/${PN}/src/${P}.tar.gz"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

COMMON_DEPEND=">=net-libs/rb_libtorrent-0.15.7[python]"
DEPEND="${COMMON_DEPEND}
	dev-util/desktop-file-utils"
RDEPEND="${COMMON_DEPEND}"
