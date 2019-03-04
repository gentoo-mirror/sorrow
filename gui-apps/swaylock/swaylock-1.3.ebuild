# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit meson

DESCRIPTION="Screen locker for Wayland"
HOMEPAGE="https://github.com/swaywm/swaylock"
SRC_URI="https://github.com/swaywm/swaylock/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="+pam +gdk-pixbuf zsh-completion bash-completion fish-completion +doc"

RDEPEND="dev-libs/wayland
	x11-libs/libxkbcommon
	x11-libs/cairo
	gdk-pixbuf? ( x11-libs/gdk-pixbuf )
	pam? ( virtual/pam )
"
DEPEND="${RDEPEND}
	>=dev-libs/wayland-protocols-1.14
	doc? ( app-text/scdoc )
	!<gui-wm/sway-1.0_rc1
"
src_configure() {
	local emesonargs=(
		-Dman-pages=$(usex doc enabled disabled)
		-Dpam=$(usex pam enabled disabled)
		-Dgdk-pixbuf=$(usex gdk-pixbuf enabled disabled)
		-Dzsh-completions=$(usex zsh-completion true false)
		-Dbash-completions=$(usex bash-completion true false)
		-Dfish-completions=$(usex fish-completion true false)
		-Dswaylock-version=${PV}
	)

	meson_src_configure
}
