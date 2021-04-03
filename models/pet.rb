class Pet
    attr_reader :name, :type

    def initialize(name, age, type, observations)
        @name = name
        @age = age
        @type = type
        @observations = observations
    end

    # def add_pet(id, name, age, type, observations)
    #     pet = Pet.new(id, name, age, type, observations)
    #     @pet_list << pet
    # end

end
