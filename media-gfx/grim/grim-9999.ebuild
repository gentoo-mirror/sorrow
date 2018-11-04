# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 meson

DESCRIPTION="Grab images from a Wayland compositor"
HOMEPAGE="https://wayland.emersion.fr/grim"
EGIT_REPO_URI="https://github.com/emersion/grim.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="dev-libs/wayland
	x11-libs/cairo
	virtual/jpeg:0
"
DEPEND="${RDEPEND}
	>=dev-libs/wayland-protocols-1.14
	app-text/scdoc
"
