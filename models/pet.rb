class Pet
    attr_reader :name, :type

    def initialize(id, name, age, type, observations)

        @id = id
        @name = name
        @age = age
        @type = type
        @observations = observations
    end
end
