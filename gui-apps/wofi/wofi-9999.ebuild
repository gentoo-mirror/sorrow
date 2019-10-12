# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit mercurial

DESCRIPTION="Launcher/menu program for wlroots based wayland compositors such as sway"
HOMEPAGE="https://cloudninja.pw/docs/wofi.html"
EHG_REPO_URI="https://hg.sr.ht/~scoopta/wofi"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	dev-libs/wayland
	x11-libs/gtk+
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

src_configure(){
	true
}

src_compile(){
	cd Release
	emake
}

src_install(){
	dobin Release/wofi
	dodoc README.md
}
