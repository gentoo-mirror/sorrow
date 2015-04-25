# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# Based on xcompmgr ebuild and PKGBUILD from Arch Linux AUR
EAPI=5

XORG_STATIC=no
inherit xorg-2 multilib

DESCRIPTION="Compositor used by SteamOS \"based on xcompmgr by Keith Packard et al.\""
HOMEPAGE="http://repo.steampowered.com/steamos/pool/main/s/steamos-compositor/"
SRC_URI="http://repo.steampowered.com/steamos/pool/main/s/steamos-compositor/steamos-compositor_${PV}.tar.gz"

LICENSE="BSD-2"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="x11-libs/libXrender
	x11-libs/libXdamage
	x11-libs/libXfixes
	x11-libs/libXcomposite
	x11-libs/libXext
	x11-libs/libXxf86vm
	media-libs/sdl-image
	virtual/opengl"
DEPEND="${RDEPEND}"
S=${WORKDIR}/${PN}

src_configure()
{
	export	LIBS="-lXext -lXt -lXpm -lXdamage -lXfixes"
	xorg-2_src_configure
}

src_compile()
{
	xorg-2_src_compile
	#Fix paths to libraries of steamos-modeswitch-inhibitor
	sed -i -e "s/lib\/x86_64-linux-gnu/$(get_abi_LIBDIR amd64)/" \
	-e "s/lib\/i386-linux-gnu/$(get_abi_LIBDIR x86)/" \
	${S}/usr/bin/steamos-session || die "sed failed"
}

src_install()
{
	xorg-2_src_install
	exeinto /usr/bin
	doexe ${S}/usr/bin/steamos-session
	insinto /usr
	doins -r ${S}/usr/share
	dodoc ${S}/debian/changelog
}
