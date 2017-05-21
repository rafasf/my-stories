DBC_NAME=my-stories-db

install: db

db: db-container
	docker start my-stories-db

db-container:
	@if [ ! "`docker ps -a -q -f name=$(DBC_NAME)`" ]; then \
		echo "creating...."; \
		docker build -t my-stories-postgres -f ../support/Dockerfile-postgres ../support/; \
		docker create --name=$(DBC_NAME) -p 5432:5432 my-stories-postgres; \
	else \
		echo 'Database container already exist, skipping creation.'; \
	fi

.PHONY: install
