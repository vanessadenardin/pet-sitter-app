require_relative '../lib/pet'

describe Pet do
    it 'should return the name of the pet' do
        id = 0
        name = 'Guri'
        age = 5
        type = 'cat'
        observations = 'none'
        client_id = 0
        pet = Pet.new(id, name, age, type, observations, client_id)
        expect(pet.name).to eq(name)
    end

    it 'should return the type of the pet' do
        id = 0
        name = 'Guri'
        age = 5
        type = 'Cat'
        observations = 'none'
        client_id = 0
        pet = Pet.new(id, name, age, type, observations, client_id)
        expect(pet.type).to eq(type)
    end
end
