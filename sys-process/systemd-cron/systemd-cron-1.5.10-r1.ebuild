# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python3_{2,3,4} )

inherit cron python-single-r1 multilib user

DESCRIPTION="systemd units to run cron scripts"
HOMEPAGE="https://github.com/systemd-cron/systemd-cron"
SRC_URI="https://github.com/systemd-cron/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

REQIRED_USE="${PYTHON_REQIRED_USE}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+boot +persistent yearly minutely quarterly semi_annually +setgid"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	>=sys-apps/systemd-197
	yearly? ( >=sys-apps/systemd-209 )
	persistent? ( >=sys-apps/systemd-212 )
	minutely? ( >=sys-apps/systemd-217 )
	quarterly? ( >=sys-apps/systemd-217 )
	semi_annually? ( >=sys-apps/systemd-217 )
	sys-apps/debianutils
"

CRON_SYSTEM_CRONTAB="yes"
local_use_enable()
{
	local UE_SUFFIX=${3:+=$3}
	local UWORD=${2:-$1}
	if use $1; then
		echo "--enable-${UWORD}${UE_SUFFIX}=yes"
	else
		echo "--enable-${UWORD}${UE_SUFFIX}=no"
	fi
}

src_configure()
{
	./configure \
		--prefix="${EPREFIX}/usr" \
		--confdir="${EPREFIX}/etc" \
		--runparts="${EPREFIX}/bin/run-parts" \
		--libdir="${EPREFIX}/$(get_libdir)" \
		$(local_use_enable boot) \
		$(local_use_enable persistent) \
		$(local_use_enable yearly) \
		$(local_use_enable minutely) \
		$(local_use_enable quarterly) \
		$(local_use_enable semi_annually)\
		$(local_use_enable setgid)
}

src_install()
{
	default
	for u in boot yearly minutely quarterly semi_annually
	do
		if use ${u}
		then
			diropts -m0750;
			keepdir "${EPREFIX}/etc/cron.${u}"
		fi
	done
	if use setgid
	then
		fowners root:cron "${EPREFIX}/$(get_libdir)/systemd-cron/crontab_setgid"
		fperms 2755 "${EPREFIX}/$(get_libdir)/systemd-cron/crontab_setgid"
		diropts -m1730 -oroot -g cron; keepdir "${EPREFIX}/var/spool/cron/crontabs"
	fi
}

pkg_setup()
{
	if use setgid
	then
		cd "${EPREFIX}/var/spool/cron/crontabs"
		ls -1 | xargs -r -n 1 --replace=xxx  chown 'xxx:cron' 'xxx'
		ls -1 | xargs -r -n 1 chmod 600
	fi
}
