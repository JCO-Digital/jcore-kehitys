theme := wp-content/themes/ilme
lohko := wp-content/plugins/lohko

all: install build

ci: install build

update-modules:
	git submodule sync --recursive
	git submodule update --init --recursive --remote

install:
	composer install
	cd $(theme); pnpm i
	cd $(lohko); pnpm i

build:
	cd $(theme); pnpm run build
	cd $(lohko); pnpm run build

watch: dev

dev:
	cd $(theme); pnpm run watch

clean:
	rm -rf $(theme)/dist
	rm -rf $(theme)/node_modules
	rm -rf node_modules
	rm -rf vendor
