require_relative '../lib/client'
require_relative '../lib/pet'

describe Client do
    it 'should return client name' do
        id = 0
        name = 'Vanessa'
        contact = "vanessa.denardin@gmail.com"
        post_code = 3028
        client = Client.new(id, name, contact, post_code)
        expect(client.name).to eq(name)
    end

    it 'should have a list of clients' do
        clients = []
        clients.push(Client.new(0, "van", "v@g.com", 3000))
        clients.push(Client.new(1, "van2", "g@v.com", 3001))
        expect(clients.length).to be(2)
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
