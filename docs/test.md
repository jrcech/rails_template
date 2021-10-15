```plantuml
@startuml

skinparam monochrome true
skinparam shadowing false

class Universe {
  name:string --unique --search
  shortcut:string --unique
  shortcut:string
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

Satellite "1" <-- "*" Small

Supercluster "1" <-- "*" Cluster
Star "1" <-- "*" Comet

  Universe "1" <-- "*" Supercluster
Cluster "1" <-- "*" Galaxy

Galaxy "1" <-- "*" System
System "1" <-- "*" Star
Galaxy "1" <-- "*" Pulsar

Universe "1" <-- "*" Test
God "1" <-- "*" Jirka

Pulsar "1" <-- "*" Pulsik
Pulsar "1" <-- "*" Puls

Star "1" <-- "*" Planet
Star "1" <-- "*" Asteroid

Planet "1" <-- "*" Satellite
@enduml
```
