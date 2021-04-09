class Pet
    # attr_accessor :id
    #  :name, :type

    def initialize(name, age, type, observations,client_id)
        @id = -1
        @name = name
        @age = age
        @type = type
        @observations = observations
        @client_id = client_id
    end

    def update_id(id)
        @id = id
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
