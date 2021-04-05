require_relative './models/user'
require_relative './models/client'
require_relative './models/pet'
require_relative './models/job'

describe User do
    it 'should return a name' do
        name = 'Vanessa'
        contact = "vanessa.denardin@gmail.com"
        post_code = 3028
        user = User.new(name, contact, post_code)
        expect(user.name).to eq(name)
    end

    it 'should have a list of users' do
        users = []
        users.push(User.new("van", "v@g.com", 3000))
        users.push(User.new("van2", "g@v.com", 3001))
        expect(users.length).to be(2)
    end
end

describe Client do
    it 'should return client name' do
        name = 'Vanessa'
        contact = "vanessa.denardin@gmail.com"
        post_code = 3028
        client = Client.new(name, contact, post_code)
        expect(client.name).to eq(name)
    end
    it 'should return client existing pet' do
        name = 'Vanessa'
        contact = "vanessa.denardin@gmail.com"
        post_code = 3028
        client = Client.new(name, contact, post_code)
        pet = Pet.new("Guri", 5, "cat", "none")
        client.pet_list.push(pet)
        expect(client.pet_list[0]).to eq(pet)
    end
end

describe Pet do
    it 'should return the name of the pet' do
        name = 'Guri'
        age = 5
        type = 'cat'
        observations = ''
        pet = Pet.new(name, age, type, observations)
        expect(pet.name).to eq(name)
    end

    it 'should return the type of the pet' do
        name = 'Guri'
        age = 5
        type = 'cat'
        observations = ''
        pet = Pet.new(name, age, type, observations)
        expect(pet.type).to eq(type)
    end
end

describe Job do
    it 'should return the type list of tasks' do
        date = 02/04/2021
        client_id = 1
        list_task = ['feed cats', 'clean litter box']
        job = Job.new(date, client_id, list_task)
        expect(job.list_tasks).to eq(list_task)
    end
end
