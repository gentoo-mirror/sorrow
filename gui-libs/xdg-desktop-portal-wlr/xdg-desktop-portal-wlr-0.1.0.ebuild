# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="xdg-desktop-portal backend for wlroots"
HOMEPAGE="https://github.com/emersion/xdg-desktop-portal-wlr"

SRC_URI="https://github.com/emersion/${PN}/releases/download/v${PV}/${P}.tar.gz"
KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"
IUSE="elogind systemd"
REQUIRED_USE="?? ( elogind systemd )"

DEPEND="
	media-video/pipewire:0/0.3
	dev-libs/wayland
	>=dev-libs/wayland-protocols-1.14:=
	elogind? ( >=sys-auth/elogind-237 )
	systemd? ( >=sys-apps/systemd-237 )
"
RDEPEND="
	${DEPEND}
	sys-apps/xdg-desktop-portal
"
BDEPEND="
	media-video/pipewire:0/0.3
	>=dev-libs/wayland-protocols-1.14
	>=dev-util/meson-0.47.0
	virtual/pkgconfig
"

src_configure() {
	local emesonargs=(
		$(meson_feature systemd)
	)
	meson_src_configure
}
