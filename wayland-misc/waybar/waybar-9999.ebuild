# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 meson

DESCRIPTION="Highly customizable Wayland Polybar like bar"
HOMEPAGE="https://github.com/Alexays/Waybar"
EGIT_REPO_URI="https://github.com/Alexays/Waybar.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="+netlink pulseaudio +tray"

RDEPEND="sys-libs/libcap
	dev-libs/libfmt
	dev-libs/libinput
	dev-libs/wayland
	dev-cpp/gtkmm:3.0
	dev-libs/wlroots
	tray? ( dev-libs/libdbusmenu[gtk3] )
	dev-libs/jsoncpp
	dev-libs/libsigc++
	netlink? ( dev-libs/libnl )
	pulseaudio? ( media-sound/pulseaudio )
"
DEPEND="${RDEPEND}
	dev-libs/wayland-protocols
"

src_configure() {
	local emesonargs=(
		-Dlibnl=$(usex netlink enabled disabled)
		-Dpulseaudio=$(usex pulseaudio enabled disabled)
		-Ddbusmenu-gtk=$(usex tray enabled disabled)
	)
	meson_src_configure
}
