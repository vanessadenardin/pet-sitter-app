require 'json'
require 'date'

# class to interact with the json file as a database
class Database
    # get first state of all models in the database
    def initialize(database_file)
        @database_file = database_file
        @data = {}
    end

    # convert hash into json and save to file
    def save()
        File.write(@database_file, @data.to_json)
    end
    
    # add info in the json file
    def add(class_name, object)
        @data = get_all()
        
        @data[class_name].push(object.to_hash())
        
        save()
    end

    # edit item in the json file and save
    def edit(class_name, object)
        @data = get_all()
        # go through all items in the file
        @data[class_name].map!{|item|
            if item["id"] == object["id"]
                object
            else
                item
            end
        }
        save()
    end

    # delete item in the json file and save
    def delete(class_name, id)
        @data = get_all()
        for item in @data[class_name]
            if item["id"] == id
                @data[class_name].delete(item)
            end
        end
        save()
    end

    # get item from json file and return it
    def get_by_id(class_name, id)
        @data = get_all()
        for item in @data[class_name]
            if item["id"] == id
                return item
            end
        end
    end

    # get from json file class data
    def get_data(class_name)
        return JSON.parse(File.read(@database_file))[class_name]
        
        # error handling
        rescue Errno::ENOENT
            File.open(@database_file, 'w+')
            File.write(@database_file, [])
            retry
    end

    # get from json file all data
    def get_all()
        return JSON.parse(File.read(@database_file))
        
        # error handling
        rescue Errno::ENOENT
            File.open(@database_file, 'w+')
            File.write(@database_file, [])
            retry
    end

    # get pets client from json using client id and returning it
    def get_pet_list_by_client_id(client_id)
        pet_list = []
        for pet in get_data("pets")
            if client_id == pet["client_id"]
                pet_list.push(pet)
            end
        end

        return pet_list
    end

    # get tasks list of the jobs from json using job id and returning it
    def get_task_list_by_job_id(job_id)
        list_tasks = []
        for task in get_data("tasks")
            if job_id == task["job_id"]
                list_tasks.push(task)
            end
        end

        return list_tasks
    end

    # get jobs from json using difference of job date and local date now
    # returning jobs for next 7 days
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
        @data = get_all()
        # if array is empty return first id 0
        if @data[class_name].length == 0
            return 0
        end

        # go to last item of the array, get the id and sum +1
        return @data[class_name][-1]["id"] + 1
    end

    # get jobs list from json using client id and returning it
    def get_jobs_by_client_id(client_id)
        jobs = []
        for job in get_data("jobs")
            if client_id == job["client_id"]
                jobs.push(job)
            end
        end

        return jobs
    end
end
