class Job
    attr_reader :list_tasks

    def initialize(id, date, client_id, list_task)
        @id = id
        @date = date
        @client_id = client_id
        @list_tasks = list_task
    end

    # def add_task(list_tasks)
    #     task = Job.new(id, date, client_id, list_tasks)
    #     @list_tasks = list_task
    # end

end


