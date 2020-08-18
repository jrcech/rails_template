```plantuml
@startuml

skinparam monochrome true
skinparam shadowing false

class Foo1 {
  You can use
  several lines
  ..
  as you want
  and group
  ==
  things together.
  __
  You can have as many groups
  as you want
  --
  End of class
}

class Role <<rolify>> {
  name: String
}

class User <<devise>> {
  email: String
  username: String
  first_name: String
  last_name: String

  .. Simple Getter ..
  + getName()
  + getAddress()
  .. Some setter ..
  + setName()
  __ private data __
  int age
  -- encrypted --
  String password
}

class Article {
  title: String
  content: Text
}

class Tag <<acts_as_taggable_on>> {

}

User "*" <--> "*" Role

User "1" <-- "*" Article
Article "1" <-- "*" Article : Previous
Article "1" <-- "*" Article : Next

Article "*" <--> "*" Tag

@enduml
```
