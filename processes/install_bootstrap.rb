# frozen_string_literal: true

def install_bootstrap
  add_bs_controller
  configure_bs_layout
  remove_redundant_bs_import
end

def add_bs_controller
  template 'app/javascript/controller/bs_controller.js.tt'

  run 'rails stimulus:manifest:update'
end

def configure_bs_layout
  template_into_file(
    'app/views/layout/application.html.slim',
    after: 'body'
  )

  template_into_file(
    'app/views/layout/admin.html.slim',
    after: 'body'
  )
end

def remove_redundant_bs_import
  remove_lines 'app/javascript/application.js', 'import * as bootstrap'
end
