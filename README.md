# BeautyProduct

## Description

I came up with the idea for this app based on a desire to search for a product, not just by its name, but also by its ingredients.
Even though this particular program searches the sales page of cultbeauty.co.uk to provide details on beauty products, I felt it was a potentially useful idea that can be applied to other interests, such as health and nutrition. Instead of going through each item of interest and looking for a specific ingredient, one is able to search for products that have a specified ingredient or for ones that do not have it.

In its current state, the scraper’s CLI allows the user to:

(1) Print a numbered list of sale products by alphabetical order
(2) Print a numbered list of sale products by alphabetical order
(3) Search by product name (searching by a keyword or substring works)
(4) Search for products that contain a user-specified ingredient (searching with a keyword or substring works)
(5) Search for products that do not contain a user-specified ingredient (searching with a keyword or substring works)

(Typing ‘exit’ terminates the program).

Choosing (1) and (2) returns to the main menu after executing. Choosing (3), (4), or (5) gives the user the option to run the same search again.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'beauty_product'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install beauty_product

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/AAM77/beautyproduct-cli-app. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the BeautyProduct project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/AAM77/beautyproduct-cli-app/blob/master/CODE_OF_CONDUCT.md).

## License
The BeautyProduct project has an AGPL-3.0 license. You may view the contents of the license at [license](https://github.com/AAM77/beautyproduct-cli-app/blob/master/LICENSE)
