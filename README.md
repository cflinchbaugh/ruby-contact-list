# README

`bundle install`
`rails server`

## Description

A Contact List application which includes Authentication, Create Read Update Delete (CRUD) functionality, with Bootstrap styling.

## Page Creation

### Rails Helpers Method

Create a new Controller, View file, and Route entry with the generate command (ex: `rails generate controller home index`)

Home page is often handled as a unique case where the routes.rb file is updated to point the base URL to the home page

### Manual Method

To create a page requires three things: HTML, Controller, and Route

## Model Creation

Create new DB model with specified fields in addition to accompanying routes, migration, and more (ex: `rails generate scaffold contact first_name:string last_name:string email:string phone:string`)

Generator function will create the migration, but you must run it to get the schema and make it live (`rails db:migrate`)

## Auth

Used [devise](https://rubygems.org/gems/devise) ruby gem.
After install Devise, follow the official docs to configure and then generate related files.

## Model Association

Models can be updated to include associations such as `belongs_to` or `has_many` (among others) by manually adding the association to the model itself, then by running terminal commands to generate the appropriate migrations.

`rails g migration add_user_id_to_contacts user_id:integer:index` (the index improves lookup speed)
`rails db:migrate`

After migrating, ensuring the new association is properly handled by existing data will be required. For this project, the DB was wiped but in production updating existing records with a migration would have been necessary. In either case, controllers must be updated to include the parameter support passed along, in this case adding a contact was updated to pass along the active user id as a hidden field and the contact params were updated to include `:user_id`.

Finally, the assocation was added to the creation process of a Contact by replacing Contact.new with the current_user.contacts.build calls and introducing a validation function to verify the user attempting to take an action is authorized (and redirecting them if they are not).

UX updates can then be implemented to only show UI elements which a user may access, but the data assocations and authorization checks ensure security from bad actors who circumvent the UI.

## Misc

When installing a new gem, be sure to run `bundle add <gem>` not `gem install <gem>` or it will not automatically be added to the Gemfile.

Linting: `bin/rubocop`
Linting Autocorrect: `rubocop -a`
Reset Database: `rails db:drop db:create db:migrate db:seed`
Routes: `rails routes`
Testing: `rails test && rails test:system`
