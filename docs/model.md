# Blogger model diagram in UML

```plantuml
@startuml

class User {
  email:string :required :unique :search
  username:string :unique :search
  first_name:string :search
  last_name:string :search
}

class Article {
  title:string :required :search
  content:text :required
}

class Technology {
  title:string :required :search
  shortcut:string :search
  homepage:string
}

class Comment {
  title:string :required :search
  content:text :required
}

class Review {
  title:string :required :search
  content:text :required
}

User "1" -- "*" Article
User "1" -- "*" Review
User "1" -- "*" Comment

Article "1" -- "*" Review
Article "1" -- "*" Comment

Article "1" -- "*" TechnologyAssignment
Technology "1" -- "*" TechnologyAssignment

@enduml
```
