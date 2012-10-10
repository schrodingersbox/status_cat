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
* [The Semi-Isolated Rails Engine](http://bibwild.wordpress.com/2012/05/10/the-semi-isolated-rails-engine/)
* [config.reload_plugins = true only works in environment.rb](https://rails.lighthouseapp.com/projects/8994/tickets/2324-configreload_plugins-true-only-works-in-environmentrb?spam=1)

## TODO

* Status model
  * Figure out memoization and inheritance / module structure

* Status controller / view / helper

* Status mailer

* Extensible statuses

* Rake task to run status checks and output to console
* Rake task to run status checks and email on failure, suitable for crons