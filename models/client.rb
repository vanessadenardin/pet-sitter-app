require_relative './user'

class Client < User
    attr_reader :name, :pet_list

    def initialize(id, name, contact, post_code, pet_list)
        super(id, name, contact, post_code)
        @pet_list = pet_list

    end


end
