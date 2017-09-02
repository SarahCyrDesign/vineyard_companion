# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
  - In Gemfile, Sinatra app is listed (gem 'sinatra')

- [x] Use ActiveRecord for storing information in a database
- ActiveRecord is utilized in the app/models (class User < ActiveRecord::Base)

- [x] Include more than one model class (list of model class names e.g. User, Post, Category)
- Models included in the project are: User, Vineyard, Wine

- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Posts)
  - Relationships with model models are as follows:
  1) User: has_many :vineyards, has_many :wines
  2) Vineyard: belongs_to :user, has_many :wines
  2) Wine: belongs_to :user, belongs_to :vineyard


- [x] Include user accounts
  - A User has a :username and :password_digest to ensure a secure account
  - A User has the option to create a new account and/or login at index page
  - A User cannot progress further into other views pages without being logged_in

- [x] Ensure that users can't modify content created by other users


- [x] Include user input validations
  - A User will receive successful validations on the views pages utilizing the rack flash gem after input


- [x] Display validation failures to user with error message (example form URL e.g. /posts/new)
  - A User will be shown various messages on the views pages utilizing the rack flash gem

- [ ] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code
  - README provides a thorough explanation of descriptions, usage and contributions


Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
