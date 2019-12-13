# The Music Connection (CS169 - FA19 - Team 12)

[![Maintainability](https://api.codeclimate.com/v1/badges/f4312e27919640b161a7/maintainability)](https://codeclimate.com/github/jie-luo/The-Music-Connection/maintainability)

[![Test Coverage](https://api.codeclimate.com/v1/badges/f4312e27919640b161a7/test_coverage)](https://codeclimate.com/github/jie-luo/The-Music-Connection/test_coverage)

[![Build](https://travis-ci.org/jie-luo/The-Music-Connection.svg?branch=master)](https://travis-ci.org/jie-luo/The-Music-Connection)

Our project is to develop a matching system for pairing music tutors in our club with the music teachers and students in the community who would like to receive support in school music programs or receive private music lessons.

### Setup

```
bundle install --without production
rake db:setup
rails server
```

### Docker

Please read Docker_README on how to set up and run this project with Docker.

### App Usage

For admin controls, please use the '/admin' path to locate the controls. The default password is set to "password" and should be changed immediately once use of the app begins. 
