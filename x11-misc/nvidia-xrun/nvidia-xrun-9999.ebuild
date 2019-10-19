# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils systemd git-r3

DESCRIPTION="Script to run dedicated X server with discrete nvidia graphics"
HOMEPAGE="https://github.com/Witko/nvidia-xrun"
EGIT_REPO_URI="https://github.com/Witko/nvidia-xrun.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
		media-libs/mesa
		sys-power/bbswitch
		x11-apps/xinit
		x11-base/xorg-server[xorg]
		x11-drivers/nvidia-drivers[X,driver]
		x11-libs/libXrandr"

src_prepare() {
		eapply "${FILESDIR}/paths.patch"
		eapply_user
}

src_install() {
		dobin nvidia-xrun
		insinto /etc/X11
		doins nvidia-xorg.conf
		insinto /etc/X11/xinit
		doins nvidia-xinitrc
		insinto /etc/default
		doins config/nvidia-xrun
		systemd_dounit nvidia-xrun-pm.service
		dodoc README.md
}
