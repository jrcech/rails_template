def install_pagy
  install_gems

  template_into_file(
    'app/controllers/application_controller.rb',
    after: "class ApplicationController < ActionController::Base\n"
  )

  template_into_file(
    'app/helpers/application_helper.rb',
    after: "module ApplicationHelper\n"
  )
end
