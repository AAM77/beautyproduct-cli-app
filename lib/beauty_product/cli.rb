class BeautyProduct::CLI

  def call
    menu
  end # call



  def menu
    user_input = nil

    until user_input == 'exit'
      puts "Please select an option from the menu:"

      puts "1. Search by Product Name"
      puts "2. Search by Ingredient (products that have it)"
      puts "3. Search by Ingredient (products that do not have it)"

      user_input = gets.downcase.strip

      if user_input.to_i > 0
        if user_input == "1"
          puts "Product's name"
          puts "Do you want to see this product's ingredients? (y/n)"
          yes_no = gets.downcase.strip
          case yes_no
          when 'y', 'yes'
            puts "The Ingredients..."
          else
            "Exiting Program. Good bye."
          end # case yes_no

          ## give options for ingredients
        elsif user_input == "2"
          puts "253 products include this ingredient."
          puts "Please enter product name:"
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
