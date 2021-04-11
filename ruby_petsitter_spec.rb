require_relative './lib/user'
require_relative './lib/client'
require_relative './lib/pet'
require_relative './lib/job'

describe User do
    it 'should return a name' do
        id = 0
        name = 'Vanessa'
        contact = "vanessa.denardin@gmail.com"
        post_code = 3028
        user = User.new(id, name, contact, post_code)
        expect(user.name).to eq(name)
    end

    it 'should have a list of users' do
        users = []
        users.push(User.new(0, "van", "v@g.com", 3000))
        users.push(User.new(1, "van2", "g@v.com", 3001))
        expect(users.length).to be(2)
    end
end

describe Client do
    it 'should return client name' do
        id = 0
        name = 'Vanessa'
        contact = "vanessa.denardin@gmail.com"
        post_code = 3028
        client = Client.new(id, name, contact, post_code)
        expect(client.name).to eq(name)
    end
    
    it 'should return client existing pet' do
        id = 0
        name = 'Vanessa'
        contact = "vanessa.denardin@gmail.com"
        post_code = 3028
        client = Client.new(id, name, contact, post_code)
        pet_name = "Guri"
        pet = Pet.new(0, pet_name, 5, 'cat', 'none', client.id)
        client.pet_list.push(pet)
        expect(client.pet_list[0].name).to eq(pet_name)
    end
end

# describe Pet do
#     it 'should return the name of the pet' do
#         id = 0
#         name = 'Guri'
#         age = 5
#         type = 'cat'
#         observations = 'none'
#         client_id = 0
#         pet = Pet.new(id, name, age, type, observations, client_id)
#         expect(pet.name).to eq(name)
#     end

#     it 'should return the type of the pet' do
#         id = 0
#         name = 'Guri'
#         age = 5
#         type = 'cat'
#         observations = 'none'
#         client_id = 0
#         pet = Pet.new(id, name, age, type, observations, client_id)
#         expect(pet.type).to eq(type)
#     end
# end

# describe Job do
#     it 'should return the list of jobs by client id' do
#         id = 0
#         date = 02/04/2021
#         client_id = 0
#         job = Job.new(id, date, client_id)
#         expect(job.client_id).to eq(job)
#     end
# end
