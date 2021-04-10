class Task

    def initialize(id, description, job_id)
        @id = id
        @description = description
        @status = false # status non-completed
        @job_id = job_id
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
