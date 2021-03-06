# MakersBNB #

## How to use this project ##
```
Clone this repo to your computer
```
```
bundle install
```
```
Make sure you have Postgres installed, and open the db/migrations folder in this project.  
```
```
Create a new database with the required tables by making use of the SQL queries here.
```
```
Do the same thing for a test database.
```
```
Initiate the app by running 'rackup' in your terminal.
```
```
Navigate to your localhost page in a browser.
```

## Individual goals ##
The team started the challenge by setting personal goals. Some of these were met, some were not.  Reflection was only carried out once in the week, when reminded.  

<img width="754" alt="Screenshot 2021-03-05 at 14 03 30" src="https://user-images.githubusercontent.com/75983723/110125769-9a89a380-7dbb-11eb-8444-ce5a02c22eea.png">


## Project Management ##

The team used Trello to list the project specifications and subsequent user stories.  This was also where 'tickets' got listed and delegated.

<img width="1436" alt="Screenshot 2021-03-05 at 13 55 58" src="https://user-images.githubusercontent.com/75983723/110124883-8ee9ad00-7dba-11eb-8a78-ecef641627d3.png">


```
Headline specifications
Any signed-up user can list a new space.
Users can list multiple spaces.
Users should be able to name their space, provide a short description of the space, and a price per night.
Users should be able to offer a range of dates where their space is available.
Any signed-up user can request to hire any space for one night, and this should be approved by the user that owns that space.
Nights for which a space has already been booked should not be available for users to book that space.
Until a user has confirmed a booking request, that space can still be booked for that night.
Nice-to-haves
Users should receive an email whenever one of the following happens:
They sign up
They create a space
They update a space
A user requests to book their space
They confirm a request
They request to book a space
Their request to book a space is confirmed
Their request to book a space is denied
Users should receive a text message to a provided number whenever one of the following happens:
A user requests to book their space
Their request to book a space is confirmed
Their request to book a space is denied
A ‘chat’ functionality once a space has been booked, allowing users whose space-booking request has been confirmed to chat with the user that owns that space
Basic payment implementation though Stripe.
```
## User Stories
On day 1, the team created several user stories from the main specifications.  
Example:
```
As a registered user,
So that I can rent out my space,
I would like to be able to list a new space.
```

<img width="700" alt="Screenshot 2021-03-01 at 17 36 14" src="https://user-images.githubusercontent.com/75075773/109535673-bc7de000-7ab4-11eb-8e43-47912e0447f4.png">
