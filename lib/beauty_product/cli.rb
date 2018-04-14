class BeautyProduct::CLI

  def call
    main_menu
  end # call

  def main_menu
    #downcase_product_names = BeautyProduct::Product.all.collect {|product| product.name.downcase}

    ## menu_options # <=# reads out the menu options

    user_input = nil

      puts "Please select an option from the menu:"

      puts "1. Search Product by Name"
      puts "2. Search by Ingredient (products that have it)"
      puts "3. Search by Ingredient (products that do not have it)"
      user_input = gets.downcase.strip

      until user_input == 'exit'
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
  end # main_menu


  def match_product
    user_input = nil
    puts "Enter product name:"
    user_input = gets.downcase.strip

    BeautyProduct::Product.all.each do |product|
      if product.name.downcase == user_input
        puts "#{product.name}"
        product_options(product)
      else
        puts "Product not found. Type 'main menu' or 'exit'"
        call
      end # if user_input in products
    end # do |product|

  end # match_product

  def product_options(product)
    puts "Do you want to see its ingredients? (y/n)"
    user_input = gets.downcase.strip

    if user_input == "yes" || user_input == 'y'
      product.ingredients
    elsif user_input == "no" || user_input == 'n'
      call
    else
      puts "INVALID ENTRY."
      puts "Type yes, no, or exit."
    end # if yes/no
  end # product_options


end # class








=begin




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
