# Build system

The build system of Arva is developed in Python 
and intended to be as easy as possible. 
## Introduction
From the very first to the very last, 
the SDK is participated in simple components that have up to 4 variables:
1. Name
2. Description
3. What should be executed
4. Child components

If there is a child component it will look in the run commando and runs it.

The project and their components are described in ``global.yml``:
````yaml
project:
  name: "test_application"
  relative_root: "./" # Project root relative to global.yml
  
component_name:
  version: 1.0
  components:
    - component_name:
      path: path/to/spec.yml's/dir/
````
Even the SDK itself is defined as a component. 
The path can also be the file, instead being the file's directory.
### Add a new component
To add a new component to the SDK, head to the ``global.yml``:
````yaml
...
sdk:
  version: 0.1-dev
  components:
    - engine:
      description: "..."
      path: engine/
      
    - test_component:
      description: "New component for tests."
      path: test/
...
````
## From source to binaries
Because