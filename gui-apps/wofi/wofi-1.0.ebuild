# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit meson mercurial

DESCRIPTION="Launcher/menu program for wlroots based wayland compositors such as sway"
HOMEPAGE="https://cloudninja.pw/docs/wofi.html"
EHG_REPO_URI="https://hg.sr.ht/~scoopta/wofi"
EHG_REVISION="v${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	dev-libs/wayland
	x11-libs/gtk+[wayland]
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"
S="${WORKDIR}/${PN}-v${PV}"
