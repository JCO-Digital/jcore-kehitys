theme := wp-content/themes/ilme
MODULES := modules
CMD := make

all: install build

install:
	composer install
	cd $(theme); npm ci
	@find $(MODULES) -maxdepth 1 -mindepth 1 -type d | while read dir; do \
		echo "Installing in $$dir"; \
		cd $$dir; \
		$(CMD); \
		cd -; \
	done
build:
	cd $(theme); npm run build

watch:
	cd $(theme); npm run watch

clean:
	rm -rf $(theme)/dist
	rm -rf $(theme)/node_modules
	rm -rf node_modules
	rm -rf vendor
