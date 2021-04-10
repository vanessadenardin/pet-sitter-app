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
require 'date'

class App
    def initialize(database_file)
        @db = Database.new(database_file)
        @prompt = TTY::Prompt.new(active_color: :cyan)
        @last_menu = "main_menu"
        @artii = Artii::Base.new
        # headline style (line and colour)
        @headline = ("-" * 80).colorize(:magenta)
        @pipe = "| ".colorize(:magenta)
        @emoji = Emojis.new
        #variable to declare menu options
        @yes_or_no = [
            {name: "Yes", value: true},
            {name: "No", value: false}
        ]
        #variable to declare menu options
        @navigation = [
            {name: 'Back', value: "BACK"},
            {name: 'Home', value: "HOME"},
            {name: 'Logout', value: "EXIT"}
        ]
        # print @emoji.list
        # puts String.colors
    end

    # headline style for menu options
    def headline(menu)
        system 'clear'
        puts @headline
        puts @artii.asciify(menu).colorize(:magenta).colorize(:bold)
        puts @headline
    end

    # welcome login screen (username and password required)
    def login()
        error = ""
        loop do
            headline("Welcome")
            puts error.colorize(:red)

            username = @prompt.ask("Username: ") do |q|
                # error handling requiring input
                q.required true
                q.messages[:required?] = "Username is required."
            end

            password = @prompt.mask("Password: ") do |q|
                # error handling requiring input
                q.required true
                q.messages[:required?] = "Password is required."
            end
            
            # Error handling to acess app
            pet_sitters = @db.get_data("pet_sitters")
            for pet_sitter in pet_sitters
                if pet_sitter["username"] == username.downcase
                    if pet_sitter["password"] == password
                        main_menu()
                    else
                        error = "Wrong username or password."
                    end
                else
                    error = "Wrong username or password."
                end
            end
        end
    end

    # Main screen with all menu options added
    # Choosing option through keyboard arrow key
    def main_menu()
        system 'clear'
        loop do
            headline("My Petsitter App")
            puts "#{@emoji[:smiling_cat_face_with_open_mouth]} Welcome! #{@emoji[:dog_face]}".colorize(:bold)
            puts @headline
            input = @prompt.select('Menu:') do |menu|
                menu.choice name: 'Pet Sitters', value: "PET_SITTERS"
                menu.choice name: 'Clients', value: "CLIENTS"
                menu.choice name: 'Jobs', value: "JOBS"
                menu.choice name: 'Logout', value: "EXIT"
            end
            puts '-' * 20
            go_to(input)
        end
    end

    # menus that repeat on all methods
    def go_to(input)
        # get input to menu selection and match to the value to open screen
        case input
            when "PET_SITTERS"
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
        end
    end

    # pet sitter screen (first stage only one pet sitter is allowed)
    def menu_edit_pet_sitter(id)
        pet_sitter = @db.get_by_id("pet_sitters", id)

        loop do
            system 'clear'
            puts "--> Pet sitter details <--".colorize(:cyan)
            puts @headline
            puts @pipe + "Name: ".colorize(:cyan) + "#{pet_sitter["name"]}"
            puts @pipe + "Contact: ".colorize(:cyan) + "#{pet_sitter["contact"]}"
            puts @pipe + "Post Code: ".colorize(:cyan) + "#{pet_sitter["post_code"]}"
            puts @pipe + "ABN: ".colorize(:cyan) + "#{pet_sitter["abn"]}"
            puts @headline
            menu = []
            menu.push({name: 'Edit pet sitter', value: "EDIT"})
            menu = menu + @navigation
            input = @prompt.select("Menu: ", menu)
            @last_menu = "menu_pet_sitter"
            go_to(input)

            # edit option in the menu
            case input
            when "EDIT"
                pet_sitter = pet_sitter_edit(pet_sitter)
            end
        end
    end

    # menu option to edit pet sitter details
    def pet_sitter_edit(pet_sitter)
        if @prompt.select("Edit name? ", @yes_or_no)
            pet_sitter["name"] = @prompt.ask("Name: ") do |q|
                # error handling requiring input
                q.required true
                q.validate /[a-z]+/
                # error handling message
                q.messages[:valid?] = "Name need to start with a letter."
                q.messages[:required?] = "Required name"
                q.modify :capitalize
            end
        end

        if @prompt.select("Edit Email? ", @yes_or_no)
            pet_sitter["contact"] = @prompt.ask("Email: ") do |q|
                # error handling requiring input
                q.required true
                q.messages[:required?] = "Required email address"
                # error handling message
                q.validate(/\A\w+@\w+\.\w+\Z/, "Invalid email address")
            end
        end

        if @prompt.select("Edit Post Code? ", @yes_or_no)
            pet_sitter["post_code"] = @prompt.ask("Post code: ", convert: :integer) do |q|
                q.messages[:valid?] = "Post code has to be a number"
            end
        end

        if @prompt.select("Edit ABN? ", @yes_or_no)
            pet_sitter["abn"] = @prompt.ask("ABN: ", convert: :integer) do |q|
                q.messages[:convert?] = "ABN has to be a number (no spaces)"
            end
        end
        
        @db.edit("pet_sitters", pet_sitter)
        return pet_sitter
    end

    # pet sitter list (first phase only one is allowed)
    def menu_pet_sitter()
        loop do
            system 'clear'
            headline("Pet Sitters")
            pet_sitter = @db.get_data("pet_sitters")
            menu = []
            for profile in pet_sitter
                menu.push({name: "#{profile["name"]}", value: profile["id"]})
            end
            menu = menu + @navigation
            input = @prompt.select("List of pet sitters (click to edit)", menu)
            @last_menu = "main_menu"
            go_to(input)
            menu_edit_pet_sitter(input)
        end
    end

    # pet details screen - pets info can be edit
    def menu_edit_pet(pet)
        loop do
            system 'clear'
            puts "--> Pet details <--".colorize(:cyan)
            puts @headline
            puts @pipe + "Name: ".colorize(:cyan) + "#{pet["name"]}"
            puts @pipe + "Age: ".colorize(:cyan) + "#{pet["age"]}"
            puts @pipe + "Type: ".colorize(:cyan) + "#{pet["type"] == "Cat" ? @emoji[:smiling_cat_face_with_open_mouth] : @emoji[:dog_face]} #{pet["type"]}"
            puts @pipe + "Observations: ".colorize(:cyan) + "#{pet["observations"]}"
            puts @headline
            menu = [
                {name: 'Delete pet', value: "DELETE"},
                {name: 'Edit pet', value: "EDIT"}
            ]
            menu = menu + @navigation
            input = @prompt.select("Menu: ", menu)

            # specific menu options added 
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
        end
    end

    # menu option to modify pet details
    def pet_edit(pet)
        if @prompt.select("Edit pet name? ", @yes_or_no)
            pet["name"] = @prompt.ask("Name: ")do |q|
                # error handling requiring input
                q.required true
                q.validate /[a-z]+/
                # error handling message
                q.messages[:valid?] = "Name need to start with a letter."
                q.messages[:required?] = "Required pet name"
                q.modify :capitalize
            end
        end

        if @prompt.select("Edit pet age? ", @yes_or_no)
            pet["age"] = @prompt.ask("Age: ", convert: :integer) do |q|
                # error handling requiring input
                q.required true
                # error handling message
                q.messages[:required?] = "Required pet age"
                q.messages[:convert?] = "Age has to be a number"
            end
        end

        if @prompt.select("Edit Observations? ", @yes_or_no)
            pet["observations"] = @prompt.ask("Observations: ") do |q|
                q.modify :capitalize
            end
        end
        
        @db.edit("pets", pet)
        return pet
    end

    # menu option to delete pet
    def pet_delete(pet)
        @db.delete("pets", pet["id"])
    end

    # menu option to add pet
    def pet_add(client_id)
        name = @prompt.ask("Pet Name?") do |q|
            # error handling requiring input
            q.required true
            q.validate /[a-z]+/
            # error handling message
            q.messages[:valid?] = "Name need to start with a letter."
            q.messages[:required?] = "Required pet name"
            q.modify :capitalize
        end

        age = @prompt.ask("Pet Age?", convert: :integer) do |q|
            # error handling requiring input
            q.required true
            #  error handling message
            q.messages[:required?] = "Required pet age"
            q.messages[:convert?] = "Age has to be a number"
        end

        # option to choose between cat and dog (animal type)
        type = @prompt.select("Pet type? ", [
            {name: "#{@emoji[:smiling_cat_face_with_open_mouth]} Cat", value: "Cat"},
            {name: "#{@emoji[:dog_face]} Dog", value: "Dog"},
        ])

        observations = @prompt.ask("Observations: ") do |q|
            q.modify :capitalize
        end
        
        new_id = @db.get_new_id("pets")
        pet = Pet.new(new_id, name, age, type, observations, client_id)
        
        @db.add("pets", pet)
    end

    # client edit screen options
    def menu_edit_client(id)
        client = @db.get_by_id("clients", id)
        
        loop do
            system 'clear'
            client["pet_list"] = @db.get_pet_list_by_client_id(client["id"])
            puts "--> Client details <--".colorize(:cyan)
            puts @headline
            puts @pipe + "Name: ".colorize(:cyan) + "#{client["name"]}"
            puts @pipe + "Contact: ".colorize(:cyan) + "#{client["contact"]}"
            puts @pipe + "Post Code: ".colorize(:cyan) + "#{client["post_code"]}"
            puts @headline
            puts @pipe + "Client has #{client["pet_list"].length.to_s.colorize(:cyan)} pets registered."
            puts @headline
            # list of pets by client will appear
            menu = []
            for pet in client["pet_list"]
                menu.push({name: pet["name"], value: pet})
            end
            menu.push({name: 'Add pet', value: "ADD"})
            menu.push({name: 'Delete client', value: "DELETE"})
            menu.push({name: 'Edit client', value: "EDIT"})
            menu = menu + @navigation
            input = @prompt.select("Pets list (click to edit)", menu)
            @last_menu = "menu_clients"
            go_to(input)

            # specific menu options added 
            case input
            when "ADD"
                pet_add(client["id"])
            when "DELETE"
                client_delete(client)
                menu_clients()
            when "EDIT"
                client = client_edit(client)
                menu_edit_client(id)
            else
                menu_edit_pet(input)
            end
        end
    end 
    
    # edit client option
    def client_edit(client)
        if @prompt.select("Edit client name? ", @yes_or_no)
            client["name"] = @prompt.ask("Name: ") do |q|
                # error handling requiring input
                q.required true
                q.validate /[a-z]+/
                # error handling message
                q.messages[:valid?] = "Name need to start with a letter."
                q.messages[:required?] = "Required client name"
                q.modify :capitalize
            end
        end

        if @prompt.select("Edit Email? ", @yes_or_no)
            client["contact"] = @prompt.ask("Email: ") do |q|
                # error handling requiring input
                q.required true
                # error handling message
                q.messages[:required?] = "Required client email address"
                q.validate(/\A\w+@\w+\.\w+\Z/, "Invalid email address")
            end
        end

        if @prompt.select("Edit Post Code? ", @yes_or_no)
            client["post_code"] = @prompt.ask("Post code: ", convert: :integer) do |q|
                # error handling message
                q.messages[:convert?] = "Post code has to be a number"
            end
        end
        
        @db.edit("clients", client)
        return client
    end

    # delete client option
    def client_delete(client)
        for pet in client["pet_list"]
            @db.delete("pets", pet["id"])
        end

        @db.delete("clients", client["id"])
    end

    # add new client
    def client_add()
        name = @prompt.ask("Client Name?") do |q|
            # error handling requiring input
            q.required true
            q.validate /[a-z]+/
            # error handling message
            q.messages[:valid?] = "Name need to start with a letter."
            q.messages[:required?] = "Required client name"
            q.modify :capitalize
        end

        contact = @prompt.ask("Email:") do |q|
            # error handling requiring input
            q.required true
            # error handling message
            q.messages[:required?] = "Required email address"
            q.validate(/\A\w+@\w+\.\w+\Z/, "Invalid email address")
        end

        post_code = @prompt.ask("Post Code?", convert: :integer) do |q|
            q.messages[:convert?] = "Post code has to be a number"
        end

        new_id = @db.get_new_id("clients")
        client = Client.new(new_id, name, contact, post_code)
        
        @db.add("clients", client)
    end

    # client screen
    def menu_clients()
        loop do
            system 'clear'
            clients = @db.get_data("clients")
            puts @headline
            headline("Clients")
            puts "You have #{clients.length.to_s.colorize(:cyan)} clients registered."
            puts @headline

            # list of clients will appear 
            menu = []
            for client in clients
                menu.push({name: "#{client["name"]}", value: client["id"]})
            end
            menu.push({name: 'Add client', value: "ADD"})
            menu = menu + @navigation
            input = @prompt.select("List of clients (click to edit)", menu)
            @last_menu = "main_menu"
            go_to(input)

            # specific menu options added 
            case input
            when "ADD"
                client_add()
            else
                @last_menu = "menu_clients"
                menu_edit_client(input)
            end
        end
    end

    #  edit tasks in the job order
    def menu_edit_task(task)
        loop do
            system 'clear'
            puts "--> Task Details <--".colorize(:cyan)
            puts @headline
            puts @pipe + "Description: ".colorize(:cyan) + "#{task["description"]}"
            puts @pipe + "Status: ".colorize(:cyan) + "#{task["status"] ? @emoji[:white_heavy_check_mark] : @emoji[:cross_mark]}"
            puts "-" * 20

            menu = [
                {name: 'Edit task', value: "EDIT"},
                {name: 'Delete task', value: "DELETE"}
            ]
            menu = menu + @navigation
            input = @prompt.select("Menu: ", menu)
            go_to(input)

            # specific menu options added 
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

    # edit task option
    def task_edit(task)
        if @prompt.select("Edit description? ", @yes_or_no)
            task["description"] = @prompt.ask("Description: ")do |q|
            # error handling requiring input
            q.required true
            # error handling message
            q.messages[:required?] = "Required  tasks description"
            q.modify :capitalize
            end
        end

        task["status"] = @prompt.select("Completed? ", @yes_or_no)

        @db.edit("tasks", task)
        return task
    end

    # delete task option
    def task_delete(task)
        @db.delete("tasks", task["id"])
    end

    # add task option
    def task_add(job_id)
        description = @prompt.ask("Description: ")do |q|
            # error handling requiring input
            q.required true   
            # error handling message
            q.messages[:required?] = "Required tasks description"
            q.modify :capitalize
        end

        new_id = @db.get_new_id("tasks")
        task = Task.new(new_id, description, job_id)
        
        @db.add("tasks", task)
    end

    # menu edit jobs
    def menu_edit_job(id)
        loop do
            system 'clear'
            job = @db.get_by_id("jobs", id)
            job["list_tasks"] = @db.get_task_list_by_job_id(job["id"])
            job["client"] = @db.get_by_id("clients", job["client_id"])

            puts "--> Job details <--".colorize(:cyan)
            puts @headline
            puts @pipe + "Job ID: ".colorize(:cyan) + "#{job["id"]}"
            puts @pipe + "Date: ".colorize(:cyan) + "#{job["date"]}"
            puts @pipe + "Client: ".colorize(:cyan) + "#{job["client"]["name"]}"
            puts @headline

            # message highlighting tasks status
            tasks_not_completed = job["list_tasks"].select{|task| !task["status"]}.length
            puts "Job has #{job["list_tasks"].length.to_s.colorize(:cyan)} tasks registered and #{tasks_not_completed > 0 ? "#{tasks_not_completed.to_s.colorize(:red)} tasks to be completed." : "all tasks completed."}"
            puts @headline

            menu = []
            for task in job["list_tasks"]
                menu.push({name: task["description"], value: task})
            end
            menu.push({name: 'Add task', value: "ADD"})
            menu.push({name: 'Edit job date', value: "EDIT"})
            menu.push({name: 'Delete job', value: "DELETE"})
            menu = menu + @navigation
            input = @prompt.select("Tasks list (click to edit)", menu)

            @last_menu = "menu_jobs"
            go_to(input)

            # specific menu options added 
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
    
    # edit option for jobs
    def job_edit(job)
        if @prompt.select("Edit date? ", @yes_or_no)
            valid_date = false
            while(!valid_date)
                # add date for job
                job["date"] = @prompt.ask("Date (dd/mm/YYYY): ")do |q|
                    # error handling requiring input
                    q.required true
                    # error handling message
                    q.messages[:required?] = "Required date (dd/mm/yyyy)"
                end
                # sends date input to date validation
                # keep on this loop until date is valid
                valid_date = validate_date(job["date"])
            end

        end
        
        @db.edit("jobs", job)
        return job
    end

    # date validation
    def validate_date(date)
        begin
            # first convert the input string into the Date gem
            # that will validate most of the cases like m/d/y or other separators
            new_date = Date.strptime(date, "%d/%m/%Y")
            # extract the year from the date, convert to string and split to check Year size
            # The calculation of 7 days logic requires the year to be full size i.e 2021
            # so if length different than 4, raises an argument for invalid date
            if new_date.year.to_s.split("").length != 4
                raise ArgumentError
            end

            # return true if no errors on validations
            return true

        rescue ArgumentError
            puts "Invalid date"
            return false
        end
    end

    # delete job option
    def job_delete(job)
        for task in job["list_tasks"]
            @db.delete("tasks", task["id"])
        end

        @db.delete("jobs", job["id"])
    end

    # add job option
    def job_add()
        valid_date = false
        while (!valid_date)
            date = @prompt.ask("Date (dd/mm/YYYY): ")do |q|
                # error handling requiring input
                q.required true   
                # error handling message
                q.messages[:required?] = "Required date (dd/mm/yyyy)"
            end
            # sends date input to date validation
            # keep on this loop until date is valid
            valid_date = validate_date(date)
        end

        menu = []
        for client in @db.get_data("clients")
            menu.push({name: client["name"], value: client["id"]})
        end
        client_id = @prompt.select("", menu)

        new_id = @db.get_new_id("jobs")
        job = Job.new(new_id, date, client_id)

        @db.add("jobs", job)

        add_more_tasks = true
        while(add_more_tasks)
            task_add(job.id)
            add_more_tasks = @prompt.select("Add another one?", @yes_or_no)
        end
    end

    # job screen
    def menu_jobs()
        # jobs is outside the loop so we can have either 7 days only or all jobs
        jobs = @db.get_jobs_last_7_days()
        # variable to control changing display messages
        next_7_days = true
        loop do
            system 'clear'
            headline("Jobs")
            # message highlighting jobs in the list (next 7 days or all)
            puts "You have #{jobs.length.to_s.colorize(:cyan)} jobs" + "#{next_7_days ? " for the next 7 days." : "."}"
            puts @headline

            menu = []
            for job in jobs
                job["client"] = @db.get_by_id("clients", job["client_id"])
                menu.push({name: "Name: #{job["client"]["name"]} | Date: #{job["date"]}", value: job["id"]})
            end
            menu.push({name: 'Add job', value: "ADD"})
            if next_7_days
                menu.push({name: 'Show all jobs', value: "ALL"})
            else
                menu.push({name: 'Show only next 7 days of jobs', value: "JOBS"})
            end
            menu = menu + @navigation
            input = @prompt.select("List of jobs (click to edit)", menu)
            @last_menu = "main_menu"
            go_to(input)

            # specific menu options added 
            case input
            when "ADD"
                job_add()
                # refresh jobs from last 7 days after adding one so it can update the menu
                # reason is because the get jobs is outside the loop
                jobs = @db.get_jobs_last_7_days()
            when "ALL"
                jobs = @db.get_data("jobs")
                next_7_days = false
            else
                menu_edit_job(input)
            end
        end
    end

    # method to run app
    def run()
        login()
    end

end
