# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 python3_4 )
PYTHON_REQ_USE='threads(+)'

inherit python-any-r1 waf-utils git-r3 multilib-build

NO_WAF_LIBDIR=1

DESCRIPTION="A GdkPixbuf loader for the WebP file format"
HOMEPAGE="https://github.com/aruiz/webp-pixbuf-loader"
SRC_URI=""
EGIT_REPO_URI="git://github.com/aruiz/webp-pixbuf-loader.git https://github.com/aruiz/webp-pixbuf-loader.git"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="
	x11-libs/gdk-pixbuf[${MULTILIB_USEDEP}]
	media-libs/libwebp[${MULTILIB_USEDEP}]"
RDEPEND="${DEPEND}"

_run_()
{
	OLD_S=${S}
	S=${BUILD_DIR}
	cd ${S}
	${@}
	S=${OLD_S}
}

src_prepare()
{
	default
	# gdk-pixbuf-query-loaders --update-cache causes sandbox access violation
	epatch ${FILESDIR}/no_update_cache.patch
	multilib_copy_sources
}


src_configure()
{
	multilib_foreach_abi _run_ waf-utils_src_configure
}

src_compile()
{
	multilib_foreach_abi _run_ waf-utils_src_compile
}

src_install()
{
	multilib_foreach_abi _run_ waf-utils_src_install
}

_update_cache_()
{
	${CHOST}-gdk-pixbuf-query-loaders --update-cache||die "Cache updating failed"
}

pkg_postinst()
{
	multilib_foreach_abi _update_cache_
}
