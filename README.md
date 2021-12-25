# Rails Chat App
A chat app built using Ruby on Rails, MySQL, Elastic Search, Redis and SideKiq.
That allows clients to create applications which may have many chats for their applications according to the following criteria:
- The client creates a new application, give it a name and get it's token.
- The client can list all applications or get a specific application by its token.
- The client can create a new chat in a specific application using its token and get the number of the created chat.
- The client can list all application's chats or get a specific chat by its number and application token.
- For each chat the client is able to create new messages by idetifying the application's token and the chat's number.
- The client can search messages for a specific application and chat.
- Both the application and the chat have a field that indicates the count of related chats or messages accordingly.


This app is built using rails-6.1.4.1 and uses a MySQL database.
It integrates with Elastic Search, SearchFlip, Redis and SideKiq.

## Installation
To get this app up and running you should follow the next steps:
* Clone the app from github.
```bash
git clone https://github.com/mustafa-kamel/rails-chat.git
```

* cd in the repo directory.
```bash
cd rails-chat
```

* Install dependencies by running.
```bash
bundle install
```

* Create db and migrate schema.
```bash
rake db:create
rake db:migrate
```

* Run the rails server.
```bash
rails s
```

* Now you can access the app apis by visiting [localhost:3000](localhost:3000).




* Or simply you can run the app using docker by running:
```bash
docker-compose up
```
After all containers starts you should now run the database migrations.
* You can do that simply by visiting [localhost:3000](localhost:3000) from you browser and click on Run pending migrations.

* Or open your terminal and run to list the running containers.
```bash
docker ps
```

* Copy the CONTAINER ID value for the IMAGE `rails-chat_web` then run the following command.
```bash
docker exec -it {CONTAINER ID} rails db:migrate
```


* You can list all the available routes by running
```bash
rails routes
```

### API Documentation
You can view an API documentation for this project on postman by visiting:
[https://www.getpostman.com/collections/f27d26583531fe8becc4](https://www.getpostman.com/collections/f27d26583531fe8becc4).

