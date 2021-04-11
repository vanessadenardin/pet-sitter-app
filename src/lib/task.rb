class Task
    attr_reader :description, :status, :switch_task_status
    def initialize(id, description, job_id)
        @id = id
        @description = description
        @status = false # status non-completed
        @job_id = job_id
    end

    # change task status to either complete/non-complete
    def switch_task_status()
        @status = !@status
    end

    # convert class to hash
    def to_hash()
        return {
            id: @id,
            description: @description,
            status: @status,
            job_id: @job_id
        }
    end

end
