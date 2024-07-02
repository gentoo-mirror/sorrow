# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/emersion/${PN}"

EGO_VENDOR=(
	"github.com/boltdb/bolt v1.3.1"
	"github.com/cloudflare/circl v1.3.7"
	"github.com/teambition/rrule-go v1.8.2"
	"github.com/emersion/go-bcrypt 6e724a1baa63"
	"github.com/emersion/go-imap v1.2.1"
	"github.com/emersion/go-mbox v1.0.3"
	"github.com/emersion/go-message v0.18.1"
	"github.com/emersion/go-sasl e73c9f7bad43"
	"github.com/emersion/go-smtp v0.21.1"
	"github.com/emersion/go-textwrapper 65d896831594"
	"github.com/emersion/go-vcard 8fda7d206ec9"
	"github.com/emersion/go-webdav v0.5.0"
	"github.com/emersion/go-ical 0864dccc089f"
	"github.com/ProtonMail/go-crypto v1.0.0"
	"golang.org/x/crypto v0.22.0 github.com/golang/crypto"
	"golang.org/x/net v0.21.0 github.com/golang/net"
	"golang.org/x/sys v0.19.0 github.com/golang/sys"
	"golang.org/x/text v0.14.0 github.com/golang/text"
	"golang.org/x/term v0.19.0 github.com/golang/term"
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
