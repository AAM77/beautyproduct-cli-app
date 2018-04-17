class BeautyProduct::CLI
  # BeautyProduct::CLI.call

  def call
    puts "One moment, please."
    puts "This should take less than a minute..."

    BeautyProduct::Scraper.new
    main_menu
  end # call

  def menu_options
    puts "\nPlease select an option from the menu:"

    puts "1. List Products"
    puts "2. List Ingredients"
    puts "3. Search Product by Name"
    puts "4. Search by Ingredient (products that have it)"
  end # menu_options

  def main_menu
    user_input = nil

    menu_options
    user_input = gets.downcase.strip

    case user_input
    when "1"
      list_products
      puts "\n"
      main_menu
    when "2"
      list_ingredients
      puts "\n"
      main_menu
    when "3"
      match_product
      return_to_main_menu?
    when "4"
      match_yes_ingredient
      return_to_main_menu?
    when "exit"
      puts "Exiting program. Goodbye!"
      return
    else
      puts "INVALID ENTRY!"
      main_menu
    end # case user_input
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
      puts "#{product.name} - (BRAND: #{product.brand}) - $#{product.price}"
      product.ingredients.nil? ? puts "No Ingredients Listed" : puts "Ingredients include: #{product.ingredients_string}"

    elsif product.nil? || product.empty?
      puts "PRODUCT NOT FOUND"
      product_menu
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
      ingredients.each.with_index(1) do |ingredient, index|
        ingredient.products.each do |product|
          puts ""
          puts "#{index}. #{product.name} - (BRAND: #{product.brand}) - $#{product.price}"
          puts "Ingredients include: #{product.ingredients_string}"
        end # do |product|
      end #do |ingredient|

    else
      puts "Ingredient not found. Type 'main menu' or 'exit'"
    end # if user_input in products
  end # match_yes_ingredient



  def list_products
    puts "The items on sale include:"
    product_names = BeautyProduct::Product.all.collect { |product| [product.name, product.brand] }
    product_names.sort.each.with_index { |product, index| puts "#{index}. #{product[0]}" }
  end # list_products

  def product_menu
    puts "Type 'run again', 'main menu', or 'exit'"
    user_choice = gets.downcase.strip

    case user_choice
    when "run again"
      match_product
    when "main menu"
      main_menu
    when "exit"
      return
    else
      "Invalid entry. Pick a valid option."
      product_menu
    end # case user_choice
  end # product_menu

  def ingredient_menu
    puts "Product not found. Type 'run again', 'main menu', or 'exit'"
    user_choice = gets.downcase.strip

    case user_choice
    when "run again"
      match_yes_ingredient
    when "main menu"
      main_menu
    when "exit"
      return
    else
      "Invalid entry. Pick a valid option."
      ingredient_menu
    end # case user_choice
  end # product_menu
  ## Might Need to Delete


  def return_to_main_menu?
    puts "\nDo you wish to return to the main menu? (yes/no)"
    puts "Typing 'n', 'no', or 'exit' will quit the program."
    user_input = gets.downcase.strip

    case user_input
    when "y", "yes"
      main_menu
    when "n", "no"
      return
    when "exit"
      return
    else
      "Invalid entry."
      return_to_main_menu?
    end # case user_input
  end # return_to_main_menu?

end # class CLI
