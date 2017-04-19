NM=node_modules/.bin

build: test
	elm-make src/App.elm --output=../$(RESOURCES)/app.js

test:
	$(NM)/elm-test
