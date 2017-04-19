CLIENT=webclient
SERVER=my-stories

export RESOURCES=$(SERVER)/resources/public

client:
	$(MAKE) -C $(CLIENT) build

server: client
	cd $(SERVER) && lein uberjar
