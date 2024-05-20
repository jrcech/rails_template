def configure_database
  pg_status = `pg_ctl status`
  run 'pg_ctl start' unless pg_status.include? 'server is running'

  rails_command 'db:drop' # TODO: tmp
  rails_command 'db:prepare'
end
