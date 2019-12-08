# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/emersion/${PN}"

EGO_VENDOR=(
	"github.com/boltdb/bolt v1.3.1"
	"github.com/emersion/go-bcrypt 6e724a1baa63"
	"github.com/emersion/go-imap v1.0.0"
	"github.com/emersion/go-imap-move 6e5a51a5b342"
	"github.com/emersion/go-imap-specialuse ba031ced6a62"
	"github.com/emersion/go-message v0.10.7"
	"github.com/emersion/go-textwrapper d0e65e56"
	"github.com/emersion/go-sasl 240c8404624e"
	"github.com/emersion/go-smtp v0.11.2"
	"github.com/emersion/go-vcard 8856043f13c5"
	"github.com/emersion/go-webdav 4ef680e9a32f"
	"github.com/martinlindhe/base36 v1.0.0"
	"github.com/howeyc/gopass bf9dde6d0d2c"
	"github.com/kr/pretty v0.1.0"
	"github.com/stretchr/testify v1.4.0"
	"golang.org/x/crypto 9756ffdc2472 github.com/golang/crypto"
	"golang.org/x/net ba9fcec4b297 github.com/golang/net"
	"golang.org/x/sys 1e83adbbebd0 github.com/golang/sys"
	"golang.org/x/text v0.3.0 github.com/golang/text"
	"gopkg.in/check.v1 788fd7840127 github.com/go-check/check"
)

inherit golang-base golang-build golang-vcs-snapshot

DESCRIPTION="A third-party, open-source ProtonMail CardDAV, IMAP and SMTP bridge"
HOMEPAGE="https://github.com/emersion/hydroxide"
SRC_URI="https://github.com/emersion/hydroxide/releases/download/v${PV}/${P}.tar.gz
		   ${EGO_VENDOR_URI}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

src_compile() {
	export EGO_PN="github.com/emersion/${PN}/cmd/${PN}"
	golang-build_src_compile
}

src_install() {
	dobin hydroxide
}
