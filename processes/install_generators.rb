# frozen_string_literal: true

def install_generators
  copy_generators
  configure_generators
end

def copy_generators
  directory 'files/install_generators', './'

  unlock_templates 'lib'
end

def configure_generators
  remove_lines 'config/application.rb', 'config.generators.system_tests'

  template_into_file 'config/application.rb', before: second_last_end
end
