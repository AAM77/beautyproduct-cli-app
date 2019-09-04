# BeautyProduct

## [ NOTE ]: September 03, 2019: Returned to App. Cleaning up, refactoring, and expanding.

## Description

I came up with the idea for this app based on a desire to search for a product, not just by its name, but also by its ingredients.
Even though this particular program searches the sales page of cultbeauty.co.uk to provide details on beauty products, I felt it was a potentially useful idea that can be applied to other interests, such as health and nutrition. Instead of going through each item of interest and looking for a specific ingredient, one is able to search for products that have a specified ingredient or for ones that do not have it.

In its current state, the scraper’s CLI allows the user to:

(1) Print a numbered list of sale products by alphabetical order and allows the user to choose a list for more info<br />
(2) Print a numbered list of sale products by alphabetical order<br />
(3) Search by product name (searching by a keyword or substring works)<br />
(4) Search for products that contain a user-specified ingredient (searching with a keyword or substring works)<br />
(5) Search for products that do not contain a user-specified ingredient (searching with a keyword or substring works)<br />
<br />
(Typing ‘exit’ terminates the program).
<br />
Choosing (1) and (2) returns to the main menu after executing.<br />
Choosing (3), (4), and (5) displays a list of the products that match the search query.<br />
The program then asks the user to enter the number of the item the user is interested in to display its full info It then gives the user the option to (1) run the same search again, (2) return to the main menu, and to exit the program by typing ‘exit.’

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
Run the program by navigating to the ./beauty_product folder on your machine. If done using the GUI, double click on the beauty_product icon to run it. If done using the terminal, type ./bin/beauty_product in the terminal and hit enter. If you wish to experiment with the code, you can run the program with 'pry' by typing ./bin/console and then 'BeautyProduct::CLI.new.call' in the terminal.<br />
<br />
Upon execution, the program clears all previous information and then collects and stores all the current information posted on 'https://cultbeauty.co.uk/sale.html?'. This process will take less than a minute upon program initiation (approximately 32 seconds, give or take some). You will know the program is ready once you receive the welcome message and the menu options appear. You may receive an error if your internet connection times out. In this case, just run the program above, following the directions above.<br />
<br />
In its current state, the scraper’s CLI displays the following menu upon execution:
<br />
(1) Print a numbered list of sale products by alphabetical order and allows the user to choose a list for more info<br />
(2) Print a numbered list of sale products by alphabetical order<br />
(3) Search by product name (searching by a keyword or substring works)<br />
(4) Search for products that contain a user-specified ingredient (searching with a keyword or substring works)<br />
(5) Search for products that do not contain a user-specified ingredient (searching with a keyword or substring works)<br />
<br />
(Typing ‘exit’ terminates the program).
<br />
Choosing '1' prints an alphabetized list of products with their brand and sale price. The user will be prompted to enter a number to see more information about the product.<br />
<br />
Choosing '2' prints an alphabetized list of all of the ingredients present in the products on Cult Beauty's sales page and then returns to the main menu without prompting the user. This method serves only as an optional reference for the user to utilize in conjunction with main menu options (4) and (5).<br />
<br />
Choosing '3' allows the user to enter a keyword to search for a product by the product's name. The program conducts a case-insensitive search through the product names and print out a list of products that have the keyword in any part of their names. For example, typing 'L' will print all products that have an 'L' (uppercase or lower) in their names. After printing the list, the program prompts the user to enter a number corresponding the product's list number. This will print out more information for that product.<br />
<br />
Choosing '4' allows the user to search for products that have a specific ingredient in their ingredients list. The user can enter a keyword and the program will conduct a case-insensitive search through the products' ingredient lists and print out a list of products that have the queried keyword in any part of the ingredient names in their ingredients list. For example, typing 'L' will print all products that have an ingredient with 'L' (uppercase or lower) in its name. After printing the list, the program prompts the user to enter a number corresponding the product's list number. This will print out more information for that product.<br />
<br />
Choosing '5' allows the user to search for products that DO NOT have the user-specified product in their ingredients list. The user can enter a keyword and the program will conduct a case-insensitive search through the products' ingredient lists and print out a list of products that DO NOT have the queried keyword in any part of the ingredient names in their ingredients list. For example, typing 'L' will EXCLUDE all products that have an ingredient with 'L' (uppercase or lower) in its name. After printing the list, the program prompts the user to enter a number corresponding the product's list number. This will print out more information for that product.<br />
<br />
After displaying the product info, the program prompts the user to enter the number of the item the user is interested in to display its full info It then gives the user the option to (1) run the same search again, (2) return to the main menu, and (3) to exit the program by typing ‘exit.’<br />
<br />
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.<br />
<br />
To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).<br />

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/AAM77/beautyproduct-cli-app. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the BeautyProduct project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/AAM77/beautyproduct-cli-app/blob/master/CODE_OF_CONDUCT.md).

## License
The BeautyProduct project has an AGPL-3.0 license. You may view the contents of the license at [license](https://github.com/AAM77/beautyproduct-cli-app/blob/master/LICENSE)
