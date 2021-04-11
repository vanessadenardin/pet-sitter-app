require_relative './user'
require 'json'

class Pet_sitter < User
    attr_reader :name
    def initialize(id, name, contact, post_code, abn)
        super(id, name, contact, post_code)
        @abn = abn
    end
end
