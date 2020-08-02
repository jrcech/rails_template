# Basic generator commands

## Generate base app
```bash
rails new base -STB --database=postgresql --skip-spring --skip-turbolinks --skip-system-test --webpack=stimulus --skip-webpack-install
```

## Generate app fast with template
```bash
rails new test1 -m ./rails_template/template.rb -STB --database=postgresql --skip-spring --skip-turbolinks --skip-system-test --webpack=stimulus --skip-webpack-install
```