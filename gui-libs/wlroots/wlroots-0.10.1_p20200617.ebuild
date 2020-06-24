# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit fcaps meson git-r3

DESCRIPTION="Pluggable, composable, unopinionated modules for building a Wayland compositor"
HOMEPAGE="https://github.com/swaywm/wlroots"

EGIT_REPO_URI="https://github.com/swaywm/${PN}.git"
EGIT_COMMIT="9e68ed21599661f75f3b73e3e698ab8828341a18"
KEYWORDS="amd64 arm64 x86"

LICENSE="MIT"
SLOT="0/8"
IUSE="elogind icccm systemd x11-backend X"
REQUIRED_USE="?? ( elogind systemd )"

DEPEND="
	>=dev-libs/libinput-1.9.0:0=
	>=dev-libs/wayland-1.17.0
	media-libs/mesa[egl,gles2,gbm]
	virtual/libudev
	x11-libs/libdrm
	x11-libs/libxkbcommon
	x11-libs/pixman
	elogind? ( >=sys-auth/elogind-237 )
	icccm? ( x11-libs/xcb-util-wm )
	systemd? ( >=sys-apps/systemd-237 )
	x11-backend? ( x11-libs/libxcb:0= )
	X? (
		x11-base/xorg-server[wayland]
		x11-libs/libxcb:0=
		x11-libs/xcb-util-image
	)
"
RDEPEND="
	${DEPEND}
	media-video/ffmpeg:0=
"
BDEPEND="
	>=dev-libs/wayland-protocols-1.17
	virtual/pkgconfig
"

src_configure() {
	# xcb-util-errors is not on Gentoo Repository (and upstream seems inactive?)
	local emesonargs=(
		"-Dxcb-errors=disabled"
		-Dlibcap=$(usex filecaps enabled disabled)
		-Dxcb-icccm=$(usex icccm enabled disabled)
		-Dxwayland=$(usex X enabled disabled)
		-Dx11-backend=$(usex x11-backend enabled disabled)
		"-Dexamples=false"
		"-Dwerror=false"
	)
	if use systemd; then
		emesonargs+=("-Dlogind=enabled" "-Dlogind-provider=systemd")
	elif use elogind; then
		emesonargs+=("-Dlogind=enabled" "-Dlogind-provider=elogind")
	else
		emesonargs+=("-Dlogind=disabled")
	fi

	meson_src_configure
}

pkg_postinst() {
	elog "You must be in the input group to allow your compositor"
	elog "to access input devices via libinput."
}
