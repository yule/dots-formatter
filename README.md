# Dots formatter

An RSpec formatter that has nothing to do with dots, honest.

Format your Rspec output simply, but informatively.

For example, running with guard, your RSpec output could look like
this:

![Passing](docs/all_passing.jpg))

Or get instance feedback when an example fails:

![Failing](docs/with_failure.jpg))

If you set debug mode to true then you can get each test on a new line
with the time taken for each test.

Currently only works with RSpec 3 and up.


To run, first install the gem:
```ruby
gem install dots_formatter
```

then in either a project specific .rspec file or
in your home .rspec file, or directly on the command line:

```ruby
--format DotsFormatter
```

## TODO

* Better Readme
* Debug as command line option
* Tests
