# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit flag-o-matic git-r3

EGIT_REPO_URI="https://github.com/andmarti1424/sc-im.git"
EGIT_BRANCH="origin/HEAD"
EGIT_COMMIT="HEAD"
EGIT_CHECKOUT_DIR="${S}"

SRC_URI=""


DESCRIPTION="A CLI-driven spreadsheet application; fork of SC"
HOMEPAGE="https://github.com/andmarti1424/sc-im"


LICENSE="LGPL-2.1"
SLOT="1"
IUSE="+less +vim +tmux xlsreader xlsxwriter gnuplot lua examples"


COMMON_DEPEND="
	>=sys-libs/ncurses-5.2[unicode]
"
DEPEND="
	virtual/pkgconfig
"
RDEPEND="
	${COMMON_DEPEND}
	less? ( sys-apps/less )
	vim? ( app-editors/vim )
	tmux? ( app-misc/tmux )
	xlsreader? (
		dev-libs/libxls
		dev-libs/libzip
		dev-libs/libxml2
	)
	xlsxwriter? ( dev-libs/libxlsxwriter )
	gnuplot? ( sci-visualization/gnuplot )
	lua? ( =dev-lang/lua-5.1* )
"

src_unpack() {
	git-r3_src_unpack
}

src_compile() {
	cd "${S}/src"
	use xlsreader && append-cppflags "-DXLS" && export LDLIBS="-lxlsreader"
	emake
}

src_install() {
	cd "${S}/src"
	emake DESTDIR="${D}" install
	if `usex examples true`; then
                dodoc -r "${S}/examples"
        fi
}
