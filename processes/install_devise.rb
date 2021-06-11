# frozen_string_literal: true

def install_devise
  append_to_file 'Gemfile', File.read('./tmp/inserts/install_devise/Gemfile')
  run 'bundle install'

  run 'rails generate devise:install'
  remove_file 'config/locales/devise.en.yml'

  directory 'files/install_devise', './'

  # remove_comments_from_file 'config/initializers/devise.rb'

  inject_into_file(
    'config/initializers/devise.rb',
    File.read('./tmp/inserts/install_devise/config/initializers/devise'),
    after: "config.sign_out_via = :delete\n"
  )

  run 'rails generate devise User'

  # remove_comments_from_file 'app/models/user.rb'

  uncomment_lines Dir['./db/migrate/*_devise_create_users.rb'].first, /t\.|add/

  run 'rails generate rolify Role User'

  rails_command 'db:migrate'
  uncomment_lines 'config/initializers/rolify.rb', 'config.use_dynamic_shortcuts'

  gsub_file(
    'app/models/user.rb',
    'devise :database_authenticatable, :registerable,',
    ''
  )

  gsub_file(
    'app/models/user.rb',
    ':recoverable, :rememberable, :validatable',
    ''
  )

  gsub_file(
    'app/models/user.rb',
    'rolify',
    File.read('./tmp/inserts/install_devise/app/models/user')
  )

  inject_into_file(
    'spec/models/user_spec.rb',
    File.read('./tmp/inserts/install_devise/spec/models/user_spec'),
    before: /^end/
  )

  gsub_file(
    'config/routes.rb',
    'devise_for :users',
    File.read('./tmp/inserts/install_devise/config/routes')
  )

  run 'rails generate migration AddNameToUser first_name last_name username'
  run 'rails generate migration AddOmniauthToUser provider uid'

  rails_command 'db:migrate'

  inject_into_file(
    'spec/factories/users.rb',
    File.read('./tmp/inserts/install_devise/spec/factories/users'),
    after: "factory :user do\n"
  )

  inject_into_file(
    'spec/factories/roles.rb',
    "    name { 'MyString' }",
    after: "factory :role do\n"
  )
end
