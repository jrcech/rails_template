def configure_application
  template_into_file 'Gemfile', before: 'group :development, :test do'
  template_into_file 'app/helpers/application_helper.rb', before: last_end

  configure_git
  configure_dockerignore
  remove_default_files

  process_directory
end

def configure_git
  append_to_file '.gitignore', read_insert_file('.gitignore')
end

def configure_dockerignore
  append_to_file '.dockerignore', read_insert_file('.dockerignore')
end

def remove_default_files
  remove_file 'Dockerfile'
  remove_file 'config/credentials.yml.enc'
  remove_file 'config/master.key'
  remove_file 'config/database.yml'
  remove_file 'README.md'
end
