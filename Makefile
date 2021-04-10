DB_FILE?=database.json

gems-install:
	bundler install

seed-database:
	echo "{\"tasks\": [],\"jobs\": [],\"pets\": [],\"clients\": [],\"pet_sitters\": [{\"id\": 0,\"name\": \"Vanessa\",\"contact\": \"admin@admin.com\",\"username\": \"admin\",\"password\": \"123456\",\"post_code\": 3000,\"abn\": 123456}]}" > ${DB_FILE}

install: gems-install seed-database
