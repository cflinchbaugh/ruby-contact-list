# Ruby Contact Manager

A **Rails-powered contact management system** that allows users to securely create, manage, and categorize their contacts. Features include:

✅ **User authentication** (Devise)  
✅ **CRUD operations** for contacts  
✅ **Pagination** (Kaminari)  
✅ **Tagging system** (Many-to-Many)  
✅ **Image uploads** (CarrierWave + Cloudinary)  
✅ **API support** (JWT-based authentication)  
✅ **Critical Styling** (Bootstrap)

---

## **Getting Started**

1. Clone the repository; cd into the project directory
2. `bundle install`
3. `rails db:setup` # Equivalent to db:create, db:migrate, db:seed
4. `rails server`
5. Visit http://localhost:3000 in your browser

## **Devoper Quickstart (subsequent runs)**

```
bundle install
rails server
```

## Feature Overview

### Authentication (Devise)

- Implemented with Devise for robust user management.
- Supports registration, login, logout, and session handling.
- API authentication is JWT-based, allowing secure tokenized access.

### CRUD for Contacts

- Users can create, update, delete, and search contacts.
- Only authenticated users can manage their own contacts.
- Tagging system implemented with a many-to-many relationship.

### Pagination

- Uses Kaminari for paginated contact lists.

### Image Uploads

- Uses CarrierWave for file handling.
- Files are stored remotely using Cloudinary.
- Uploaded images are restricted by file type and size to ensure security.

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

### Contacts and Users (Many to One)

Models can be updated to include associations such as `belongs_to` or `has_many` (among others) by manually adding the association to the model itself, then by running terminal commands to generate the appropriate migrations.

- `rails g migration add_user_id_to_contacts user_id:integer:index` (the index improves lookup speed)
- `rails db:migrate`

After migrating, ensuring the new association is properly handled by existing data will be required. For this project, the DB was wiped but in production updating existing records with a migration would have been necessary. In either case, controllers must be updated to include the parameter support passed along, in this case adding a contact was updated to pass along the active user id as a hidden field and the contact params were updated to include `:user_id`.

Finally, the assocation was added to the creation process of a Contact by replacing Contact.new with the current_user.contacts.build calls and introducing a validation function to verify the user attempting to take an action is authorized (and redirecting them if they are not).

UX updates can then be implemented to only show UI elements which a user may access, but the data assocations and authorization checks ensure security from bad actors who circumvent the UI.

### Tags and Contacts (Many to Many)

Adding support for a Tag model for Contacts requires a join table and updating the models (including the join model) to include the appropriate associations. Seeding data and updating the UI ensures the end user can see the tags where appropriate, and updating the Contacts controller to permit the new tag_ids attribute.

Because a Contact may have a Tag association, it is important to include the `dependent: :destroy` ability to ensure deleting a Contact also deletes the join recrod to avoid foreign key violations.

## Pagination

[Kaminari](https://github.com/kaminari/kaminari) has been implemented for pagination

## Image Uploading

[Cloudinary](https://cloudinary.com/documentation/rails_integration) was used for file storage and requires the appropriate secrets be supplied to the .env file; for local development you can integrate with your own instance of Cloudinary or contact the admin for (potential) access.

[CarrierWave](https://rubygems.org/gems/carrierwave) uploader was implemented to handle the actual uploading.

## Testing

Test coverage is less important than test quality, however, coverage is still a valuable tool. [simplecov](https://github.com/simplecov-ruby/simplecov) is being used to generate reports each time `rails test` is run, view the latest report with the command `open coverage/index.html`

## Security

Authentication is managed through Devise, which provides a robust and battle-tested system for user registration, session management, password hashing, and recovery. Sensitive attributes such as passwords are securely stored using bcrypt and never exposed directly.

Email verification for new users has been implemented to ensure the authenticity of accounts and reduce the risk of fraudulent or malicious registrations. Upon signing up, users receive a confirmation email with a unique verification link that must be clicked before they can fully access the application.

User-generated content (names, email, etc) is safely handled throughout the system. Rails' default behavior of escaping content in views helps prevent Cross-Site Scripting (XSS) attacks, and this has been confirmed through manual testing (e.g., script injection attempts in contact fields do not execute). At present, no use of rich text or custom HTML rendering exists, so additional sanitization steps have not been introduced, though the architecture could easily accommodate them if needed in the future.

Image uploads are handled using CarrierWave, with files stored on Cloudinary. Uploaded images are restricted by file type and size using model-level validations. The application does not accept or render arbitrary file types, and uploads are not directly exposed or served from the Rails app, further mitigating risk.

## Misc

When installing a new gem, be sure to run `bundle add <gem>` not `gem install <gem>` or it will not automatically be added to the Gemfile.

- DB Console: `rails dbconsole`
- Linting: `bin/rubocop`
- Linting Autocorrect: `rubocop -a`
- Reset Database: `rails db:drop db:create db:migrate db:seed`
- Routes: `rails routes`
- Testing: `rails test && rails test:system`

## Special Thanks

[Codemy](https://www.youtube.com/watch?v=fmyvWz5TUWg)
