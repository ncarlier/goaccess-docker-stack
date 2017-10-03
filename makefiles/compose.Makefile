.SILENT :

COMPOSE_FILES?=-f docker-compose.yml

# Wait until a service ($$service) is up and running (needs health run flag)
compose-wait:
	sid=`docker-compose $(COMPOSE_FILES) ps -q $(service)`;\
	n=30;\
	while [ $${n} -gt 0 ] ; do\
		status=`docker inspect --format "{{json .State.Health.Status }}" $${sid}`;\
		if [ -z $${status} ]; then echo "No status informations."; exit 1; fi;\
		echo "Waiting for $(service) up and ready ($${status})...";\
		if [ "\"healthy\"" = $${status} ]; then exit 0; fi;\
		sleep 2;\
		n=`expr $$n - 1`;\
	done;\
	echo "Timeout" && exit 1
.PHONY: compose-wait

# Build services
compose-build:
	echo "Building services ..."
	docker-compose $(COMPOSE_FILES) build $(service)
.PHONY: conspose-build

# Config a service ($$service)
compose-config: compose-wait
	echo "Configuring $(service)..."
	$(MAKE) config-$(service)
.PHONY: compose-config

# Deploy compose stack
compose-up:
	echo "Deploying compose stack..."
	-cat .env
	docker-compose $(COMPOSE_FILES) up -d
	echo "Congrats! Compose stack deployed."

# Un-deploy compose stack
compose-down:
	echo "Un-deploying compose stack..."
	docker-compose $(COMPOSE_FILES) down
	echo "Compose stack un-deployed."

# Stop a service ($$service)
compose-stop:
	echo "Stoping service: $(service) ..."
	docker-compose $(COMPOSE_FILES) stop $(service)
.PHONY: compose-stop

# Stop a service ($$service)
compose-start:
	echo "Starting service: $(service) ..."
	docker-compose $(COMPOSE_FILES) up -d $(service)
.PHONY: compose-start

# Restart a service ($$service)
compose-restart:
	echo "Restarting service: $(service) ..."
	docker-compose $(COMPOSE_FILES) restart $(service)
.PHONY: compose-restart

# View service logs ($$service)
compose-logs:
	echo "Viewing $(service) service logs ..."
	docker-compose $(COMPOSE_FILES) logs -f $(service)
.PHONY: compose-logs

# View services status
compose-status:
	echo "Viewing services status ..."
	docker-compose $(COMPOSE_FILES) ps
.PHONY: compose-status

# Remove dangling Docker images
compose-cleanup:
	echo "Removing dangling docker images..."
	-docker images -q --filter 'dangling=true' | xargs docker rmi

