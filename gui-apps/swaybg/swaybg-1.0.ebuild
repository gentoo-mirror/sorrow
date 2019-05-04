# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="Screen locker for Wayland"
HOMEPAGE="https://github.com/swaywm/swaylock"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/swaywm/${PN}.git"
else
	SRC_URI="https://github.com/swaywm/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 ~arm64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="+gdk-pixbuf +man"

DEPEND="
	dev-libs/wayland
	x11-libs/cairo
	gdk-pixbuf? ( x11-libs/gdk-pixbuf:2 )
	x11-libs/cairo
"
RDEPEND="
${DEPEND}
	!<=gui-libs/sway-1.0[swaybg]
"
BDEPEND="
	>=dev-libs/wayland-protocols-1.14
	virtual/pkgconfig
	man? ( app-text/scdoc )
"

src_configure() {
	local emesonargs=(
		-Dman-pages=$(usex man enabled disabled)
		-Dgdk-pixbuf=$(usex gdk-pixbuf enabled disabled)
	)
	if [[ ${PV} != 9999 ]]; then
		emesonargs+=("-Dswaylock-version=${PV}")
	fi

	meson_src_configure
}
