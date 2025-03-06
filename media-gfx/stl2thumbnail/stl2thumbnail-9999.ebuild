# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="A STL thumbnail generator"
HOMEPAGE="https://github.com/krepa098/stl2thumbnail"

SRC_URI=""
EGIT_REPO_URI="https://github.com/krepa098/stl2thumbnail.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="kde"
DEPEND="
	media-libs/libpng
	media-libs/glm
	!media-gfx/stl2thumbnail_rs
"

RDEPEND="${DEPEND}"

BDEPEND=""

DOCS=()

src_configure() {
	local mycmakeargs=(
		-DBUILD_GENERATOR_GNOME=yes
		-DBUILD_GENERATOR_KDE=$(usex kde)
	)
	cmake_src_configure
}
