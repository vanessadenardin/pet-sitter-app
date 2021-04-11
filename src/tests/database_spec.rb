require_relative '../lib/database'
require 'json'

describe Database do
    # generate a sample database file
    before(:all) do
        @database_file = "test.json"
        @initial_data = {
            "pets": [],
            "pet_sitters": [],
            "clients": [],
            "jobs": [],
            "tasks": []
        }
        File.write(@database_file, @initial_data.to_json)
        @db = Database.new(@database_file)
    end

    # delete database file after all tests
    after(:all) do
        File.delete(@database_file)
    end

    # get something
    it 'should read an object from json database file' do
        expect(@db.get_all()["clients"]).to eq([])
    end

    it "should return a client by its id" do 
        id = 0
        name = 'Vanessa'
        contact = "vanessa.denardin@gmail.com"
        post_code = 3028
        client = Client.new(id, name, contact, post_code)
        # save client to db
        @db.add("clients", client)
        # get client from db
        begin
            client_from_db = @db.get_by_id("clients", client.id)
        rescue
            client_from_db = false
        end
        expect(client_from_db["id"]).to eq(id)
    end

    # add something
    it 'should add a client to database' do
        id = 0
        name = 'Vanessa'
        contact = "vanessa.denardin@gmail.com"
        post_code = 3028
        client = Client.new(id, name, contact, post_code)
        # save client to db
        @db.add("clients", client)
        # get client from db
        begin
            client_from_db = @db.get_by_id("clients", client.id)
        rescue
            client_from_db = false
        end
        expect(client_from_db["id"]).to eq(0)
    end

    # delete something
    it 'should delete a client from database' do
        id = 0
        name = 'Vanessa'
        contact = "vanessa.denardin@gmail.com"
        post_code = 3028
        client = Client.new(id, name, contact, post_code)
        # save client to db
        @db.add("clients", client)
        # get client from db
        begin
            client_from_db = @db.get_by_id("clients", client.id)
        rescue
            client_from_db = false
        end
        # delete client from db
        @db.delete("clients", client_from_db["id"])

        # get client from db again to avoid misleading results
        begin
            client_from_db = @db.get_by_id("clients", client.id)
        rescue
            client_from_db = false
        end

        expect(client_from_db).to eq(false)
    end

    # edit something
    it 'should edit an existing client' do
        id = 0
        name = 'Vanessa'
        contact = "vanessa.denardin@gmail.com"
        post_code = 3028
        client = Client.new(id, name, contact, post_code)

        # save client to db
        @db.add("clients", client)

        # get client from db
        begin
            client_from_db = @db.get_by_id("clients", client.id)
        rescue
            client_from_db = false
        end
        client_from_db["name"] = "Vanessa 2"
        # edit client on db
        begin
            @db.edit("clients", client_from_db)
        rescue
            client_edited_from_db = false
        end

        if !client_edited_from_db
            exit
        end

        # get client from db again to avoid misleading results
        begin
            client_edited_from_db = @db.get_by_id("clients", client_from_db["id"])
        rescue
            client_edited_from_db = false
        end

        expect(client_edited_from_db["name"]).to eq("Vanessa 2")
    end
end
