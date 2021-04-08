require_relative './client'
require_relative './pet_sitter'
require_relative './job'
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

    # def menu_edit_pet_sitter(id)
    #     # print "oi #{id}"
    #     pet_sitter = @db.get_data("pet_sitters")
    #     # print client
    #     loop do
    #         # system 'clear'
    #         puts "Welcome to the pet sitter profile"
    #         puts "Name: #{profile["name"]}"
    #         puts "Contact: #{profile["contact"]}"
    #         puts "Post Code: #{profile["post_code"]}"
    #         puts "ABN: #{profile["abn"]}"
    #         puts "-" * 20
    #         menu = []
    #         # for profile in pet_sitter
    #         #     menu.push({name: "#{profile["name"]}", value: profile["id"]})
    #         # end
    #         menu.push({name: 'Delete', value: "DELETE"})
    #         menu = navigation(menu)
    #         input = @prompt.select("Menu: ", menu)
    #         go_to(input)
    #         @last_menu = "menu_clients"
    #         # menu_pet_sitter_delete(pet_sitter)
    #         menu_edit_pet_sitter(input)
    #     end
    # end

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
            go_to(input)
            @last_menu = "menu_pet_sitter"
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
            # menu = [
            #     {name: 'Delete', value: "DELETE"}
            # ]
            menu = navigation(menu)
            input = @prompt.select("Menu: ", menu)
            go_to(input)
            menu_pet_delete(pet)
            menu_edit_client(pet["client_id"])
        end
    end

    def menu_pet_delete(pet)
        @db.delete("pets", pet["id"])
    end

    def menu_edit_client(id)
        # print "oi #{id}"
        client = @db.get_by_id("clients", id)
        # print client
        client["pets_list"] = @db.get_pet_list_by_client_id(client["id"])
        loop do
            # system 'clear'
            puts "Client details"
            puts "Name: #{client["name"]}"
            puts "Contact: #{client["contact"]}"
            puts "Post Code: #{client["post_code"]}"
            puts "Client has #{client["pets_list"].length} pets registered."
            puts "-" * 20
            menu = []
            for pet in client["pets_list"]
                menu.push({name: "#{pet["name"]}", value: pet})
            end
            menu.push({name: 'Delete', value: "DELETE"})
            menu = navigation(menu)
            input = @prompt.select("Pets list: ", menu)
            go_to(input)
            @last_menu = "menu_clients"
            menu_client_delete(client)
            menu_edit_pet(input)
        end
    end 
    
    def menu_client_delete(client)
        @db.delete("clients", client["id"])
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
            menu = navigation(menu)
            input = @prompt.select("Menu: ", menu)
            go_to(input)
            @last_menu = "menu_clients"
            menu_edit_client(input)
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
            puts "Tasks list: #{job["list_tasks"].join(", ")}"
            puts "-" * 20

            menu = [
                {name: 'Delete', value: "DELETE"}
            ]
            
            menu = navigation(menu)
            input = @prompt.select("Jobs list: ", menu)
            go_to(input)
            @last_menu = "menu_jobs"
            menu_job_delete(job)
            # menu_edit_job(input)
        end
    end 
    
    def menu_job_delete(job)
        @db.delete("jobs", job["id"])
    end

    def menu_jobs()
        loop do
            # system 'clear'
            jobs = @db.get_data("jobs")
            # print(jobs)
            puts "You have #{jobs.length} jobs registered."
            puts "List of jobs:"
            menu = []
            for job in jobs
                menu.push({name: "#{job["id"] + 1}", value: job["id"]})
            end
            menu = navigation(menu)
            input = @prompt.select("Menu: ", menu)
            go_to(input)
            @last_menu = "menu_jobs"
            menu_edit_job(input)
        end
    end

    # def menu_tasks()

    #     loop do
    #         # system 'clear'
    #         jobs = @db.get_class("jobs")
    #         # print(jobs)
    #         puts "You have #{jobs.length} jobs registered."
    #         puts "List of jobs:"
    #         menu = []
    #         for job in jobs
    #             menu.push({name: "#{job["id"] + 1}", value: job["id"]})
    #         end
    #         menu = navigation(menu)
    #         input = @prompt.select("Menu: ", menu)
    #         go_to(input)
    #         @last_menu = "menu_jobs"
    #         menu_edit_job(input)
    #     end
    #     loop do
    #         # system 'clear'
    #         tasks = @db.get_class("tasks")
    #         # print(tasks)
    #         puts "You have #{tasks.length} tasks added for job #{job["id"] + 1} for #{jobs["date"]}."
    #         puts "List of tasks:"
    #         menu = []                
    #         for task in tasks
    #             menu.push ({name: "#{tasks["name"]}", value: task["id"]})
    #         end
    #         menu = navigation(menu)
    #         input = @prompt.select("Menu: ", menu)
    #         go_to(input)
    #         @last_menu = "menu_tasks"
    #         # menu_edit_job(input)
    #     end
    # end

    def run()
        main_menu()
    end

end
