# BullStock

A stock app to purchase or sell stocks using virtual money. [IEX Ruby Client gem](https://github.com/dblock/iex-ruby-client) has been used to fetch stock details.

## Admin User Stories

- User Story 1: As an User, I want to create a new trader to manually add them to the app.
- User Story 2: As an User, I want to edit a specific trader to update his/her details.
- User Story 3: As an User, I want to view a specific trader to show his/her details.
- User Story 4: As an User, I want to see all the traders that registered on the app so I can track all the traders.
- User Story 5: As an User, I want to have a page for pending trader sign up to easily check if there's a new trader sign up.
- User Story 6: As an User, I want to approve a trader sign up so that he/she can start adding stocks.
- User Story 7: As an User, I want to see all the transactions so that I can monitor the transaction flow of the app.

## Trader User Stories

- User Story 1: As a Trader, I want to create an account to buy and sell stocks.
- User Story 2: As a Trader, I want to log in my credentials so that I can access my account on the app.
- User Story 3: As a Trader, I want to receive an email to confirm my pending account signup.
- User Story 4: As a Trader, I want to receive an approval trader account email to notify me once my account has been approved.
- User Story 5: As a Trader, I want to buy a stock to add to my investment (trader signup should be approved).
- User Story 6: As a Trader, I want to have a My Portfolio page to see all my stocks.
- User Story 7: As a Trader, I want to have a Transaction page to see and monitor all the transactions made by buying and selling stocks.
- User Story 8: As a Trader, I want to sell my stocks to gain money.

## Entity Relationship Diagram

Below is the ERD of the application:

![ERD of the Application](https://drive.google.com/uc?export=view&id=1Ra0peW1qrMXcw9mnObFneHGBocm6h3ki)

## Technologies

- Ruby 3.1.2
- Rails 6.1.6
- PostgreSQL 14.2
- NodeJS 16.15.0
- Yarn 1.22.18

## Getting started

To get started with the app, clone the repo and access the created directory:

```
$ git clone git@github.com:reyolan/bull-stock.git
$ cd bull-stock
```

Install the needed gems and node modules:

```
$ bundle install
$ yarn
```

Next, create and setup the database (database migrations/schema):

```
$ bin/rails db:setup
```

Finally, run the test suite to verify that all features work correctly:

```
$ rspec
```

Run the app by starting the Rails dev server and Vite.js dev server:

```
$ bin/rails server
$ bin/vite dev
```

You can then visit the site with this URL: http://localhost:3000

To receive e-mails, install mailcatcher gem:

```
$ gem install mailcatcher
$ mailcatcher
```

You can then visit http://127.0.0.1:1080/ to see the e-mails received.

## Test accounts

### Admin
email: admin@bullstock.com
password: abcdef

### Trader
email: approved.trader@bullstock.com
password: abcdef
