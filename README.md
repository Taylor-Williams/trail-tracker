# Trail-Tracker
basic Sinatra Create, Read, Update, Destroy application to track the trails you have hiked
# Installation
to get started with Trail Tracker clone the github repository, run bundle install, and run the database migrations
```ruby
git clone https://github.com/Taylor-Williams/trail-tracker.git
```
    $ bundle install

    $ rake db:migrate

# Usage
dummy objects have been included in seeds.rb but are commented out. to play with Trail Tracker uncomment them, otherwise leave them as they are.
you MUST run

    $ rake db:seed

as that is how the program loads in the information for the States.
afterwards run

    $ shotgun

and the Trail Tracker is at your disposal.
# Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/Taylor-Williams/trail-tracker. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.
# License
The app is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
# Code of conduct
Everyone interacting in the Trail Tracker project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the code of conduct.
