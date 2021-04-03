require_relative './models/client'
require_relative './models/pet_sitter'
require_relative './models/database'
database_file = File.join(File.dirname(__FILE__), 'database.json')

db = Database.new(database_file)

pets = db.pets

# db.add("pets", {
#     name: "Guri",
#     age: 5,
#     observations: "",
#     type: "cat"
# })
# db.update_pets(pets)

# print db.pets
print db.get_by_id("pets", 0)


