# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit meson

DESCRIPTION="i3-compatible Wayland window manager"
HOMEPAGE="http://swaywm.org/"

MY_PV=${PV/_rc/-rc}

SRC_URI="https://github.com/swaywm/sway/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="+X elogind +wallpapers zsh-completion bash-completion fish-completion +doc"

RDEPEND=">=dev-libs/wlroots-0.4[elogind=,X?]
	dev-libs/json-c:0=
	dev-libs/libpcre
	dev-libs/libinput
	dev-libs/wayland
	sys-libs/libcap
	x11-libs/libxkbcommon
	x11-libs/cairo
	x11-libs/pango
	x11-libs/gdk-pixbuf[jpeg]
	virtual/pam
	wayland-misc/swaylock
	wayland-misc/swayidle
"

DEPEND="${RDEPEND}
	dev-libs/wayland-protocols
	doc? ( >=app-text/scdoc-1.8.1 )
"

S="${WORKDIR}/${PN}-${MY_PV}"

src_configure() {
	local emesonargs=(
		-Dxwayland=$(usex X enabled disabled)
		-Ddefault-wallpaper=$(usex wallpapers true false)
		-Dzsh-completions=$(usex zsh-completion true false)
		-Dbash-completions=$(usex bash-completion true false)
		-Dfish-completions=$(usex fish-completion true false)
		-Dtray=enabled
		-Dgdk-pixbuf=enabled
	)

	meson_src_configure
}
