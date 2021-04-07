require_relative './client'
require_relative './pet_sitter'
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
        puts '<>' * 20
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
            # when "PROFILE"
            #     print "PROFILE"
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
                {name: 'Delete', value: "DELETE"}
            ]
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
        print "oi #{id}"
        client = @db.get_by_id("clients", id)
        print client
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
            menu = navigation(menu)
            input = @prompt.select("Pets list: ", menu)
            go_to(input)
            @last_menu = "menu_clients"
            menu_edit_pet(input)
        end
    end 
    
    def menu_clients()
        loop do
            # system 'clear'
            clients = @db.get_class("clients")
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

    def menu_jobs()
        loop do
            # system 'clear'
            jobs = @db.get_all("jobs")
            # print(jobs)
            # puts "You have #{id quantity jobs} jobs registered for the next 5 days."
            puts "List of jobs:"
            input = @prompt.select('Menu:') do |menu|
                for job in jobs
                    menu.choice name: "#{job["name"]}", value: job
                end
                menu.choice name: 'Task', value: "TASKS"
                menu.choice name: 'Back', value: "BACK"
                menu.choice name: 'Home', value: "HOME"
                menu.choice name: 'Exit', value: "EXIT"
            end
            puts '-' * 20
            case input
                when "TASKS"
                    menu_tasks()
                when "BACK"
                    main_menu()
                when "HOME"
                    main_menu()
                when "EXIT"
                    exit
                else
                    print input
            end
            
        end
    end

    def menu_tasks()
        loop do
            # system 'clear'
            tasks = @db.get_all("tasks")
            # print(tasks)
            # puts "You have #{id quantity tasks} tasks added for the #{client_id} #{job} job."
            # puts "List of tasks:"
            input = @prompt.select('List of tasks:') do |menu|
                for task in tasks
                    menu.choice name: "#{tasks["name"]}", value: task
                end
                menu.choice name: 'Back', value: "BACK"
                menu.choice name: 'Home', value: "HOME"
                menu.choice name: 'Exit', value: "EXIT"
            end
            puts '-' * 20
            case input
                when "BACK"
                    main_menu()
                when "HOME"
                    main_menu()
                when "EXIT"
                    exit
                else
                    print input
            end
            
        end
    end

    def run()
        main_menu()
    end

end
