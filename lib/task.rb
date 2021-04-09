class Task

    def initialize(description, job_id)
        @id = -1
        @description = description
        @status = false # status non-completed
        @job_id = job_id
    end

    def update_id(id)
        @id = id
    end

    def to_hash()
        return {
            id: @id,
            description: @description,
            status: @status,
            job_id: @job_id
        }
    end

end
