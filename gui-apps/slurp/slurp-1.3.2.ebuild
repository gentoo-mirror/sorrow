# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="Select a region in a Wayland compositor"
HOMEPAGE="https://wayland.emersion.fr/slurp"

SRC_URI="https://github.com/emersion/${PN}/releases/download/v${PV}/${P}.tar.gz"
KEYWORDS="amd64 ~arm64"

LICENSE="MIT"
SLOT="0"
IUSE="+man"

DEPEND="
	>=dev-libs/wayland-protocols-1.14
	dev-libs/wayland
	x11-libs/cairo"

RDEPEND="${DEPEND}"

BDEPEND="man? ( app-text/scdoc )"

src_configure() {
	local emesonargs=(
		$(meson_feature man man-pages)
		"-Dwerror=false"
	)
	meson_src_configure
}
