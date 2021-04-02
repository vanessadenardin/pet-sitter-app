require_relative "./user.rb"

class Pet_sitter < User

    def initialize(id, name, contact, post_code, abn)
        super(id, name, contact, post_code)
        @abn = abn
    end

end
