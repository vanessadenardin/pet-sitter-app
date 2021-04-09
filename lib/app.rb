require_relative './client'
require_relative './pet_sitter'
require_relative './job'
require_relative './pet'
require_relative './task'
require_relative './database'
require 'tty-prompt'
require 'emojis'
require 'artii'
require 'colorize'

class App
    def initialize(database_file)
        @db = Database.new(database_file)
        @prompt = TTY::Prompt.new(active_color: :cyan)
        @last_menu = "main_menu"
        @artii = Artii::Base.new
        @headline = ("-" * 80).colorize(:magenta)
        @emoji = Emojis.new
        # print @emoji.list
        # puts String.colors
    end

    def main_menu()
        puts @headline
        puts @artii.asciify("My Petsitter App").colorize(:magenta)
        puts @headline
        puts "#{@emoji[:smiling_cat_face_with_open_mouth]} Welcome! #{@emoji[:dog_face]}"
        puts @headline
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

        if @prompt.select("Edit pet name? ", menu)
            pet["name"] = @prompt.ask("Name: ")do |q|
                q.required true
                q.messages[:required?] = "Required pet name"
                q.modify :capitalize
            end
        end

        if @prompt.select("Edit pet age? ", menu)
            pet["age"] = @prompt.ask("Age: ", convert: :integer) do |q|
                q.required true
                q.messages[:required?] = "Required pet age"
                q.messages[:valid?] = "Age has to be a number"
            end
        end

        if @prompt.select("Edit Observations? ", menu)
            pet["observations"] = @prompt.ask("Observations: ") do |q|
                q.modify :capitalize
            end
        end
        
        @db.edit_pet("pets", pet)
        return pet
    end

    def pet_delete(pet)
        @db.delete("pets", pet["id"])
    end

    def pet_add(client_id)
        name = @prompt.ask("Pet Name?") do |q|
            q.required true
            q.messages[:required?] = "Required pet name"
            q.modify :capitalize
        end

        age = @prompt.ask("Pet Age?", convert: :integer) do |q|
            q.required true
            q.messages[:required?] = "Required pet age"
            q.messages[:valid?] = "Age has to be a number"
        end

        type = @prompt.ask("Pet type?")do |q|
            q.required true
            q.messages[:required?] = "Required pet type"
            q.modify :capitalize
        end

        observations = @prompt.ask("Observations: ") do |q|
            q.modify :capitalize
        end
        
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
            menu.push({name: 'Edit client', value: "EDIT"})
            menu = navigation(menu)
            input = @prompt.select("Pets list: ", menu)

            case input
            when "ADD"
                pet_add(client["id"])
            when "DELETE"
                client_delete(client)
                menu_clients()
            when "EDIT"
                client = client_edit(client)
                menu_edit_client(id)
            end
            go_to(input)
            @last_menu = "menu_clients"
        end
    end 
    
    def client_edit(client)
        menu = [
            {name: "Yes", value: true},
            {name: "No", value: false}
        ]

        if @prompt.select("Edit client name? ", menu)
            client["name"] = @prompt.ask("Name: ") do |q|
                q.required true
                # q.validate(/\A\w+\Z/)
                q.messages[:required?] = "Required client name"
                q.modify :capitalize
            end
        end

        if @prompt.select("Edit Email? ", menu)
            client["contact"] = @prompt.ask("Email: ") do |q|
                q.required true
                q.messages[:required?] = "Required client email address"
                q.validate(/\A\w+@\w+\.\w+\Z/, "Invalid email address")
            end
        end

        if @prompt.select("Edit Post Code? ", menu)
            client["post_code"] = @prompt.ask("Post code: ", convert: :integer)
            q.messages[:valid?] = "Post code has to be a number"
        end
        
        @db.edit_client("clients", client)
        return client
    end

    def client_delete(client)
        for pet in client["pet_list"]
            @db.delete("pets", pet["id"])
        end

        @db.delete("clients", client["id"])
    end

    def client_add()
        name = @prompt.ask("Client Name?") do |q|
            q.required true
            q.messages[:required?] = "Required client name"
            q.modify :capitalize
        end

        contact = @prompt.ask("Email:") do |q|
            q.required true
            q.messages[:required?] = "Required email address"
            q.validate(/\A\w+@\w+\.\w+\Z/, "Invalid email address")
        end

        post_code = @prompt.ask("Post Code?", convert: :integer) do |q|
            q.messages[:valid?] = "Post code has to be a number"
        end

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

    def menu_edit_task(task)
        loop do
            # system 'clear'
            puts "Tasks list:"
            puts "Description: #{task["description"]}"
            puts "Status: #{task["status"] ? "Completed" : "Not completed"}"
            puts "-" * 20

            menu = [
                {name: 'Edit task', value: "EDIT"},
                {name: 'Delete task', value: "DELETE"}
            ]
            menu = navigation(menu)
            input = @prompt.select("Menu: ", menu)
            go_to(input)

            case input
            when "EDIT"
                task = task_edit(task)
            when "DELETE"
                task_delete(task)
                menu_edit_job(task["job_id"])
            when "BACK"
                menu_edit_job(task["job_id"])
            end

        end
    end

    def task_edit(task)
        menu = [
            {name: "Yes", value: true},
            {name: "No", value: false}
        ]

        if @prompt.select("Edit description? ", menu)
            task["description"] = @prompt.ask("Description: ")do |q|
            q.required true
            q.messages[:required?] = "Required  tasks description"
            q.modify :capitalize
            end
        end

        task["status"] = @prompt.select("Completed? ", menu)

        @db.edit_task("tasks", task)
        return task
    end

    def task_delete(task)
        @db.delete("tasks", task["id"])
    end

    def task_add(job_id)
        description = @prompt.ask("Description: ")do |q|
            q.required true        
            q.messages[:required?] = "Required tasks description"
            q.modify :capitalize
        end

        task = Task.new(description, job_id)
        
        @db.add("tasks", task)
    end

    def menu_edit_job(id)
        # print "oi #{id}"
        job = @db.get_by_id("jobs", id)

        # job["job_list"] = @db.get_pet_list_by_client_id(job["id"])
        loop do
            # system 'clear'
            job["list_tasks"] = @db.get_task_list_by_job_id(job["id"])
            puts "Job details:"
            puts "Job ID: #{job["id"]}"
            puts "Date: #{job["date"]}"
            puts "Client: #{job["client_id"]}"
            tasks_not_completed = job["list_tasks"].select{|task| !task["status"]}.length
            puts "Job has #{job["list_tasks"].length} tasks registered and #{tasks_not_completed > 0 ? "#{tasks_not_completed} tasks to be completed." : "all tasks completed."}"
            puts "-" * 20
            menu = []
            for task in job["list_tasks"]
                menu.push({name: task["description"], value: task})
            end
            menu.push({name: 'Add task', value: "ADD"})
            menu.push({name: 'Edit job date', value: "EDIT"})
            menu.push({name: 'Delete job', value: "DELETE"})
            menu = navigation(menu)
            input = @prompt.select("Tasks list: ", menu)
            @last_menu = "menu_jobs"
            go_to(input)
            case input
            when "ADD"
                task_add(job["id"])
            when "DELETE"
                job_delete(job)
                menu_jobs()
            when "EDIT"
                job = job_edit(job)
                menu_edit_job(id)
            when "BACK"
                menu_jobs()
            else
                menu_edit_task(task)
            end
        end
    end 
    
    def job_edit(job)
        menu = [
            {name: "Yes", value: true},
            {name: "No", value: false}
        ]

        if @prompt.select("Edit date? ", menu)
            job["date"] = @prompt.ask("Date: ")do |q|
                q.required true        
                q.messages[:required?] = "Required date (dd/mm/yyyy)"
            end
        end
        
        @db.edit_job("jobs", job)
        return job
    end

    def job_delete(job)
        @db.delete("jobs", job["id"])
    end

    def job_add()
        list_tasks = []
        date = @prompt.ask("Date:")do |q|
            q.required true        
            q.messages[:required?] = "Required date (dd/mm/yyyy)"
        end

        menu = []
        for client in @db.get_data("clients")
            menu.push({name: client["name"], value: client["id"]})
        end
        client_id = @prompt.select("", menu)

        add_more_tasks = true
        while(add_more_tasks)
            # list_tasks.push(@prompt.ask("Add a task: "))do |q|
            task_add.push(@prompt.ask("Add a task: ")) do |q|
                q.required true
                q.messages[:required?] = "Required tasks description"
                q.modify :capitalize
            end
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
