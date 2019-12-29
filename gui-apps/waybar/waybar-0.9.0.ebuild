# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit meson

DESCRIPTION="Highly customizable Wayland bar for Sway and Wlroots based compositors."
HOMEPAGE="https://github.com/Alexays/Waybar"
SRC_URI="https://github.com/Alexays/Waybar/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="+netlink pulseaudio +tray mpd"

RDEPEND="sys-libs/libcap
	>=dev-libs/libfmt-5.3.0
	dev-libs/libinput
	dev-libs/wayland
	dev-cpp/gtkmm:3.0
	tray? ( dev-libs/libdbusmenu[gtk3] )
	dev-libs/jsoncpp
	dev-libs/libsigc++
	netlink? ( dev-libs/libnl )
	pulseaudio? ( media-sound/pulseaudio )
	mpd? ( media-libs/libmpdclient )
	>=dev-libs/spdlog-1.3.1
	gui-libs/gtk-layer-shell
"
DEPEND="${RDEPEND}
	dev-libs/wayland-protocols
"
S=${WORKDIR}/Waybar-${PV}

src_configure() {
	local emesonargs=(
		-Dlibnl=$(usex netlink enabled disabled)
		-Dpulseaudio=$(usex pulseaudio enabled disabled)
		-Ddbusmenu-gtk=$(usex tray enabled disabled)
		-Dmpd=$(usex mpd enabled disabled)
		-Dgtk-layer-shell=enabled
	)
	meson_src_configure
}
