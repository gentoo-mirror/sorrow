# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson systemd git-r3

EGIT_REPO_URI="https://gitlab.freedesktop.org/pipewire/media-session.git"
KEYWORDS="~amd64 ~arm ~arm64 ~riscv ~x86"

DESCRIPTION="Example session manager for PipeWire"
HOMEPAGE="https://gitlab.freedesktop.org/pipewire/media-session"

LICENSE="MIT"
SLOT="0"
IUSE="elogind systemd test"

REQUIRED_USE="
	?? ( elogind systemd )
"

RESTRICT="!test? ( test )"

# introspection? ( dev-libs/gobject-introspection ) is valid but likely only used for doc building
BDEPEND="
	dev-libs/glib
	dev-util/gdbus-codegen
	dev-util/glib-utils
"

DEPEND="
	>=dev-libs/glib-2.62
	>=media-video/pipewire-0.3.39
	virtual/libc
	elogind? ( sys-auth/elogind )
	systemd? ( sys-apps/systemd )
"

RDEPEND="${DEPEND}"

DOCS=( NEWS LICENSE README.md )

src_configure() {
	local emesonargs=(
		$(meson_feature systemd)
		-Dsystemd-system-service=disabled
		$(meson_feature systemd systemd-user-service)
		-Dsystemd-user-unit-dir=$(systemd_get_userunitdir)
		-Dwith-module-sets="['alsa', 'pulseaudio']"
		$(meson_feature test tests)
	)

	meson_src_configure
}
