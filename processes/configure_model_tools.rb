def configure_model_tools
  template_into_file 'Gemfile', before: 'group :development, :test do'

  remove_file 'db/seeds.rb'

  process_directory
end
