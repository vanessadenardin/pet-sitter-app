require_relative './user'
require 'json'

class Pet_sitter < User
    def initialize(id, name, contact, post_code, abn, username, password)
        super(id, name, contact, post_code)
        @abn = abn
        @username = username
        @password = password
    end
end
