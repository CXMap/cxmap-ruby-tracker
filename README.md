# CXMap Ruby Tracker

Ruby tracker for https://cxmap.io. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cxmap-tracker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cxmap-tracker

## Usage

Setup CXMap settings

```ruby
CXMap.setup do |config|
  # timeout, default 10 sec
  # config.tracker_timeout = 10
end
```

Tack events
```ruby
app_key = 'xxx'
tracker_domain = 'your_tracker.cxmap.io'

tracker = CXMap::Tracker.new(app_key, tracker_domain)
tracker.track('update_person', {person: {client_id: 'yyy'}})
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/CXMap/cxmap-ruby-tracker. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

