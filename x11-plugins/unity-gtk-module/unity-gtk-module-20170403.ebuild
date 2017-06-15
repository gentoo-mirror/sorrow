# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 )

inherit autotools eutils python-r1 gnome2-utils

DESCRIPTION="GTK+ module for exporting old-style menus as GMenuModels"
HOMEPAGE="https://launchpad.net/unity-gtk-module"
UVER="17.04"
SRC_URI="http://archive.ubuntu.com/ubuntu/pool/main/u/unity-gtk-module/unity-gtk-module_0.0.0+${UVER}.${PV}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="gtk2 gtk3"
GNOME2_ECLASS_GLIB_SCHEMAS="com.canonical.${PN}"

DEPEND="dev-libs/glib:2
	dev-libs/libdbusmenu:=[gtk2(+)?,gtk3(+)?]
	x11-libs/libX11
	gtk2? ( x11-libs/gtk+:2 )
	gtk3? ( x11-libs/gtk+:3 )
	!x11-misc/appmenu-gtk"

S="${WORKDIR}"

src_prepare() {
	epatch "${FILESDIR}/unity-gtk-module-0.0.0+14.04-deprecated-api.patch"
	eapply_user
	eautoreconf
}

src_configure()
{
	if use gtk2
	then
		# Build GTK2 support #
		[[ -d build-gtk2 ]] || mkdir build-gtk2
		pushd build-gtk2
			../configure --prefix=/usr \
				--sysconfdir=/etc \
				--disable-static \
				--with-gtk=2 || die
		popd
	fi

	if use gtk3
	then
		# Build GTK3 support #
		[[ -d build-gtk3 ]] || mkdir build-gtk3
		pushd build-gtk3
			../configure --prefix=/usr \
			--sysconfdir=/etc \
			--disable-static || die
		popd
	fi
}

src_compile()
{
	if use gtk2
	then
		# Build GTK2 support #
		pushd build-gtk2
			emake
		popd
	fi

	if use gtk3
	then
		# Build GTK3 support #
		pushd build-gtk3
			emake
		popd
	fi
}

src_install()
{
	if use gtk2
	then
		# Install GTK2 support #
		pushd build-gtk2
			emake DESTDIR="${D}" install
		popd
	fi

	if use gtk3
	then
		# Install GTK3 support #
		pushd build-gtk3
			emake DESTDIR="${D}" install
		popd
	fi

	prune_libtool_files --modules
}

pkg_postinst()
{
	gnome2_schemas_update
}
