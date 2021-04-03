require_relative './models/user'
require_relative './models/client'
require_relative './models/pet'
require_relative './models/job'

describe User do
    it 'should return a name' do
        id = 1
        name = 'Vanessa'
        contact = "vanessa.denardin@gmail.com"
        post_code = 3028
        user = User.new(id, name, contact, post_code)
        expect(user.name).to eq(name)
    end
end

describe Client do
    it 'should return a pet list' do
        id = 1
        name = 'Vanessa'
        contact = "vanessa.denardin@gmail.com"
        post_code = 3028
        pet_list = ['Guri']
        client = Client.new(id, name, contact, post_code, pet_list)
        expect(client.pet_list).to eq(pet_list)
    end
end

describe Pet do
    it 'should return the name of the pet' do
        id = 1
        name = 'Guri'
        age = 5
        type = 'cat'
        observations = ''
        pet = Pet.new(id, name, age, type, observations)
        expect(pet.name).to eq(name)
    end

    it 'should return the type of the pet' do
        id = 1
        name = 'Guri'
        age = 5
        type = 'cat'
        observations = ''
        pet = Pet.new(id, name, age, type, observations)
        expect(pet.type).to eq(type)
    end
end

describe Job do
    it 'should return the type list of tasks' do
        id = 1
        date = 02/04/2021
        client_id = 1
        list_task = ['feed cats', 'clean litter box']
        job = Job.new(id, date, client_id, list_task)
        expect(job.list_tasks).to eq(list_task)
    end
end
