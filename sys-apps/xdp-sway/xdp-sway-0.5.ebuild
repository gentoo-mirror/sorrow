# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..13} )

inherit meson python-single-r1 xdg

DESCRIPTION="A graphical diff and merge tool"
HOMEPAGE="https://gitlab.com/eternal-sorrow/xdp-sway"
SRC_URI="https://gitlab.com/eternal-sorrow/xdp-sway/-/archive/v${PV}/${PN}-v${PV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~ppc ~ppc64 ~riscv ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/dbus-next[${PYTHON_USEDEP}]
	')
	$(python_gen_cond_dep '
		dev-python/i3ipc[${PYTHON_USEDEP}]
	')
	$(python_gen_cond_dep '
		dev-python/pygobject[${PYTHON_USEDEP}]
	')
"
DEPEND="${RDEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-v${PV}"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_configure() {
	meson_src_configure
}

src_install() {
	meson_src_install
	python_optimize
	python_fix_shebang "${ED}"/usr/libexec/xdp-sway
}
