pkgver=20201212
pkgname=bmake
bad=""
ext="doc"

fetch() {
	curl http://www.crufty.net/ftp/pub/sjg/bmake-20201212.tar.gz -o $pkgname-$pkgver.tar.gz
	tar -xf $pkgname-$pkgver.tar.gz
	mv $pkgname $pkgname-$pkgver
	cd $pkgname-$pkgver
	patch ./boot-strap < ../../no-test.patch
}

build() {
	cd $pkgname-$pkgver
	./configure --prefix=/
	sh ./make-bootstrap.sh
}

package() {
	cd $pkgname-$pkgver
	./bmake -m ./mk install DESTDIR=$pkgdir
	rm -r $pkgdir/share/man
}

package_doc() {
	cd $pkgname-$pkgver
	./bmake -m ./mk install DESTDIR=$pkgdir
	rm -r $pkgdir/bin
	rm -r $pkgdir/share/mk
}

license() {
	cd $pkgname-$pkgver
	cat LICENSE
}
