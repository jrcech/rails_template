# Basic generator commands

## Generate base app
```bash
rails new base -STB --database=postgresql --skip-spring --skip-turbolinks --skip-system-test --webpack=stimulus --skip-webpack-install
```

## Generate complete app using template
```bash
rails new generated_rails -m ./rails_template/template.rb -ST --database=postgresql --skip-spring --skip-turbolinks --skip-system-test --webpack=stimulus
```
## Generate app fast with template and force overwrite
```shell
rails new generated_rails -m ./rails_template/template.rb -fSTB --database=postgresql --skip-spring --skip-turbolinks --skip-system-test --webpack=stimulus --skip-webpack-install
```