require_relative '../lib/pet_sitter'

describe Pet_sitter do
    it 'should return the pet sitter name' do
        id = 0
        name = 'Vanessa'
        contact = "v@b.com"
        post_code = 3000
        abn = 123456
        pet_sitter = Pet_sitter.new(id, name, contact, post_code, abn)
        expect(pet_sitter.name).to eq(name)
    end
end
