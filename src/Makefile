DB_FILE=database.json
USERNAME?=admin
PASSWORD?=123456
TESTS_FOLDER?=tests
APP_FILE?=run_pet_sitter_app.rb
APP_NAME?=pet_sitter_app
VERSION?=1.0.0

test:
	rspec ${TESTS_FOLDER}/*

install: seed-database gems-install

exec:
	ruby ${APP_FILE}

build:
	docker build -t ${APP_NAME}:${VERSION} .

run:
	docker run -it -v ${PWD}/${DB_FILE}:/app/${DB_FILE} ${APP_NAME}:${VERSION}

gems-install:
	@echo "Installing all gems"
	@bundle install
	@echo "Building application as local gem"
	@gem build ${APP_NAME}
	@echo "Install local gem built"
	@gem install ./${APP_NAME}-${VERSION}.gem

seed-database:
	@echo "{\"tasks\": [],\"jobs\": [],\"pets\": [],\"clients\": [],\"pet_sitters\": [{\"id\": 0,\"name\": \"Vanessa\",\"contact\": \"admin@admin.com\",\"username\": \"${USERNAME}\",\"password\": \"${PASSWORD}\",\"post_code\": 3000,\"abn\": 123456}]}" > ${DB_FILE}
	@echo "Database file created ${DB_FILE} successfully"
