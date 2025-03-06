# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler@1.0.2
	aho-corasick@1.1.2
	anstream@0.6.11
	anstyle@1.0.6
	anstyle-parse@0.2.3
	anstyle-query@1.0.2
	anstyle-wincon@3.0.2
	anyhow@1.0.79
	approx@0.5.1
	atty@0.2.14
	autocfg@1.1.0
	base64@0.21.7
	bitflags@1.3.2
	bitflags@2.4.2
	bytemuck@1.14.1
	byteorder@1.5.0
	cbindgen@0.26.0
	cfg-if@1.0.0
	clap@3.2.25
	clap@4.4.18
	clap_builder@4.4.18
	clap_lex@0.2.4
	clap_lex@0.6.0
	colorchoice@1.0.0
	color_quant@1.1.0
	crc32fast@1.3.2
	crossbeam-utils@0.8.19
	errno@0.3.8
	fastrand@2.0.1
	fdeflate@0.3.4
	flate2@1.0.28
	gif@0.12.0
	hashbrown@0.12.3
	heck@0.4.1
	hermit-abi@0.1.19
	image@0.24.8
	indexmap@1.9.3
	itoa@1.0.10
	jpeg-decoder@0.3.1
	libc@0.2.153
	linux-raw-sys@0.4.13
	log@0.4.20
	matrixmultiply@0.3.8
	memchr@2.7.1
	miniz_oxide@0.7.2
	nalgebra@0.32.3
	nalgebra-glm@0.18.0
	num-complex@0.4.4
	num-integer@0.1.45
	num-rational@0.4.1
	num-traits@0.2.17
	os_str_bytes@6.6.1
	paste@1.0.14
	png@0.17.11
	proc-macro2@1.0.78
	quote@1.0.35
	rawpointer@0.2.1
	regex@1.10.3
	regex-automata@0.4.5
	regex-syntax@0.8.2
	rustix@0.38.31
	ryu@1.0.16
	safe_arch@0.7.1
	scan_fmt@0.2.6
	serde@1.0.196
	serde_derive@1.0.196
	serde_json@1.0.113
	simba@0.8.1
	simd-adler32@0.3.7
	strsim@0.10.0
	syn@1.0.109
	syn@2.0.48
	tempfile@3.10.0
	termcolor@1.4.1
	textwrap@0.16.0
	toml@0.5.11
	typenum@1.17.0
	unicode-ident@1.0.12
	utf8parse@0.2.1
	weezl@0.1.8
	wide@0.7.15
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.6
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows_aarch64_gnullvm@0.52.0
	windows_aarch64_msvc@0.52.0
	windows_i686_gnu@0.52.0
	windows_i686_msvc@0.52.0
	windows-sys@0.52.0
	windows-targets@0.52.0
	windows_x86_64_gnu@0.52.0
	windows_x86_64_gnullvm@0.52.0
	windows_x86_64_msvc@0.52.0
	zip@0.6.6
"

inherit cmake cargo

DESCRIPTION="An STL thumbnail and animation generator "
HOMEPAGE="https://github.com/krepa098/stl2thumbnail_rs"

SRC_URI="
	${CARGO_CRATE_URIS}
	https://github.com/krepa098/stl2thumbnail_rs/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="CC-BY-4.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="kde"
DEPEND="
	!media-gfx/stl2thumbnail
"

RDEPEND="${DEPEND}"

BDEPEND="${RUST_DEPEND}"

DOCS=(
	"README.md"
)

PATCHES=(
	"${FILESDIR}/no_git.patch"
)

src_configure() {
	local mycmakeargs=(
		-DGNOME=yes
		-DKDE=$(usex kde)
		-DDEB=no
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
}

src_install() {
	default
	cmake_src_install
	rm "${D}/usr/lib/libstl2thumbnail.so"
	rm "${D}/usr/include/stl2thumbnail.h"
}
