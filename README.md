# Pet Sitter App

## Table of Contents

1. [Development Process](#development-process)
    1. [Repository link](#Repository-link)
    1. [Software development plan](#Software-development-plan)
    1. [Diagram](#Diagram)
    - [Workflow diagram](#Workflow-diagram)
    - [UML diagram](#UML-diagram)

1. [About Application](#about-application)
    1. [Application purpose and scope](#Application-purpose-and-scope)
        - [Description](#Description)
        - [Problem/Solution](#problem/solution)
        - [Target Audience](#Target-Audience)
    1. [Features](#Features)
    1. [Code structure](#Code-structure)
    1. [Implementation plan](#Implementation-plan)

1. [User Experience](#user-experience)
    1. [Overview](#Overview)
    1. [User instructions](#User-instructions)
    1. [Requirements](#Requirements)

[Reference](#Reference)

---
## 1. Development Process
---

### 1. Repository link
https://github.com/vanessadenardin/pet-sitter-app

---
### 2. Software development plan

When starting the development of this application I did some brainstorms to assist in the development process, defining screens for the terminal and classes for the code trying to keep it simple and focusing on making all the features work.

![screen definition](/docs/user-screen.png)

![screen definition](/docs/pet-job-screen.png)

![classes definition](/docs/classes.png)

I chose to use GitHub projects to organize what I needed to do. I separate into cards according to the assignment requirements, adding a related card to complete the requirement. On each card, I added a checklist to verify that all plans/ideas were completed at the end of the application's development. Below is an example of a GitHub project during app development, I also added the public link to the GitHub project.

![GitHub projects](/docs/GitHub-projects.png)

[GitHub Projects link here](https://github.com/vanessadenardin/pet-sitter-app/projects/1)

---
<!-- ## How use -->
## 3. Diagram

## - Workflow diagram


## - UML diagram



---
## 2. About Application
---

### 1. Application purpose and scope

## - Description

App developed to help pet sitters to manage their clients’ pets and tasks data. The app will help storing various information keeping records of all clients and its pets including any task related to support the pet welfare while the owners are away.


## - Problem/Solution

The application was initially developed to replace manual data entry of pet sitters. Having as the main feature to assist in the management of service orders, clients contact when caring for different pets from different customers while the pet's owner is absent.


## - Target audience

In this first phase, the application is intended for a *single user* (pet sitter) and intends to keep track of all customers, pets and job orders.
The application aims to help the pet caregiver to define and monitor task lists and pet information to provide the best care meeting the needs of the pet owner and the animal itself during the owner's absence.

---
### 2. Features
<!-- demonstrate your understanding of the following language elements and concepts:
- use of variables and the concept of variable scope
- loops and conditional control structures
- error handling -->

- Welcome Login

_Welcome screen_ and _login page_ (username and password) to access the application.
In this first phase, the password is not encrypted, which can be considered an *ethical issue*, as it gives a false sense of security. Another ethical problem can also be considered when data storage is done without encryption.

![Welcome login](/docs/welcome-login.png)

- Home Menu

The _Home menu_ is displayed as soon as the login is succefully. The initial menu will allow the user to access personal information, customer and pet data, as well as information about service lists containing date, customer address, type of animal, special requests.

![Home](/docs/home.png)

- Pet Sitter profile

The _Pet sitter page_ in this first version of the application serves only to maintain the storage of personal information, but as a future version, it can be useful when printing invoices.

![Pet Sitter screen](/docs/petsitter.png)

![Pet Sitter details](/docs/petsitter-details.png)

- Client's details

The _Client page_ allows the user (pet sitter) to track all existing customers, as well add, edit and delete information.
On this page the user can also access pet data, adding, changing and deleting information related to pets.

![Client](/docs/client.png)

![Client details](/docs/client-details.png)

- Pet's details

The _Pet page_ allows the user (pet sitter) to track all existing pets linked for the clients registered, as well as add, edit and delete pets.

![Pet details](/docs/pet-details.png)

- Job orders

A list of the next 7 days will appear on the _Job page_, but it also allows the user to view previous and future records, add a new one, edit and delete any job.
This page contains data about the pet sitter, clients and pets, as well a list of tasks required for each service added.

![Jobs](/docs/jobs-next-7days.png)

![All jobs](/docs/list-all-jobs.png)

- Tasks' list

A list of tasks required to complete the job will appear in the _Task page_, allowing the user to view the status of the task list and how many tasks need to be completed, add a new one, edit and delete any task.

![Job details without task added](/docs/job-details.png)

![Job details with a tasks' list](/docs/list-tasks.png)

- Back option

All menus allow the user to return to the previous menu or return to the home menu by clicking the _Back_ button or the _Home_ button, depending on the user's needs.

- Log out

Extras:

In the first phase, some resources could not be added due to the time limit. However, there is a desire to expand the features of this application by adding:

- Add more than 1 pet sitter
- Contact list
- Financial management
- Availability calendar
- Pet photo
- Email notifications
- Message chat
- Add confirmation question before deletion

---
### 3. Code structure

- `ruby_petsitter_app.rb` is the file that saves the data into `database.json` file and save as a class called *App*.

- `app.rb` is the main document that controls the flow of the program.

- `user.rb` contains the User class and represents the users of the application. This class contains information related to the pet sitter and also to customers, such as name, contact and postal code.

- `client.rb` is the Client class, daughter of the User superclass and has the Pets subclass (representing the client's list of pets). This class deals with methods that allows to update and delete customers, in addition to adding, updating and deleting pets.

- `pet_sitter.rb` is the Pet sitter class, daughter of the User superclass. This class contains information only related to the pet sitter, such as abn, which at this stage of the application is not used, but in future development, it can be used for financial management.

- `job.rb` contains the Job class. The Job class represents all the service provided by the pet sitter to a specific client, containing a list of tasks for each job, as well as the date of completion of the tasks and the client who requested it.

- `pet.rb` contains the class Pet. It represents the pets of each client and contains information about the animal, such as name, age, type (whether cat or dog) and observations related to special needs for the pet's well-being.

- `task.rb` contains the Task class. It represents the tasks of each job and contains information about the service that will be provided, such as description and status. Status can be changed to completed once the task is completed.

- `database.rb` is a file containing some methods directly related to the save function in the `database.json` file, such as adding, editing, deleting and obtaining elements in classes.

- `ruby_petsitter_spec.rb` is the file that stores the unit tests related to the development of the application and the user experience.

---
## 3. User Experience
---

### 1. Overview

The user have access to 5 screens, including a welcome screen where username and password is required to access all data storage in the application. 
The welcome screen ask for user and password to open the whole application.
The Home screen has the main menu that includes Pet sitter, Client, Job and logout features using TTY-Prompt to navigation and make the selection choosing the option through arrow keys (↑/↓).
Pet sitter screen allows, at this phase, only change data of the pet sitter. Beside that, Client and Job screens are accessible allowing additions, modifications and deltions of the information storage. In the Client screen the user can access client's list and pet's list for each client through a sub-menu that makes the client's name and pet's name as the options to choose. At this first version, the user will be only allow to add pets as cat or dog. In the Job screen the pet sitter can access the job's list via the sub-menu and into that can access the list of task to be completed.
Errors are handled through the validation in the inputs avoiding invalid data entry, such as required inputs of string, date or integer type, as well email address valid. Also, to access the application, the user has to have a valid username and password to enter, if not a error will be raised and the  user will enter in a loop. Each error will show a message that will appear in the screen to tell what has happened from that the user will be able to fix it.

<!-- Users can walk through a tutorial rundown of the application by using spotify_rec -t, with a number of screens explaining how each feature works and how it relates to the rest of the application. Each feature has its own sub-menu which is accessible through the main menu. The sub-menu includes a list of all available options, and utilises TTY-Prompt to make selecting and navigating through the options and menus hassle free. This all makes for a swift interation with the program, and any particular feature can be reached anywhere the program within 1-3 selections from the respective menus. Errors are handled in the program in a variety of ways, including conditional checks, rescuing errors and limiting input. Conditional checks reroute users in the program if the conditional is true, such as if the user has 5 items in MyList already, the program won't let them proceed to add another, and will kick them back to the menu. Raising errors and rescuing them is also used in areas of the program, such as not allowing a list to be displayed if it doesn't have any items in it and having the user choose a new username or password if it doesn't meet the requirements. Finally, TTY-Prompt's select capability is used to limit the range of user input that can be received, and eliminates any misspellings or unexpected options when navigating through the program. The user is only able to select from a defined list for things such as menus, and this doesn't allow any errors based on user input. Furthermore, TTY-Prompt offers a validate function, which validates whether a users selected amount of recommendations is within the range that is allowed to be generated. Each error is accompanied by a message that is printed to the screen to tell the user what has happened, and how they can take steps to fix it. -->
### 2. User instructions

1. Install Ruby (version indicated: ruby 2.7.2p137)
1. Install Ruby Gem
    - rspec
    - tty-prompt
    - emojis
    - artii
    - colorize
    - date
1. shell script
1. comand line arguments
<!-- Install ruby, we recommend using asdf to do this.
Install the Ruby Gem. You can view the Ruby Gems page for this gem here. gem install spotify_rec
This should download the following gem dependencies:
RSpotify
TTY-Prompt
Terminal-Table
Colorizer If for any reason these don't install, you can do so with the following:
gem install rspotify
gem install tty-prompt
gem install terminal-table
gem install colorizer
You can run the app by typing spotify_rec from anywhere in your terminal.
In addition to spotify_rec, the program takes the following options:
-v or --version || Displays the program version
-h or --help || Displays the help message
-t, --tutorial || Have a brief walkthrough of the program
-q (GENRE) or --quick (GENRE) || Generates a quick recommendation using the genre that is supplied -->

---
### 3. Requirements

---
## Reference
