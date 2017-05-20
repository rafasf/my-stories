CLIENT=webclient
SERVER=my-stories

export RESOURCES=$(SERVER)/resources/public

client:
	$(MAKE) -C $(CLIENT) build

server: client
	cd $(SERVER) && lein ring uberjar

only-assemble:
	cd $(SERVER) && lein ring uberjar

run:
	cd $(SERVER) && lein ring server
