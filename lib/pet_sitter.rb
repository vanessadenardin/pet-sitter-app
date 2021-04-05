require_relative './user'
require 'json'

class Pet_sitter < User

    attr_reader :name, :get_all

    def initialize(name, contact, post_code, abn)
        super(name, contact, post_code)
        @abn = abn
    end

    def add(object)
    #     pet_sitter = Pet_sitter.new(id, name, contact, post_code, abn)
    #     @abn << abn
    end

    def get(id)

    end

    def delete(id)

    end

    def update(object)
        
    end
end
