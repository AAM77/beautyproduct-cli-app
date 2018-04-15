class BeautyProduct::CLI

  def call
    BeautyProduct::Product.products
    BeautyProduct::Product.ingredient
    main_menu
  end # call

  def main_menu
    user_input = nil

    puts "Please select an option from the menu:"

    puts "1. Search Product by Name"
    puts "2. Search by Ingredient (products that have it)"
    puts "3. Search by Ingredient (products that do not have it)"
    user_input = gets.downcase.strip


    case user_input
    when "1"
      match_product
    when "2"
      match_yes_ingredient
    when "exit"
      puts "Exiting program. Goodbye!"
      return
    else
      puts "INVALID ENTRY!"
      call
    end # case user_input
=begin
      if user_input == "1"
        match_product
      elsif user_input == 'exit'
        puts "Goodbye"
        return
      else
        puts "INVALID ENTRY!"
        call
      end # if
    end # until 'exit'
=end

  end # main_menu


  def match_product
    user_input = nil
    puts "Enter product name to see its ingredients or type exit:"
    user_input = gets.downcase.strip

    product = BeautyProduct::Product.all.detect { |element| user_input == element.name.downcase }

    if product != nil
      puts ""
      puts "================="
      puts "= Product Found ="
      puts "================="
      puts "#{product.name} - #{product.price}"
      puts "Ingredients include: #{product.ingredients}"
    else
      puts "Product not found. Type 'main menu' or 'exit'"
      call
    end # if not nil
  end # match_product

  def match_yes_ingredient
    user_input = nil
    puts "Enter ingredient name for a list of products or type exit:"
    user_input = gets.downcase.strip

    ingredients = BeautyProduct::Ingredient.all.select { |element| element.name.downcase == user_input }

    if ingredients != nil
      puts ""
      puts "=================="
      puts "= Products Found ="
      puts "=================="
      ingredients.each.with_index(1) do |ingredient, i|
        ingredient.products.each do |product|
          puts ""
          puts "#{i}. #{product.name} - #{product.price}"
          puts "Ingredients include: #{product.ingredients}"
        end # do |product|
      end #do |ingredient|

    else
      puts "Ingredient not found. Type 'main menu' or 'exit'"
      call
    end # if user_input in products
  end # match_yes_ingredient


end # class








=begin

def product_options(product)
  user_input = nil
  puts "Do you want to see its ingredients? (y/n)"
  user_input = gets.downcase.strip

  if user_input == "yes" || user_input == 'y'
    puts "#{product.ingredients}"
  elsif user_input == "no" || user_input == 'n'
    call
  else
    puts "INVALID ENTRY."
    puts "Type yes, no, or exit."
  end # if yes/no
end # product_options


        if BeautyProduct::CLI.products.include?(product_choice)

        puts "Do you want to see this product's ingredients? (y/n)"
        yes_no = gets.downcase.strip
        case yes_no
        when 'y', 'yes'
          BeautyProduct::Product.products[1].ingredients
        else
          "Exiting Program. Good bye."
        end # case yes_no

        ## give options for ingredients
      elsif user_input == "2"
        puts "253 products include this ingredient."
        puts "Please enter product name:"

      elsif user_input == "3"
        ## list number of products that DO NOT include this ingredient
        ## offer the option of searching for the product by name
      else
        puts "Invalid Entry. Choose option 1, 2 , 3, or type 'exit'"
      end # user_input == //
    end # until - 'exit'

  end # menu



  def menu_options
    puts "Please select an option from the menu:"

    puts "1. Search by Product Name"
    puts "2. Search by Ingredient (products that have it)"
    puts "3. Search by Ingredient (products that do not have it)"
  end # main_menu




end # class BeautyProduct

=end
