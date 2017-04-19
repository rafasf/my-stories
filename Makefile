CLIENT=webclient
SERVER=my-stories

RESOURCES=$(SERVER)/src/resources/public

NM=$(CLIENT)/node_modules/.bin

client:
	cd $(CLIENT) && \
	elm-make src/App.elm --output=../$(RESOURCES)/elm.js

server: client
	cd $(SERVER) && lein uberjar
