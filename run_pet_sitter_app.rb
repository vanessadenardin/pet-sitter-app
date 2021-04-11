require 'pet_sitter_app'

database_file = File.join(File.dirname(__FILE__), 'database.json')
app = App.new(database_file)
app.run
