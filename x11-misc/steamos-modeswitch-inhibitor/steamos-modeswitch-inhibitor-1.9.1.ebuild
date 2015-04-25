# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils multilib-minimal

DESCRIPTION="Shared library which fakes any mode switch attempts to prevent full screen apps from changing resolution"
HOMEPAGE="http://repo.steampowered.com/steamos/pool/main/s/steamos-modeswitch-inhibitor/"
SRC_URI="http://repo.steampowered.com/steamos/pool/main/s/steamos-modeswitch-inhibitor/steamos-modeswitch-inhibitor_${PV}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="x11-libs/libXxf86vm
	x11-libs/libX11
	x11-libs/libXrender
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXrandr
	virtual/opengl"
RDEPEND="${DEPEND}"
S=${WORKDIR}/${PN}

multilib_src_configure()
{
	ECONF_SOURCE="${S}" econf
}

multilib_src_install()
{
	dolib.so .libs/libmodeswitch_inhibitor.so*
}

multilib_src_install_all()
{
	dodoc ${S}/debian/changelog

}
