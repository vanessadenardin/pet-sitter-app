require_relative './user'

class Client < User
    attr_reader :name, :pet_list

    def initialize(name, contact, post_code)
        super(name, contact, post_code)
        @pet_list = []
    end
end
