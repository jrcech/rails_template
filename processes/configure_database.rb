# frozen_string_literal: true

def configure_database
  pg_status = `pg_ctl status`
  run 'pg_ctl start' unless pg_status.include? 'server is running'

  rails_command 'db:drop' # TODO: tmp
  rails_command 'db:create'
  rails_command 'db:migrate'
end
