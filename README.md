# schrodingersbox/status-cat README

This engine makes monitoring the status of your Rails environment easier

## Testing

    `rspec spec && open coverage/index.html`

## Reference

* [Getting Started with Engines](http://edgeguides.rubyonrails.org/engines.html)
* [Testing Rails Engines With Rspec](http://whilefalse.net/2012/01/25/testing-rails-engines-rspec/)
* [How do I write a Rails 3.1 engine controller test in rspec?](http://stackoverflow.com/questions/5200654/how-do-i-write-a-rails-3-1-engine-controller-test-in-rspec)
* [Best practice for specifying dependencies that cannot be put in gemspec?](https://groups.google.com/forum/?fromgroups=#!topic/ruby-bundler/U7FMRAl3nJE)
* [Clarifying the Roles of the .gemspec and Gemfile](http://yehudakatz.com/2010/12/16/clarifying-the-roles-of-the-gemspec-and-gemfile/)

## TODO

* Status model
  * Add name
  * Memoize values

* Status controller / view / helper

* Status mailer

* ActiveRecord status
* ActionMailer status
* Extensible statuses

* Rake task to run status checks and output to console
* Rake task to run status checks and email on failure, suitable for crons