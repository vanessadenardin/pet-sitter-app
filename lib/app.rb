require_relative './client'
require_relative './pet_sitter'
require_relative './database'
require 'tty-prompt'

class App
    def initialize(database_file)
        @db = Database.new(database_file)
        @prompt = TTY::Prompt.new
    end

    def main_menu()
        puts "My Petsitter App"
        puts "Welcome!"
        puts '<>' * 20
            loop do
            # system 'clear'
            input = @prompt.select('Menu:') do |menu|
                menu.choice name: 'Profile', value: "PROFILE"
                menu.choice name: 'Clients', value: "CLIENTS"
                menu.choice name: 'Jobs', value: "JOBS"
                menu.choice name: 'Exit', value: "EXIT"
            end
            puts '-' * 20
            case input
                when "PROFILE"
                    print "PROFILE"
                when "CLIENTS"
                    menu_clients()
                when "JOBS"
                    menu_jobs()
                when "EXIT"
                    exit
            end
        end
    end

    def menu_clients()
        loop do
            # system 'clear'
            clients = @db.get_all("clients")
            # print(clients)
            # puts "You have #{id quantity clients} clients registered."
            puts "List of clients:"
            input = @prompt.select('Menu:') do |menu|
                for client in clients
                    menu.choice name: "#{client["name"]}", value: client
                end
                menu.choice name: 'Pets', value: "PETS"
                menu.choice name: 'Back', value: "BACK"
                menu.choice name: 'Home', value: "HOME"
                menu.choice name: 'Exit', value: "EXIT"
            end
            puts '-' * 20
            case input
                when "PETS"
                    menu_pets()
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

    def menu_pets()
        loop do
            # system 'clear'
            pets = @db.get_all("pets")
            # print(pets)
            # puts "You have #{id quantity pets} pets registered."
            # puts "List of pets:"
            input = @prompt.select('List of pets:') do |menu|
                for pet in pets
                    menu.choice name: "#{pet["name"]}", value: pet
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
