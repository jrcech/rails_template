def install_simple_form
  install_gems

  run 'rails generate simple_form:install --bootstrap'
end
