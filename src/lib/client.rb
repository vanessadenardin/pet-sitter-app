require_relative './user'

class Client < User
    attr_reader :id
    attr_accessor :pet_list, :job_list

    def initialize(id, name, contact, post_code)
        super(id, name, contact, post_code)
        @pet_list = []
        @job_list = []
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
