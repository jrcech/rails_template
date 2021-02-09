# New rails app generation process

```plantuml
@startuml

skinparam monochrome true
skinparam shadowing false

start
partition "Initial generation" {
  :rails new APP_PATH;
  note right
    --skip-turbolinks
    --skip-test
    --skip-system-test
    --skip-sprockets
    --webpack=stimulus
    --database=postgresql
  end note
  
  :remove redundant gems;
  note right
    tzinfo
  end note
  
  :bundle install;
  
  :after bundle;
  note left
    Including nodejs process
  end note
  
  :remove redundant dirs;
  note right
    app/assets
  end note
  
  :add inserts;
  note right
    to tmp
  end note
  
  :append_to_file '.gitignore';
  note left
    .DS_Store
    .idea
    .env
    .env.*
    /coverage
  end note
  
  :format files;
  note right
    Remove comments
    Add space after rails gem in Gemfile
  end note
  
  partition "Rails linters" {
    :add rails linters gems;
    note left
      Append to Gemfile:
      
      group :development do
        gem 'brakeman'
        gem 'bundler-audit'
        gem 'fasterer'
        gem 'flay'
        gem 'overcommit'
        gem 'rails_best_practices'
        gem 'reek'
        gem 'rubocop', require: false
        TODO: gem 'rubocop-rspec', require: false
        gem 'rubycritic', require: false
        TODO: gem 'slim_lint'
      end
    end note
    
    :bundle install;
    
    :copy configuration files;
    note right 
      copy_file './files/.flayignore', './'
      copy_file './files/.overcommit.yml', './'
      copy_file './files/.rails_best_practices.yml', './'
      copy_file './files/.reek.yml', './'
      copy_file './files/.rubocop.yml', './'
    end note
    
    :rubocop --auto-correct-all;
  }  
}

partition "Frontend linters" {
  :install frontend linters;
  note right
    eslint
    eslint-config-airbnb-base
    eslint-config-prettier
    eslint-import-resolver-webpack
    eslint-plugin-import
    eslint-plugin-prettier
    prettier
    stylelint
    stylelint-config-standard
  end note
  
  :copy configuration files;
  note left 
    .eslintr
    .prettierrc.json
    .stylelint.json
  end note
  
  :format files;
  note left 
    fix babel.config.js
    fix postcss.config.js
    add postcss dependencies
  end note
  
  :yarn run eslint . --fix;
}

:overcommit --install;

stop

@enduml
```

## Example
```plantuml
@startuml

skinparam monochrome true
skinparam shadowing false

start
:ClickServlet.handleRequest();
:new page;
if (Page.onSecurityCheck) then (true)
  :Page.onInit();
  if (isForward?) then (no)
    :Process controls;
    if (continue processing?) then (no)
      stop
    endif

    if (isPost?) then (yes)
      :Page.onPost();
    else (no)
      :Page.onGet();
    endif
    :Page.onRender();
  endif
else (false)
endif

if (do redirect?) then (yes)
  :redirect process;
else
  if (do forward?) then (yes)
    :Forward request;
  else (no)
    :Render page template;
  endif
endif

stop

@enduml
```