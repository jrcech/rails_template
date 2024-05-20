def configure_generators
  remove_lines 'config/application.rb', 'config.generators.system_tests'

  template_into_file 'config/application.rb', before: second_last_end
end
