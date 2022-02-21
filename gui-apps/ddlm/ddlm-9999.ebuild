# Copyright 2022 Sorrow
# Distributed under the terms of the GNU General Public License v3

EAPI=8

inherit cargo git-r3

DESCRIPTION="deathowl's dummy login manager"
HOMEPAGE="https://github.com/deathowl/ddlm"

EGIT_REPO_URI="https://github.com/deathowl/${PN}.git"

KEYWORDS="~amd64 ~arm ~arm64 ~x86"
LICENSE="ddlm-EULA"
SLOT="0"
IUSE=""

BDEPEND="
	virtual/rust
"
DEPEND=""
RDEPEND="
	gui-libs/greetd
"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_install() {
	cargo_src_install
	dodoc "README.md"
}
