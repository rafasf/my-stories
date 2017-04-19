NM=node_modules/.bin

build: test css
	elm-make src/App.elm --output=../$(RESOURCES)/app.js

test:
	$(NM)/elm-test

css:
	$(NM)/node-sass \
		--include-path styles/ \
		--output-style compressed \
		styles/styles.scss > ../$(RESOURCES)/styles.css
