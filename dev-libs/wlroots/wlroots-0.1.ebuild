# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit meson

DESCRIPTION="Modular Wayland compositor library"
HOMEPAGE="https://github.com/swaywm/wlroots"
SRC_URI="https://github.com/swaywm/wlroots/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="+xwayland elogind X"

RDEPEND="sys-libs/libcap
	dev-libs/libinput
	virtual/opengl
	!elogind? ( sys-apps/systemd )
	elogind? ( sys-auth/elogind )
	>=dev-libs/wayland-1.16
	x11-libs/pixman
	X? (
		x11-libs/libxcb
		x11-libs/xcb-util-errors
		x11-libs/xcb-util-image
		x11-libs/xcb-util-wm
	)
"
DEPEND="${RDEPEND}
	dev-libs/wayland-protocols
"

DOCS=( README.md CONTRIBUTING.md docs/env_vars.md )

src_configure() {
	local emesonargs=(
		-Dxwayland=$(usex xwayland enabled disabled)
		-Dlogind-provider=$(usex elogind elogind systemd)
		-Dx11-backend=$(usex X enabled disabled)
		-Dlibcap=enabled
		-Dlogind=enabled
		-Dxcb-errors=enabled
		-Drootston=false
		-Dexamples=false
	)
	meson_src_configure
}
