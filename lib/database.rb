require 'json'

# class to interact with the json file as a database
class Database
    # get first state of all models in the database
    def initialize(database_file)
        @database_file = database_file
        @data = []
    end

    def save()
        File.write(@database_file, @data.to_json)
    end
    
    def add(class_name, object)
        @data = get_all()
        object["id"] = get_new_id(class_name)
        found = false
        for item in @data[class_name]
            if item["id"] == object["id"]
                found = true
            end
        end
        if !found
            @data[class_name].push(object)
        end 
        save()
    end

    def edit(class_name, object)
        @data = get_all()
        @data[class_name] = object
        save()
    end

    def delete(class_name, id)
        @data = get_all()
        for item in @data[class_name]
            if item["id"] == id
                @data[class_name].delete(item)
            end
        end
        save()
    end

    def get_by_id(class_name, id)
        @data = get_all()
        for item in @data[class_name]
            if item["id"] == id
                return item
            else
                return false
            end
        end
    end

    def get_all(class_name)
        return JSON.parse(File.read(@database_file))[class_name]
        
        rescue Errno::ENOENT
            File.open(@database_file, 'w+')
            File.write(@database_file, [])
            retry
    end

    # find latest id used and return one more
    def get_new_id(class_name)
        # if array is empty return first id 0
        if @data[class_name].length == 0
            return 0
        end

        # go to last item of the array, get the id and sum +1
        return @data[class_name][-1]["id"] + 1
    end
end
