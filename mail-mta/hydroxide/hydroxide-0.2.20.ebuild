# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/emersion/${PN}"

EGO_VENDOR=(
	"github.com/boltdb/bolt v1.3.1"
	"github.com/emersion/go-bcrypt 6e724a1baa63"
	"github.com/emersion/go-imap v1.1.0"
	"github.com/emersion/go-imap-move 6e5a51a5b342"
	"github.com/emersion/go-imap-specialuse 1ab93d3d150e"
	"github.com/emersion/go-mbox v1.0.2"
	"github.com/emersion/go-message v0.15.0"
	"github.com/emersion/go-sasl 7bfe0ed36a21"
	"github.com/emersion/go-smtp v0.15.0"
	"github.com/emersion/go-textwrapper 65d896831594"
	"github.com/emersion/go-vcard 3445b9171995"
	"github.com/emersion/go-webdav v0.3.0"
	"github.com/emersion/go-ical cd514449c39e"
	"github.com/howeyc/gopass 7cb4b85ec19c"
	"github.com/martinlindhe/base36 v1.1.0"
	"github.com/ProtonMail/go-crypto 52430bf6b52c"
	"golang.org/x/crypto a769d52b0f97 github.com/golang/crypto"
	"golang.org/x/net e18ecbb05110 github.com/golang/net"
	"golang.org/x/sys 0f9fa26af87c github.com/golang/sys"
	"golang.org/x/text v0.3.6 github.com/golang/text"
	"golang.org/x/term 6886f2dfbf5b github.com/golang/term"
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
