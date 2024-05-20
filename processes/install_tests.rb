def install_tests
  append_to_file 'Gemfile', read_insert_file('Gemfile')

  configure_bullet_development
  configure_test_generators

  process_directory
end

def configure_bullet_development
  template_into_file(
    'config/environments/development.rb',
    after: "config.action_controller.raise_on_missing_callback_actions = true\n"
  )
end

def configure_bullet_test
  template_into_file(
    'config/environments/test.rb',
    after: "config.action_controller.raise_on_missing_callback_actions = true\n"
  )
end

def configure_test_generators
  template_into_file(
    'config/application.rb',
    after: "config.generators do |generator|\n"
  )
end
