# Author: Thomas Backlund
# github.com/thomasbacklund/AngularJS-Make
# MIT license
#
BUILDDIR = build
COMMON = common
COMPONENTS = ng
COMPONENTS_BUILD = $(BUILDDIR)
bold=`tput bold; tput setab 1`
normal=`tput sgr0`

TMP_FILE := $(shell mktemp -u /tmp/maketmp.XXXXXXXXX)

default: components

all: clean components

components: dep_check components_dir components_js components_cache components_less index

dep_check:

clean:
	rm -rf $(BUILDDIR)

components_js: components_jslint
	@echo "/* DO NOT EDIT. THIS IS A GENERATED FILE */" > $(COMPONENTS_BUILD)/app.js
	find $(COMMON) -type f -name "*.js" -exec cat {} \; >> $(COMPONENTS_BUILD)/app.js
	./tools/transform-ng-js.sh app-modules.js >> $(COMPONENTS_BUILD)/app.js
	find $(COMPONENTS) -type f -name "*.js" -exec ./tools/transform-ng-js.sh {} \; >> $(COMPONENTS_BUILD)/app.js
	./tools/transform-ng-js.sh app-config.js >> $(COMPONENTS_BUILD)/app.js

components_jslint:
	@command -v jshint >/dev/null 2>&1 || { echo -e >&2 "jshint not installed globally. Try:\nsudo npm install -g jshint"; exit 1; }
	@echo $(bold); jshint $(COMMON) ./*.js $(COMPONENTS) && echo $(normal) || (echo $(normal); exit 1)

components_cache:
	@echo "/* DO NOT EDIT. THIS IS A GENERATED FILE */" > $(COMPONENTS_BUILD)/app.cache.js
	find $(COMPONENTS) -type f -name "*.html" -exec ./tools/transform-template.sh {} \; >> $(COMPONENTS_BUILD)/app.cache.js

components_css:
	@echo "/* DO NOT EDIT. THIS IS A GENERATED FILE */" > $(COMPONENTS_BUILD)/app.css
	find $(COMMON) -type f -name "*.css" -exec cat {} \; >> $(COMPONENTS_BUILD)/app.css
	find $(COMPONENTS) -type f -name "*.css" -exec cat {} \; >> $(COMPONENTS_BUILD)/app.css

components_less: components_css
	@command -v lessc >/dev/null 2>&1 || { echo -e >&2 "Less compiler (lessc)  not installed globally. Try:\nsudo npm install -g less"; exit 1; }
	find $(COMMON) -type f -name "*.less" -exec cat {} \; > $(TMP_FILE)
	find $(COMPONENTS) -type f -name "*.less" -exec cat {} \; >> $(TMP_FILE)
	lessc $(TMP_FILE) >> $(COMPONENTS_BUILD)/app.css
	rm $(TMP_FILE)

components_dir:
	mkdir -p $(COMPONENTS_BUILD)
	[ -h $(shell pwd)/build/bower_components ] || ln -s $(shell pwd)/bower_components $(shell pwd)/build/bower_components
	[ -h $(shell pwd)/build/static ] || ln -s $(shell pwd)/static $(shell pwd)/build/static

index:
	cp index.html build/index.html

dist:
	# Make a dist version of the build version.
	# TODO

watch:
	./watch.sh

serve:
	./serve.sh

new-controller:
	./tools/new-controller.sh $(module) $(dir) $(name)

new-directive:
	./tools/new-directive.sh $(module) $(dir) $(name)

new-factory:
	./tools/new-factory.sh $(module) $(dir) $(name)

.PHONY: components components_dir components_js components_cache components_less components_css dep_check watch index components_jslint serve new_controller new_directive
