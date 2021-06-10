# Basic generator commands

## Generate app with template (09-06-2021)
Generate a new Rails application with template:
```shell
rails new generated_rails -m ./rails_template/template.rb -ST --database=postgresql
```
> Required flags are `-ST --database=postgresql`.
> 
> Template uses `rails hotwire:install` generator which removes Turbolinks and install Turbo instead. It also installs Stimulus. So `--skip-turbolinks` and `--webpack=stimulus` flags are redundant.
>
> Skipping tests with `-T` or `--skip-test` will also skip system tests like with `--skip-system-test`.
> 
> `--skip-system-test` won't generate capybara, webdrivers and selenium gems and configrations but it will keep `test/` directory with TestUnit.
> 
> `-S` is `--skip-sprockets` flag. It removes sass gem, `spockets/railtie` and environment assets configurations.

## Generate base app
```bash
rails new base
```

## Generate app fast with template and force overwrite
```shell
rails new generated_rails -m ./rails_template/template.rb -fSTB --database=postgresql --skip-webpack-install
```
