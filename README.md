# Processable


Ruby gem to help you organize any process into series of steps. 

```ruby
class PrintGithubRepos < Processable
  step :get_repos do
    github_client.where('rails', per_page: 100)
  end

  step :get_only_essential_fields do |repos_json|
    repos_json.except(:title, :description)
  end
  
  step :print_to_console do |repos_json|
    print repos_json
  end
end

PrintGithubRepos.new.process
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'processable'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install processable

## Usage

**Define new class with required behavior**

```ruby
class SiteScrapper < Processable
end
```

**Add steps to the process**

Each step accepts three optional paramaters: [result from_previous step, current_step, all_steps]. Each step has some result as we usually do it you can either call return explicitly or last line will be accepted as result of the step. 

```ruby
require 'net/http'

class SiteScrapper < Processable
  step :get_web_pages do
    Net::HTTP.get('example.com', '/index.html')    
  end
  
  step :save_to_database do |web_page|
    DB.save(web_page)
  end
end
```

**Add steps to the process**

To start the process simply call... 

```ruby
SiteScrapper.new.process
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Rukomoynikov/processable. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/Rukomoynikov/processable/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Processable project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/Rukomoynikov/processable/blob/master/CODE_OF_CONDUCT.md).
