class Pet
    # attr_accessor :id
    #  :name, :type

    def initialize(id, name, age, type, observations, client_id)
        @id = id
        @name = name
        @age = age
        @type = type
        @observations = observations
        @client_id = client_id
    end

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
