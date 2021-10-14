```plantuml
@startuml

skinparam monochrome true
skinparam shadowing false

class Universe {
  name:string --unique
  shortcut:string --unique
}

class Supercluster {
  name:string
  shortcut:string
}

class Cluster {
  name:string
  shortcut:string
}

class Galaxy {
   name:string
   shortcut:string
   galaxy_state:enum
}

class System {
  name:string
  shortcut:string
} 

class Star {
  name:string
  shortcut:string
  star_state:enum
}

class Planet {
  name:string
  shortcut:string
}

class Comet {
  name:string
  shortcut:string
}

class Satellite {
  name:string
  shortcut:string
}

enum star_state {
  :live
  :dwarf
  :supernova
  :black_hole
  :pulsar
}

enum galaxy_state {
  :live
  :quasar
}

Universe "1" <-- "*" Supercluster

Supercluster "1" <-- "*" Cluster

Cluster "1" <-- "*" Galaxy

Galaxy "1" <-- "*" System

System "1" <-- "*" Star

Star "1" <-- "*" Planet
Star "1" <-- "*" Comet
Star "1" <-- "*" Asteroid

Planet "1" <-- "*" Satellite
@enduml
```


```plantuml
@startuml

skinparam monochrome true
skinparam shadowing false

class DevOps {
  docker
  ansible
  terraForm
  docker_compose
  gitlab_ci
}

class Application {
  -- layout --
  application
  admin
  -- template engine --
  slim
  -- test framework --
  rspec
  faker
  capybara
  factory_bot
  -- mailer --
  mailgun
  -- localization --
  i18n
  globalize
  -- overcommit --
  all
  -- debug --
  all
}

class User <<devise>> {
  email: String
  username: String
  first_name: String
  last_name: String
  -- search --
  email
  username
  first_name
  last_name
  -- devise --
  database_authenticatable
  registerable
  recoverable
  rememberable
  validatable
  trackable
  confirmable
  lockable
  omniauthable
  -- omniauth providers --
  facebook
  google
  -- rolify --
  member
  admin
  owner
}

class Article <<acts_as_taggable_on>> {
  title: String
  content: Text
  -- search --
  title
}

User "1" <-- "*" Article

@enduml
```
