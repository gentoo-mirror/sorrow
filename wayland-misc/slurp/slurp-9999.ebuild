# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 meson

DESCRIPTION="Select a region in a Wayland compositor"
HOMEPAGE="https://wayland.emersion.fr/slurp"
EGIT_REPO_URI="https://github.com/emersion/slurp.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="dev-libs/wayland
	x11-libs/cairo
"
DEPEND="${RDEPEND}
	>=dev-libs/wayland-protocols-1.14
	app-text/scdoc
"
