# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/emersion/${PN}"

EGO_VENDOR=(
	"github.com/boltdb/bolt v1.3.1"
	"github.com/cloudflare/circl v1.2.0"
	"github.com/emersion/go-bcrypt 6e724a1baa63"
	"github.com/emersion/go-imap v1.2.1"
	"github.com/emersion/go-mbox v1.0.3"
	"github.com/emersion/go-message v0.16.0"
	"github.com/emersion/go-sasl 0b9dcfb154ac"
	"github.com/emersion/go-smtp v0.15.0"
	"github.com/emersion/go-textwrapper 65d896831594"
	"github.com/emersion/go-vcard d4056df0ec4a"
	"github.com/emersion/go-webdav 5d845721d8f7"
	"github.com/emersion/go-ical cd514449c39e"
	"github.com/ProtonMail/go-crypto b76dceea2ffa"
	"golang.org/x/crypto bc19a97f63c8 github.com/golang/crypto"
	"golang.org/x/net e18ecbb05110 github.com/golang/net"
	"golang.org/x/sys 2296e01440c6 github.com/golang/sys"
	"golang.org/x/text v0.3.7 github.com/golang/text"
	"golang.org/x/term a9ba230a4035 github.com/golang/term"
)

inherit golang-base golang-build golang-vcs-snapshot systemd

DESCRIPTION="A third-party, open-source ProtonMail CardDAV, IMAP and SMTP bridge"
HOMEPAGE="https://github.com/emersion/hydroxide"
SRC_URI="https://github.com/emersion/hydroxide/releases/download/v${PV}/${P}.tar.gz
		   ${EGO_VENDOR_URI}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

src_prepare() {
	cd  "src/github.com/emersion/${PN}"
	eapply_user
}

src_compile() {
	EGO_PN="github.com/emersion/${PN}/cmd/${PN}"
	golang-build_src_compile
}

src_install() {
	dobin hydroxide
	systemd_douserunit "${FILESDIR}/${PN}.service"
	dodoc "src/github.com/emersion/${PN}/README.md"
	dodoc "src/github.com/emersion/${PN}/LICENSE"
}
