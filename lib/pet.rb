class Pet

    def initialize(id, name, age, type, observations, client_id)
        @id = id
        @name = name
        @age = age
        @type = type
        @observations = observations
        @client_id = client_id
    end

    # convert class to hash
    def to_hash()
        return {
            id: @id,
            name: @name,
            age: @age,
            type: @type,
            observations: @observations,
            client_id: @client_id
        }
    end

end
