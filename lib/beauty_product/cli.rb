class BeautyProduct::CLI

  def call
    menu
  end # call



  def menu
    puts "Hello and Welcome"
    puts "Please select an option from the menu:"

    puts "1. Search by Product Name"
    puts "2. Search by Ingredient (products that have it)"
    puts "3. Search by Ingredient (products that do not have it)"

    user_input = gets.downcase.strip

    until user_input == 'exit'
      if user_input.to_i > 0
        if user_input == "1"
          puts "Product name"
          ## give options for ingredients
        elsif user_input == "2"
          ## list number of products that include this ingredient
          ## offer the option of searching for the product by name
        elsif user_input == "3"
          ## list number of products that DO NOT include this ingredient
          ## offer the option of searching for the product by name
        end # user_input == //
      else
        puts "Invalid Entry. Choose option 1, 2 , 3, or type 'exit'"
      end # .to_i > 0
    end # until - 'exit'

  end # menu



end # class BeautyProduct
