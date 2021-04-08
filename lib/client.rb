require_relative './user'

class Client < User
    # attr_reader :name, :pet_list

    def initialize(name, contact, post_code)
        super(name, contact, post_code)
        @pet_list = []
    end

    def update_id(id)
        @id = id
    end

    def to_hash()
        return {
            id: @id,
            name: @name,
            contact: @contact,
            post_code: @post_code,
        }
    end
end
