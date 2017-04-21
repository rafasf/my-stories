NM=`pwd`/node_modules/.bin

build: test css
	$(NM)/elm-make src/App.elm --output=../$(RESOURCES)/app.js

test: install
	$(NM)/elm-test --compiler $(NM)/elm-make


css: install
	$(NM)/node-sass \
		--include-path styles/ \
		--output-style compressed \
		styles/styles.scss > ../$(RESOURCES)/styles.css

install: elm-stuff
	@echo "Everything is in place, moving on..."

node_modules:
	npm install

elm-stuff: node_modules
	$(NM)/elm-package install -y
