# README

`bundle install`
`rails server`

## Page Creation

### Rails Helpers Method

Create a new Controller, View file, and Route entry with the generate command (ex: `rails generate controller home index`)

Home page is often handled as a unique case where the routes.rb file is updated to point the base URL to the home page

### Manual Method

To create a page requires three things: HTML, Controller, and Route

## Model Creation

Create new DB model with specified fields in addition to accompanying routes, migration, and more (ex: `rails generate scaffold contact first_name:string last_name:string email:string phone:string`)

Generator function will create the migration, but you must run it to get the schema and make it live (`rails db:migrate`)

## Misc

Testing: `rails test`
Linting: `bin/rubocop`
