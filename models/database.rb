require 'json'

# class to interact with the json file as a database
class Database
    attr_reader :data, :clients, :jobs, :pets, :pet_sitters
    
    # get first state of all models in the database
    def initialize(database_file)
        @database_file = database_file
        @data = get_data()
        @clients = get_clients()
        @jobs = get_jobs()
        @pets = get_pets()
        @pet_sitters = get_pet_sitters()
        @tasks = get_tasks()
    end

    # get datas from db
    def get_data()
        return JSON.parse(File.read(@database_file))
        
        rescue Errno::ENOENT
            File.open(@database_file, 'w+')
            File.write(@database_file, [])
            retry
    end

    def get_clients()
        return get_data()["clients"]
    end

    def get_jobs()
        return get_data()["jobs"]
    end

    def get_pets()
        return get_data()["pets"]
    end

    def get_pet_sitters()
        return get_data()["pet_sitters"]
    end

    def get_tasks()
        return get_data()["tasks"]
    end
    # end get data

    # saving data on json
    def add(class_name, object)
        @data = get_data()
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

        File.write(@database_file, @data.to_json)
    end

    def edit(class_name, object)
        @data = get_data()
        @data[class_name] = object
        File.write(@database_file, @data.to_json)
    end

    def delete(class_name, id)
        @data = get_data()
        for item in @data[class_name]
            if item["id"] == id
                @data[class_name].delete(item)
            end
        end
        File.write(@database_file, @data.to_json)
    end

    def get_by_id(class_name, id)
        @data = get_data()
        for item in @data[class_name]
            if item["id"] == id
                return item
            end
        end

        @data[class_name] = object
        File.write(@database_file, @data.to_json)
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
