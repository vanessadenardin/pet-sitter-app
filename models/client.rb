require_relative "./user.rb"
# require_relative "./db_utils.rb"

class Client < User
    # include Dbs
    attr_reader :name, :pet_list

    def initialize(id, name, contact, post_code, pet_list)
        super(id, name, contact, post_code)
        @pet_list = pet_list

    end



end
