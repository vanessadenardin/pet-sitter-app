$database_file = "../database.json"
require 'json'

module Db
    def add(object)
        # File.open(database_file, "w") do |f|
        #     f.write
        # end
        puts get_db_object()
    end

    def get(id)

    end

    def get_all()
        return @id

    end

    def delete(id)

    end

    def update(object)
        
    end

    def get_db_object()
        print $database_file

        file = File.read($database_file)
        a = JSON.parse(file)
        return a
    end
    
end
