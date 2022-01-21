# MakersBnB specification

We would like a web application that allows users to list spaces they have available, and to hire spaces for the night.

### Headline specifications

- Any signed-up user can list a new space.
- Users can list multiple spaces.
- Users should be able to name their space, provide a short description of the space, and a price per night.
- Users should be able to offer a range of dates where their space is available.
- Any signed-up user can request to hire any space for one night, and this should be approved by the user that owns that space.
- Nights for which a space has already been booked should not be available for users to book that space.
- Until a user has confirmed a booking request, that space can still be booked for that night.

### Nice-to-haves

- Users should receive an email whenever one of the following happens:
 - They sign up
 - They create a space
 - They update a space
 - A user requests to book their space
 - They confirm a request
 - They request to book a space
 - Their request to book a space is confirmed
 - Their request to book a space is denied
- Users should receive a text message to a provided number whenever one of the following happens:
 - A user requests to book their space
 - Their request to book a space is confirmed
 - Their request to book a space is denied
- A ‘chat’ functionality once a space has been booked, allowing users whose space-booking request has been confirmed to chat with the user that owns that space
- Basic payment implementation though Stripe.

### Mockups

Mockups for MakersBnB are available [here](https://github.com/makersacademy/course/blob/main/makersbnb/makers_bnb_images/MakersBnB_mockups.pdf).

---

# User Stories

```
As a property provider
So that I can make some extra cash
I would like to list a space

As a property provider
So that I can tell others about my space
I would like my space to have a name, description and PPN.

As a property provider
So that I can make more money
I would like to list more than one space.

As a user of Makers BnB
So that track my bookings
I would like to sign up, sign in and out.

As a property provider
So that a renter can pick when to stay
I would like to offer a range of available dates.

As a renter
So that I can get away
I would like to request to hire a space for one night.

As a property provider
So that I can rent a space
I would like to approve the booking request.

As a renter
So that I can get away for longer
I would like to request to hire a space for several nights.

As a renter
So that I can avoid booking conflicts
I would like to not able to request already booked dates.

As a property provider
So that I can be selective about guests
I would like my space to be available until I approve a request.
```

# How to use

## To set up the project

Clone this repository and then run:

bundle

## To set up the database

Connect to psql and create the makers_bnb and makers_bnb_test databases:

CREATE DATABASE makers_bnb;
CREATE DATABASE makers_bnb_test;

### To set up the appropriate tables, connect to each database in psql and run the SQL scripts in the db/migrations folder in the given order.

## To run the Makers BnB app:

rackup

## To view spaces, navigate to localhost:9292/spaces.

## To run tests:

rspec

## To run linting:

rubocop