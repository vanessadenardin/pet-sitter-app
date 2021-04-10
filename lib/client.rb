require_relative './user'

class Client < User
    def initialize(id, name, contact, post_code)
        super(id, name, contact, post_code)
        @pet_list = []
    end

    # convert class to hash
    def to_hash()
        return {
            id: @id,
            name: @name,
            contact: @contact,
            post_code: @post_code,
        }
    end
end
