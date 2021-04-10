DB_FILE=database.json
USERNAME?=admin
PASSWORD?=123456
TESTS_FILE?=ruby_petsitter_spec.rb
APP_FILE?=ruby_petsitter_app.rb

gems-install:
	@bundler install

seed-database:
	@echo "{\"tasks\": [],\"jobs\": [],\"pets\": [],\"clients\": [],\"pet_sitters\": [{\"id\": 0,\"name\": \"Vanessa\",\"contact\": \"admin@admin.com\",\"username\": \"${USERNAME}\",\"password\": \"${PASSWORD}\",\"post_code\": 3000,\"abn\": 123456}]}" > ${DB_FILE}
	@echo "Database file created ${DB_FILE} successfully"

install: gems-install seed-database

test:
	rspec ${TESTS_FILE}

run:
	ruby ${APP_FILE}
