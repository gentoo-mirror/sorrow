# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit rpm gnome2-utils fdo-mime

DESCRIPTION="Firefox web browser (GTK+ 3, binary build)"
HOMEPAGE="https://bugzilla.mozilla.org/show_bug.cgi?id=627699"

MY_P=${P/-bin/}
SRC_URI="http://copr-be.cloud.fedoraproject.org/results/stransky/FirefoxGtk3/fedora-rawhide-x86_64/${MY_P}-1.fc20/${MY_P}-1.fc21.x86_64.rpm"

LICENSE="MPL-2.0 GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="
${DEPEND}
virtual/jpeg:62
sys-devel/gcc:4.9
"

QA_PREBUILT="
	usr/lib64/${PN/-bin/}/*.so
	usr/lib64/${PN/-bin/}/${PN/-gtk3/}
	usr/lib64/${PN/-bin/}/${PN/-gtk3-bin/}
	usr/lib64/${PN/-bin/}/webapprt-stub
	usr/lib64/${PN/-bin/}/plugin-container
	usr/lib64/${PN/-bin/}/mozilla-xremote-client
"

S=${WORKDIR}

src_prepare()
{
	sed "s:LIB_DIR/firefox/:LIB_DIR/firefox-gtk3/:" -i ${S}/usr/bin/firefox-gtk3||die "Sed 1 failed"
	sed "s:Icon=firefox-gtk3:Icon=firefox:" -i ${S}/usr/share/applications/firefox-gtk3.desktop||die "Sed 2 failed"
}

src_install()
{
	cp -a usr ${ED}
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update 
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update 
	gnome2_icon_cache_update
}
