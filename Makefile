theme := wp-content/themes/ilme
lohko := wp-content/plugins/lohko
maailma := wp-content/plugins/jcore-maailma
portti := wp-content/plugins/jcore-portti
.PHONY: all dev ci ci-install install build watch watch-theme watch-lohko clean

all: install build

dev: install watch

ci: ci-install build

ci-install:
	composer install --no-dev --no-interaction --optimize-autoloader
	pnpm i

install:
	composer install
	pnpm i

build:
	cd $(theme) && ${MAKE} build
	cd $(lohko) && ${MAKE} build
	cd $(maailma) && ${MAKE} build
	cd $(portti) && ${MAKE} build

watch:
	${MAKE} -j 3 watch-theme watch-lohko watch-ruudukko

watch-theme:
	cd $(theme) && ${MAKE} watch

watch-lohko:
	cd $(lohko) && ${MAKE} watch

clean:
	cd $(theme) && ${MAKE} clean
	cd $(lohko) && ${MAKE} clean
	cd $(maailma) && ${MAKE} clean
	cd $(portti) && ${MAKE} clean
	rm -rf node_modules
	rm -rf vendor
