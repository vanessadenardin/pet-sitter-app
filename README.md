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

![GitHub-projects](/docs/GitHub-projects.png)

[GitHub Projects link here](https://github.com/vanessadenardin/pet-sitter-app/projects/1)

---
<!-- ## How use -->
## 3. Diagram

## - Workflow diagram


## - UML diagram


---
## 4. Implementation plan

---
## 2. About Application
---

### 1. Application purpose and scope


## - Description


App developed to help pet sitters to manage their clients’ pets and tasks data. The app will help storing various information keeping records of all clients pet’s including any task related to support the pet welfare while the owners are away.


## - Problem/Solution


The application was initially developed to replace manual data entry of pet sitters. Having as the main feature to assist in the management of service orders when caring for different pets from different customers while the pet owner is absent.


## - Target audience


In this first phase, the application is intended for a single user (pet sitter) and intends to keep track of all customers and pets.
The application aims to help the pet caregiver to define and monitor task lists and pet information to provide the best care meeting with the needs of the pet owner and the animal itself during the owner's absence.

---
### 2. Features
<!-- demonstrate your understanding of the following language elements and concepts:
- use of variables and the concept of variable scope
- loops and conditional control structures
- error handling -->

- Welcome Login

Welcome screen and login page (username and password) to access the application.
In this first phase, the password is not encrypted, which can be considered an ethical issue, as it gives a false sense of security. Another ethical problem can also be considered when data storage is done.

- Home Menu

The Home menu is displayed as soon as the login is succefully. The initial menu will allow the user to access personal information, customer and pet data, as well as information about service lists containing date, customer address, type of animal, special requests.

- Pet Sitter profile

The Pet sitter page in this first version of the application serves only to maintain the storage of personal information, but as a future version, it can be useful when printing invoices.

- Client's details

The Client's page allows the user (pet sitter) to track all existing customers, as well as add, edit and delete information.
On this page the user can also access pet data, adding, changing and deleting information related to pets.

- Pet's information

The Pet's page allows the user (pet sitter) to track all existing pets linked for the clients registered, as well as add, edit and delete pets.

- Job orders

A list of the next 7 days will appear on the job page, but it also allows the user to view previous and future records, add a new one, edit and delete any job.
This page contains data about the pet sitter, clients and pets, as well as a list of tasks required for each service added.

- Tasks' list

A list of tasks required to complete the job and the task page will appear, allowing the user to view the status of the task list and how many tasks need to be completed, add a new one, edit and delete any task.

- Back option

All menus allow the user to return to the previous menu or return to the initial menu, depending on the user's needs.

- Log out

Extras:
- Contact list
- Mark completed tasks
- Financial management
- Availability calendar
- Pet photo
- Email notifications
- Message chat

---
### 3. Code structure

- `ruby_petsitter_app.rb` is the file that saves the data into `database.json` file and save as a class called *App*.

- `app.rb` is the main document that controls the flow of the program.

- `user.rb` contains the User class and represents the users of the application. This class contains information related to the pet sitter and also to customers, such as name, contact and postal code.

- `client.rb` is the Client class, daughter of the User superclass and has the Pets subclass (representing the client's list of pets). This class deals with methods that allows to update and delete customers, in addition to adding, updating and deleting pets.

- `pet_sitter.rb` is the Pet sitter class, daughter of the User superclass. This class contains information only related to the pet sitter, such as abn, which at this stage of the application is not used, but in future development, it can be used for financial management.

- `job.rb` contains the Job class. The Job class represents all the service provided by the pet sitter to a specific client, containing a list of tasks for each job, as well as the date of completion of the tasks and the client who requested it.

- `pet.rb` contains the class Pet. It represents the pets of each client and contains information about the animal, such as name, age, type (whether cat or dog) and observations related to special needs for the pet's well-being.

- `task.rb` contains the Task class. It represents the tasks of each job and contains information about the service that will be provided, such as description and status.

- `database.rb` is a file containing some methods directly related to the save function in the `database.json` file, such as adding, editing, deleting and obtaining elements in classes.

- `ruby_petsitter_spec.rb` is the file that stores the unit tests related to the development of the application and the user experience.

---
## 3. User Experience
---

### 1. User instructions

---
### 2. Requirements

---
## Reference
