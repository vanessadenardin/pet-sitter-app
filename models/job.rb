class Job
    attr_reader :list_task

    def initialize(id, date, client_id, list_task)

        @id = id
        @date = date
        @client_id = client_id
        @list_task = list_task
    end

end
