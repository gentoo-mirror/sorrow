# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="japanese input method for wlroots-based compositors"
HOMEPAGE="https://github.com/tadeokondrak/anthywl"

inherit git-r3
EGIT_REPO_URI="https://github.com/tadeokondrak/anthywl.git"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/wayland
	dev-libs/wayland-protocols
	x11-libs/libxkbcommon
	x11-libs/cairo
	x11-libs/pango
	app-i18n/anthy
	dev-libs/libscfg
	dev-libs/libvarlink
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	meson_src_install
	default
	insinto "/usr/share/anthywl"
	doins "data/default_config"
}
