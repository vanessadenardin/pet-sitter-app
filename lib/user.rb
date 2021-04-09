class User
    attr_accessor :name
    
    def initialize(id, name, contact, post_code)
        @id = id
        @name = name
        @contact = contact
        @post_code = post_code
    end

end

