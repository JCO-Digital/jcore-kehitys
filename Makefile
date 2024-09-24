theme := wp-content/themes/ilme
ydin := modules/jcore-ydin
blocks := modules/jcore-blocks
dynamic := modules/jcore-dynamic-archive

all: install build

ci: install build

update-modules:
	git submodule sync --recursive
	git submodule update --init --recursive --remote

install:
	cd $(ydin); composer install
	cd $(blocks); composer install
	cd $(dynamic); composer install
	composer install
	cd $(theme); pnpm i

build:
	cd $(theme); pnpm run build

watch:
	cd $(theme); pnpm run watch

clean:
	rm -rf $(theme)/dist
	rm -rf $(theme)/node_modules
	rm -rf node_modules
	rm -rf vendor
