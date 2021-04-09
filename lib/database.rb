require 'json'
require 'date'

# class to interact with the json file as a database
class Database
    # get first state of all models in the database
    def initialize(database_file)
        @database_file = database_file
        @data = {}
    end

    def save()
        File.write(@database_file, @data.to_json)
    end
    
    def add(class_name, object)
        @data = get_all()
        
        id = get_new_id(class_name)
        object.update_id(id)
        
        @data[class_name].push(object.to_hash())
        
        save()
    end

    def edit_pet(class_name, object)
        @data = get_all()
        # go through all items in the file
        for item in @data[class_name]
            # if match the ID of the edit object - replace existing one
            if item["id"] == object["id"]
                # update existing values (item) from the edited pet (object)
                item["name"] = object["name"]
                item["age"] = object["age"]
                item["observations"] = object["observations"]
                # item = object
                
            end
        end
        save()
    end

    def edit_client(class_name, object)
        @data = get_all()
        # go through all items in the file
        for item in @data[class_name]
            # if match the ID of the edit object - replace existing one
            if item["id"] == object["id"]
                # update existing values (item) from the edited pet (object)
                item["name"] = object["name"]
                item["contact"] = object["contact"]
                item["post_code"] = object["post_code"]
                # item = object
                
            end
        end
        save()
    end

    def edit_task(class_name, object)
        @data = get_all()
        # go through all items in the file
        for item in @data[class_name]
            # if match the ID of the edit object - replace existing one
            if item["id"] == object["id"]
                # update existing values (item) from the edited pet (object)
                item["description"] = object["description"]
                item["status"] = object["status"]
                
            end
        end
        save()
    end
    
    def edit_job(class_name, object)
        @data = get_all()
        # go through all items in the file
        for item in @data[class_name]
            # if match the ID of the edit object - replace existing one
            if item["id"] == object["id"]
                # update existing values (item) from the edited pet (object)
                item["date"] = object["date"]
                # item = object
                
            end
        end
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
            end
        end
    end

    def get_data(class_name)
        return JSON.parse(File.read(@database_file))[class_name]
        
        rescue Errno::ENOENT
            File.open(@database_file, 'w+')
            File.write(@database_file, [])
            retry
    end

    def get_all()
        return JSON.parse(File.read(@database_file))
        
        rescue Errno::ENOENT
            File.open(@database_file, 'w+')
            File.write(@database_file, [])
            retry
    end

    def get_pet_list_by_client_id(client_id)
        pet_list = []
        for pet in get_data("pets")
            if client_id == pet["client_id"]
                pet_list.push(pet)
            end
        end

        return pet_list
    end

    def get_task_list_by_job_id(job_id)
        list_tasks = []
        for task in get_data("tasks")
            if job_id == task["job_id"]
                list_tasks.push(task)
            end
        end

        return list_tasks
    end

    def get_jobs_last_7_days()
        @data = get_all()
        now = Time.now.to_date
        jobs = []
        for job in @data["jobs"]
            parsed_date = Date.strptime(job["date"], "%d/%m/%Y")
            days_difference = (parsed_date - now).to_i
            if days_difference <= 7 && days_difference >= 0
                jobs.push(job)
            end
        end
        return jobs
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
