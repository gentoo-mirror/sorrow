# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="simple configuration format"
HOMEPAGE="https://sr.ht/~emersion/libscfg"

inherit git-r3
EGIT_REPO_URI="https://git.sr.ht/~emersion/libscfg"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
