theme := wp-content/themes/ilme
MODULES := modules
CMD := make

all: install build

install:
	git submodule update --init --recursive --remote
	composer install
	# First we check if pnpm is installed, if not we use corepack to install it
	pnpm --version || corepack enable
	cd $(theme); pnpm install
	@find $(MODULES) -maxdepth 1 -mindepth 1 -type d | while read dir; do \
		echo "Installing in $$dir"; \
		cd $$dir; \
		$(CMD); \
		cd -; \
	done
build:
	cd $(theme); pnpm run build

watch:
	cd $(theme); pnpm run watch

clean:
	rm -rf $(theme)/dist
	rm -rf $(theme)/node_modules
	rm -rf node_modules
	rm -rf vendor
	@find $(MODULES) -maxdepth 1 -mindepth 1 -type d | while read dir; do \
		echo "Deleting modules in $$dir"; \
		cd $$dir; \
		rm -rf vendor; \
		cd -; \
	done
