require_relative './client'
require_relative './pet_sitter'
require_relative './job'
require_relative './pet'
require_relative './database'
require 'tty-prompt'

class App
    def initialize(database_file)
        @db = Database.new(database_file)
        @prompt = TTY::Prompt.new
        @last_menu = "main_menu"
    end

    def main_menu()
        puts "My Petsitter App"
        puts "Welcome!"
        puts '-' * 20
        # self.send("menu_clients")
        loop do
            # system 'clear'
            input = @prompt.select('Menu:') do |menu|
                menu.choice name: 'Profile', value: "PROFILE"
                menu.choice name: 'Clients', value: "CLIENTS"
                menu.choice name: 'Jobs', value: "JOBS"
                menu.choice name: 'Exit', value: "EXIT"
            end
            puts '-' * 20
            go_to(input)
        end
    end

    def navigation(menu)
        menu.push({name: 'Back', value: "BACK"})
        menu.push({name: 'Home', value: "HOME"})
        menu.push({name: 'Exit', value: "EXIT"})
    
        return menu
    end

    # menus that repeat on all methods
    def go_to(input)
        case input
            when "PROFILE"
                menu_pet_sitter
            when "CLIENTS"
                @last_menu = "main_menu"
                menu_clients()
            when "JOBS"
                @last_menu = "main_menu"
                menu_jobs()
            when "BACK"
                self.send(@last_menu)
            when "HOME"
                main_menu()
            when "EXIT"
                exit()
            when "CLIENT_ADD"
            when "CLIENT_DELETE"
            when "PET_ADD"
            when "PET_DELETE"
        end
    end

    def menu_edit_pet_sitter(id)
        pet_sitter = @db.get_by_id("pet_sitters", id)
        loop do
            # system 'clear'
            puts "Pet sitter details"
            puts "Name: #{pet_sitter["name"]}"
            puts "Contact: #{pet_sitter["contact"]}"
            puts "Post Code: #{pet_sitter["post_code"]}"
            puts "ABN: #{pet_sitter["abn"]}"
            puts "-" * 20
            menu = []
            menu = navigation(menu)
            input = @prompt.select("Menu: ", menu)
            @last_menu = "menu_pet_sitter"
            go_to(input)
            menu_edit_pet_sitter(input)
        end
    end

    def menu_pet_sitter()
        loop do
            # system 'clear'
            pet_sitter = @db.get_data("pet_sitters")
            puts "Pet sitter profile"
            menu = []
            for profile in pet_sitter
                menu.push({name: "#{profile["name"]}", value: profile["id"]})
            end
            menu = navigation(menu)
            input = @prompt.select("Menu: ", menu)
            @last_menu = "main_menu"
            go_to(input)
            menu_edit_pet_sitter(input)
        end
    end

    def menu_edit_pet(pet)
        loop do
            # system 'clear'
            puts "Pet details"
            puts "Name: #{pet["name"]}"
            puts "Age: #{pet["age"]}"
            puts "Type: #{pet["type"]}"
            puts "Observations: #{pet["observations"]}"
            puts "-" * 20
            menu = [
                {name: 'Delete pet', value: "DELETE"},
                {name: 'Edit pet', value: "EDIT"}
            ]
            menu = navigation(menu)
            input = @prompt.select("Menu: ", menu)
            case input
            when "BACK"
                menu_edit_client(pet["client_id"])
            when "EDIT"
                pet = pet_edit(pet)
                menu_edit_pet(pet)
            end
            go_to(input)
            pet_delete(pet)
            menu_edit_client(pet["client_id"])
            # menu_edit_client(pet["client_id"])
        end
    end

    def pet_edit(pet)
        menu = [
            {name: "Yes", value: true},
            {name: "No", value: false}
        ]
        if @prompt.select("Edit name? ", menu)
            pet["name"] = @prompt.ask("Name: ")
        end
        if @prompt.select("Edit Age? ", menu)
            pet["age"] = @prompt.ask("Age: ")
        end
        if @prompt.select("Edit Observations? ", menu)
            pet["observations"] = @prompt.ask("Observations: ")
        end
        
        @db.edit_pet("pets", pet)
        return pet
    end

    def pet_delete(pet)
        @db.delete("pets", pet["id"])
    end

    def pet_add(client_id)
        name = @prompt.ask("Name?")
        age = @prompt.ask("Age?")
        type = @prompt.ask("Type?")
        observations = @prompt.ask("Observations: ")
        
        pet = Pet.new(name, age, type, observations, client_id)
        
        @db.add("pets", pet)
    end

    def menu_edit_client(id)
        # print "oi #{id}"
        client = @db.get_by_id("clients", id)
        # print client
        
        loop do
            # system 'clear'
            client["pet_list"] = @db.get_pet_list_by_client_id(client["id"])
            puts "Client details"
            puts "Name: #{client["name"]}"
            puts "Contact: #{client["contact"]}"
            puts "Post Code: #{client["post_code"]}"
            puts "Client has #{client["pet_list"].length} pets registered."
            puts "-" * 20
            menu = []
            for pet in client["pet_list"]
                menu.push({name: "#{pet["name"]}", value: pet})
            end
            menu.push({name: 'Add pet', value: "ADD"})
            menu.push({name: 'Delete client', value: "DELETE"})
            menu = navigation(menu)
            input = @prompt.select("Pets list: ", menu)
            go_to(input)
            @last_menu = "menu_clients"
            case input
            when "ADD"
                pet_add(client["id"])
            when "DELETE"
                client_delete(client)
                menu_clients()
            else
                menu_edit_pet(input)
            end
            
        end
    end 
    
    def client_delete(client)
        for pet in client["pet_list"]
            @db.delete("pets", pet["id"])
        end
        @db.delete("clients", client["id"])
    end

    def client_add()
        name = @prompt.ask("Name?")
        contact = @prompt.ask("Contact?")
        post_code = @prompt.ask("Post Code?")
        
        client = Client.new(name, contact, post_code)
        
        @db.add("clients", client)
    end

    def menu_clients()
        loop do
            # system 'clear'
            clients = @db.get_data("clients")
            # print(clients)
            puts "You have #{clients.length} clients registered."
            puts "List of clients:"
            menu = []
            for client in clients
                menu.push({name: "#{client["name"]}", value: client["id"]})
            end
            menu.push({name: 'Add client', value: "ADD"})
            menu = navigation(menu)
            input = @prompt.select("Menu: ", menu)
            @last_menu = "main_menu"
            go_to(input)
            case input
            when "ADD"
                client_add()
            else
                @last_menu = "menu_clients"
                menu_edit_client(input)
            end
        end
    end

    def menu_edit_job(id)
        # print "oi #{id}"
        job = @db.get_by_id("jobs", id)

        # job["job_list"] = @db.get_pet_list_by_client_id(job["id"])
        loop do
            # system 'clear'
            puts "Job details:"
            puts "Job ID: #{job["id"]}"
            puts "Date: #{job["date"]}"
            puts "Client: #{job["client_id"]}" #client name???
            puts "-" * 20
            menu = []
            for task in job["list_tasks"]
                menu.push({name: task, value: task})
            end
            menu.push({name: 'Add task', value: "ADD"})
            menu.push({name: 'Delete job', value: "DELETE"})
            menu = navigation(menu)
            input = @prompt.select("Tasks list: ", menu)
            @last_menu = "menu_jobs"
            go_to(input)
            case input
            when "DELETE"
                job_delete(job)
                menu_jobs()
            else
                menu_edit_job(input)
            end
            
            # menu_edit_job(input)
        end
    end 
    
    def job_delete(job)
        @db.delete("jobs", job["id"])
    end

    def job_add()
        list_tasks = []
        date = @prompt.ask("Date:")
        menu = []
        for client in @db.get_data("clients")
            menu.push({name: client["name"], value: client["id"]})
        end
        client_id = @prompt.select("", menu)

        add_more_tasks = true
        while(add_more_tasks)
            list_tasks.push(@prompt.ask("Add a task: "))
            menu = [
                {name: "Yes", value: true},
                {name: "No", value: false}
            ]
            add_more_tasks = @prompt.select("Add another one?", menu)
        end
        print list_tasks
        job = Job.new(date, client_id, list_tasks)
        
        @db.add("jobs", job)
    end

    def menu_jobs()
        jobs = @db.get_jobs_last_7_days()

        loop do
            # system 'clear'
            # print(jobs)
            puts "You have #{jobs.length} jobs for the next 7 days."
            puts "List of jobs:"
            menu = []
            for job in jobs
                menu.push({name: "#{job["id"] + 1}", value: job["id"]})
            end
            menu.push({name: 'Add job', value: "ADD"})
            menu.push({name: 'Show all jobs', value: "ALL"})
            menu = navigation(menu)
            input = @prompt.select("Menu: ", menu)
            @last_menu = "main_menu"
            go_to(input)
            case input
            when "ADD"
                job_add()
            when "ALL"
                jobs = @db.get_data("jobs")
            else
                menu_edit_job(input)
            end
        end
    end

    def run()
        main_menu()
    end

end
