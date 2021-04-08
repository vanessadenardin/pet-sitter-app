class Job
    def initialize(date, client_id, list_tasks)
        @id = -1
        @date = date
        @client_id = client_id
        @list_tasks = list_tasks
    end

    def update_id(id)
        @id = id
    end

    def to_hash()
        return {
            id: @id,
            date: @date,
            client_id: @client_id,
            list_tasks: @list_tasks
        }
    end
    # def add_task(list_tasks)
    #     task = Job.new(id, date, client_id, list_tasks)
    #     @list_tasks = list_task
    # end

end


