require_relative './lib/app.rb'

database_file = File.join(File.dirname(__FILE__), 'database.json')
app = App.new(database_file)
app.run
