# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/emersion/${PN}"

EGO_VENDOR=(
	"github.com/boltdb/bolt v1.3.1"
	"github.com/emersion/go-bcrypt 6e724a1baa63"
	"github.com/emersion/go-imap v1.0.4"
	"github.com/emersion/go-imap-move 6e5a51a5b342"
	"github.com/emersion/go-imap-specialuse ba031ced6a62"
	"github.com/emersion/go-message v0.11.1"
	"github.com/emersion/go-sasl 430746ea8b9b"
	"github.com/emersion/go-smtp v0.12.1"
	"github.com/emersion/go-textwrapper d0e65e56babe"
	"github.com/emersion/go-vcard 5f81fa0d3cc7"
	"github.com/emersion/go-webdav 3ea3818dd842"
	"github.com/emersion/go-ical cd514449c39e"
	"github.com/howeyc/gopass 7cb4b85ec19c"
	"github.com/kr/pretty v0.1.0"
	"github.com/martinlindhe/base36 v1.0.0"
	"github.com/stretchr/testify v1.4.0"
	"golang.org/x/crypto 11f6ee2dd602 github.com/ProtonMail/crypto"
	"golang.org/x/net eb5bcb51f2a3 github.com/golang/net"
	"golang.org/x/sys d5e6a3e2c0ae github.com/golang/sys"
	"golang.org/x/text v0.3.2 github.com/golang/text"
	"gopkg.in/check.v1 788fd7840127 github.com/go-check/check"
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
