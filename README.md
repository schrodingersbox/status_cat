# schrodingersbox/status-cat README

This engine makes monitoring the status of your Rails environment easier

## Testing

    `rake spec-cat:coverage`

## Reference

 * [Getting Started with Engines](http://edgeguides.rubyonrails.org/engines.html)
 * [Testing Rails Engines With Rspec](http://whilefalse.net/2012/01/25/testing-rails-engines-rspec/)
 * [How do I write a Rails 3.1 engine controller test in rspec?](http://stackoverflow.com/questions/5200654/how-do-i-write-a-rails-3-1-engine-controller-test-in-rspec)
 * [Best practice for specifying dependencies that cannot be put in gemspec?](https://groups.google.com/forum/?fromgroups=#!topic/ruby-bundler/U7FMRAl3nJE)
 * [Clarifying the Roles of the .gemspec and Gemfile](http://yehudakatz.com/2010/12/16/clarifying-the-roles-of-the-gemspec-and-gemfile/)
 * [The Semi-Isolated Rails Engine](http://bibwild.wordpress.com/2012/05/10/the-semi-isolated-rails-engine/)
 * [config.reload_plugins = true only works in environment.rb](https://rails.lighthouseapp.com/projects/8994/tickets/2324-configreload_plugins-true-only-works-in-environmentrb?spam=1)
 * [describe vs. context in rspec](http://lmws.net/describe-vs-context-in-rspec)

## TODO

* Status mailer
* Rake task to run status checks and email on failure, suitable for crons

* Null username and password sneaking through action mailer checker

* Helper to determine if any checkers in a list failed

* Dynamically create rake tasks for each checker

* Add memory checker with externally configurable limit

* Access control for StatusCat::Status ... protected class methods suck

* Write RDoc
  * General checker concept
  * How to
    * Integrate into app as action
    * Run rake tasks
    * Periodic check and email on failure
  * Existing checkers
  * How to add a new checker
  * Shared spec

* Publish as gem