# Rails Template

Ruby on Rails 7 template for generating a new project with some pre-configured settings.

## What this template does?

### Generates a new Rails project

- New Rails 7 application with PostgreSQL, Bun, Bootstrap and Hotwire.

```shell
bundle exec rails new <ApplicationName> --database=postgresql --skip-test --javascript=bun --css=bootstrap
```

- Configures `.gitignore` a `.dockerignore` files.

### Setup development environment

- Debug tools (Bullet, BetterErrors, LetterOpener, ...).
- Linters (Overcommit, Rubocop, ESlint, Stylelint, Brakeman, ...).

### Setup test environment

- RSpec
- Capybara
- FactoryBot
- Faker
- Shoulda Matchers

### Setup staging environment

- Add and configure staging environment.

### Installs and configures production tools

- ViewComponent with custom components mapped to Bootstrap components.
- FontAwesome for icons with ViewComponent nad Stimulus.
- Pagy for pagination with ViewComponent and Stimulus.
- SolidQueue for background jobs with Puma plugin and PostgreSQL.
- MissionControl for monitoring background jobs.
- Authentication from scratch with Rails 7 best practices.
- Custom Helpers for common components.
- I18n ready for multiple languages.

### Scaffold (custom generators)

- Generates scaffold files from UML class diagram with associations, attributes and custom settings.
- Generates Factories for models.
- Generates RSpec tests with 100% coverage. (unit, integration, system)

### CI/CD

- Configures Terraform for managing infrastructure on Hetzner Cloud.
- Configures Dockerfile for various environments.
- Configures Docker Compose for development and testing.
- Installs and configures Kamal for deploying Dockerized application to any cloud provider.
- Configures GitHub Actions for running tests and deploying to Hetzner Cloud with Kamal.

```log
:article => {
  :belongs_to => [
    [0] :user
  ],
  :has_many => [
    [0] :review,
    [1] :comment,
    [2] :technology_assignment
  ],
  :attributes => [
    [0] {
      :name => "title:string",
      :flags => [
        [0] :required,
        [1] :search
      ]
    },
    [1] {
      :name => "content:text",
      :flags => [
        [0] :required
      ]
    }
  ]
}
```
