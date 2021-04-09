class Job
    attr_reader :id

    def initialize(id, date, client_id)
        @id = id
        @date = date
        @client_id = client_id
    end

    def to_hash()
        return {
            id: @id,
            date: @date,
            client_id: @client_id
        }
    end
end


