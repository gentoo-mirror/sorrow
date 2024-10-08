# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{9..12} )

inherit meson python-single-r1

DESCRIPTION="Systemd integration for Sway session"
HOMEPAGE="https://github.com/alebastr/sway-systemd"

SRC_URI="https://github.com/alebastr/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="+cgroups autostart logind"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	gui-wm/sway
	sys-apps/systemd
	sys-apps/dbus
	$(python_gen_cond_dep 'dev-python/dbus-next[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/i3ipc[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/psutil[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/tenacity[${PYTHON_USEDEP}]')
"
DEPEND="${RDEPEND}"
BDEPEND=""

pkg_setup() {
	python-single-r1_pkg_setup
}

join_comma() {
	local IFS=','
	echo "${*}"
}

src_configure() {
	local args=(
		$(usex cgroups cgroups "")
		$(usex autostart autostart "")
		$(usex logind locale1 "")
	)
	echo ${args[@]}
	local emesonargs=(
		-Dautoload-configs=$(join_comma ${args[@]})
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	python_optimize
	if use cgroups
	then
		python_fix_shebang "${ED}"/usr/libexec/sway-systemd/assign-cgroups.py
	fi
}
