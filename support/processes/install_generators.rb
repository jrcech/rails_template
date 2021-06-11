# frozen_string_literal: true

def install_generators
  directory 'files/install_generators', './'
  unlock_templates 'lib'
end
