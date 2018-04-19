class BeautyProduct::CLI

  def call
    puts "One moment, please."
    puts "This should take less than a minute..."

    BeautyProduct::Scraper.new
    main_menu
  end # call

  def main_menu_options
    puts "\nPlease select an option from the menu:"

    puts "1. List Products"
    puts "2. List Ingredients"
    puts "3. Search Product by Name"
    puts "4. Search by Ingredient (products that have it)"
    puts "5. Search by Ingredient (products that DO NOT have it)"
  end # menu_options

  def main_menu
    user_input = nil

    main_menu_options
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
    when "4"
      match_yes_ingredient
    when "5"
      match_no_ingredient
    when "exit"
      puts "Exiting program. Goodbye!"
      return
    else
      puts "\nINVALID ENTRY!"
      main_menu
    end # case user_input
  end # main_menu

  def list_products
    product_names = BeautyProduct::Product.all.collect { |product| [product.name, product.brand] } ## might need to remove array and product.brand
    puts "\n#{product_names.size} products found"
    puts "The following items are on sale:"
    product_names.sort.each.with_index(1) { |product, index| puts "#{index}. #{product[0]}" }
  end # list_products

  def list_ingredients
    ingredient_names = BeautyProduct::Ingredient.all.collect { |ingredient| ingredient.name }.uniq
    puts "\n#{ingredient_names.size} ingredients found"
    puts "The following ingredients are found in the on sale items:"
    ingredient_names.sort.each.with_index(1) { |ingredient, index| puts "#{index}. #{ingredient}" }
  end # list_ingredients

  #######################################################
  ## Searches for products with specified keyword/name ##
  #######################################################
  def match_product
    user_input = nil
    puts "Enter product name to see its ingredients or type exit:"
    user_input = gets.downcase.strip

    products = BeautyProduct::Product.all.select { |element| element.name.downcase.include?(user_input) }

    if products.nil? || products.empty?
      puts "\nSORRY. Your search returned 0 results."
      product_menu
    elsif !products.nil?
      puts "\nSearching for products with '#{user_input}' in their name..."
      puts "\n==================================="
      puts "= #{products.size} Products Found ="
      puts "==================================="
      products.each.with_index(1) do |product, index|
        puts "\n#{index}. #{product.name} - (BRAND: #{product.brand}) - $#{product.price}"
      end # do |product|
      full_product_info(products)
      product_menu
    end # if nil / not nil
  end # match_product

  #######################################################
  ## Searches for products WITH specified ingredient##
  #######################################################
  def match_yes_ingredient
    user_input = nil
    puts "Enter ingredient name for a list of products or type exit:"
    user_input = gets.downcase.strip

    products = BeautyProduct::Product.all.select { |element| element.ingredients_string.downcase.include?(user_input) if element.ingredients_string }

    if products.nil? || products.empty?
      puts "\nSORRY. Your search returned 0 results."
      yes_ingredient_menu
    elsif !products.nil?
      puts "\nSearching for products with '#{user_input}'..."
      puts "\n==================================="
      puts "= #{products.size} Products Found ="
      puts "==================================="
      products.each.with_index(1) do |product, index|
        puts "\n#{index}. #{product.name} - (BRAND: #{product.brand}) - $#{product.price}"
      end # do |product|
      full_product_info(products)
      yes_ingredient_menu
    end # if user_input in products
  end # match_yes_ingredient

  #######################################################
  ## Searches for products WITHOUT specified ingredient##
  #######################################################
  def match_no_ingredient
    user_input = nil
    puts "Enter ingredient name for a list of products or type exit:"
    user_input = gets.downcase.strip

    products = BeautyProduct::Product.all.select { |element| !element.ingredients_string.downcase.include?(user_input) if element.ingredients_string }

    if products.nil? || products.empty?
      puts "\nSORRY. Your search returned 0 results."
      no_ingredient_menu
    elsif !products.nil?
      puts "\nSearching for products without '#{user_input}'..."
      puts "\n==================================="
      puts "= #{products.size} Products Found ="
      puts "==================================="
      products.each.with_index(1) do |product, index|
        puts "\n#{index}. #{product.name} - (BRAND: #{product.brand}) - $#{product.price}"
      end # do |product|
      full_product_info(products)
      no_ingredient_menu
    end # if user_input in products
  end # match_yes_ingredient

  def full_product_info(products)
    user_selection = nil

    until (!user_selection.nil? && 1 <= user_selection && user_selection <= products.size)
      puts "\nEnter a valid item number from the list see more information (1 - #{products.size}):"
      user_selection = gets.downcase.strip.to_i
    end # until

    product_index = (user_selection - 1)
    product = products[product_index]

    puts "\nProduct Name: #{product.name}"
    puts "Product Brand: #{product.brand}"
    puts "Product Price: $#{product.price}"

    puts "\nProduct Description:"
    puts "#{product.description}"

    puts "\nHow to Use:"
    puts "#{product.directions}"

    puts "\nIngredients include:"
    product.ingredients_string.nil? ? (puts "No Ingredients listed for this product.") : (puts "#{product.ingredients_string}")
  end # print_product_info


  #######################################################
  ## SUB-MENUS for MAIN-MENU OPTIONS##
  #######################################################

  def sub_menu_options_text
    puts "\nWhat else would you like to do?"
    puts "1. Search again"
    puts "2. Go to the Main Menu"
    puts "Type 'exit' to exit the program."
  end # sub_menu_options_text

  ## DELETE ONCE YOU REPLACE WITH UNIVERSAL SUB-MENU
  ##FIRST: NEED TO FIGURE OUT HOW TO CORRECTLY PASS METHOD AS PARAMETER
  def product_menu
    sub_menu_options_text
    user_input = gets.downcase.strip

    case user_input
    when "1", "search again"
      match_product
    when "2", "main menu"
      main_menu
    when "exit"
      puts "Exiting the program. Goodbye!"
      return
    else
      puts "\nINVALID ENTRY"
      product_menu
    end # case user_input
  end # product_menu

  ## DELETE ONCE YOU REPLACE WITH UNIVERSAL SUB-MENU
  ##FIRST: NEED TO FIGURE OUT HOW TO CORRECTLY PASS METHOD AS PARAMETER
  def yes_ingredient_menu
    sub_menu_options_text
    user_input = gets.downcase.strip

    case user_input
    when "1", "search again"
      match_yes_ingredient
    when "2", "main menu"
      main_menu
    when "exit"
      puts "Exiting the program. Goodbye!"
      return
    else
      puts "\nINVALID ENTRY"
      yes_ingredient_menu
    end # case user_input
  end # ingredient_menu
  ## Might Need to Delete

  ## DELETE ONCE YOU REPLACE WITH UNIVERSAL SUB-MENU
  ## FIRST: NEED TO FIGURE OUT HOW TO CORRECTLY PASS METHOD AS PARAMETER
  def no_ingredient_menu
    sub_menu_options_text
    user_input = gets.downcase.strip

    case user_input
    when "1", "search again"
      match_no_ingredient
    when "2", "main menu"
      main_menu
    when "exit"
      puts "Exiting the program. Goodbye!"
      return
    else
      puts "\nINVALID ENTRY"
      no_ingredient_menu
    end # case user_input
  end # ingredient_menu
end # class CLI
###################
## END OF CLASS  ##
###################




###########################
##     PREVIOUS CODE     ##
##########################
=begin
class BeautyProduct::CLI

  def call
    puts "One moment, please."
    puts "This should take less than a minute..."

    BeautyProduct::Scraper.new
    main_menu
  end # call

  def main_menu_options
    puts "\nPlease select an option from the menu:"

    puts "1. List Products"
    puts "2. List Ingredients"
    puts "3. Search Product by Name"
    puts "4. Search by Ingredient (products that have it)"
    puts "5. Search by Ingredient (products that DO NOT have it)"
  end # menu_options

  def main_menu
    user_input = nil

    main_menu_options
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
    when "4"
      match_yes_ingredient
    when "5"
      match_no_ingredient
    when "exit"
      puts "Exiting program. Goodbye!"
      return
    else
      puts "\nINVALID ENTRY!"
      main_menu
    end # case user_input
  end # main_menu

  def list_products
    product_names = BeautyProduct::Product.all.collect { |product| [product.name, product.brand] } ## might need to remove array and product.brand
    puts "\n#{product_names.size} products found"
    puts "The following items are on sale:"
    product_names.sort.each.with_index(1) { |product, index| puts "#{index}. #{product[0]}" }
  end # list_products

  def list_ingredients
    ingredient_names = BeautyProduct::Ingredient.all.collect { |ingredient| ingredient.name }.uniq
    puts "\n#{ingredient_names.size} ingredients found"
    puts "The following ingredients are found in the on sale items:"
    ingredient_names.sort.each.with_index(1) { |ingredient, index| puts "#{index}. #{ingredient}" }
  end # list_ingredients

  #######################################################
  ## Searches for products with specified keyword/name ##
  #######################################################
  def match_product
    user_input = nil
    puts "Enter product name to see its ingredients or type exit:"
    user_input = gets.downcase.strip

    products = BeautyProduct::Product.all.select { |element| element.name.downcase.include?(user_input) }

    if products.nil? || products.empty?
      puts "\nPRODUCT NOT FOUND."
      product_menu
    elsif !products.nil?
      puts "\nSearching for products with '#{user_input}' in their name..."
      puts "\n==================================="
      puts "= #{products.size} Products Found ="
      puts "==================================="
      products.each.with_index(1) do |product, index|
        puts "\n#{index}. #{product.name} - (BRAND: #{product.brand}) - $#{product.price}"
        product.ingredients_string.nil? ? (puts "No Ingredients listed for this product.") : (puts "Ingredients include: #{product.ingredients_string}")
      end # do |product|
      product_menu
    end # if not nil
  end # match_product

  #######################################################
  ## Searches for products WITH specified ingredient##
  #######################################################
  def match_yes_ingredient
    user_input = nil
    puts "Enter ingredient name for a list of products or type exit:"
    user_input = gets.downcase.strip

    products = BeautyProduct::Product.all.select { |element| element.ingredients_string.downcase.include?(user_input) if element.ingredients_string }

    if products.nil? || products.empty?
      puts "\nNO PRODUCTS WITH THIS INGREDIENT."
      yes_ingredient_menu
    elsif !products.nil?
      puts "\nSearching for products with '#{user_input}'..."
      puts "\n==================================="
      puts "= #{products.size} Products Found ="
      puts "==================================="
      products.each.with_index(1) do |product, index|
        puts "\n#{index}. #{product.name} - (BRAND: #{product.brand}) - $#{product.price}"
        puts "Ingredients include: #{product.ingredients_string}"
      end # do |product|
      yes_ingredient_menu
    end # if user_input in products
  end # match_yes_ingredient

  #######################################################
  ## Searches for products WITHOUT specified ingredient##
  #######################################################
  def match_no_ingredient
    user_input = nil
    puts "Enter ingredient name for a list of products or type exit:"
    user_input = gets.downcase.strip

    products = BeautyProduct::Product.all.select { |element| !element.ingredients_string.downcase.include?(user_input) if element.ingredients_string }

    if products.nil? || products.empty?
      puts "\nSORRY. Your search returned no results."
      no_ingredient_menu
    elsif !products.nil?
      puts "\nSearching for products without '#{user_input}'..."
      puts "\n==================================="
      puts "= #{products.size} Products Found ="
      puts "==================================="
      products.each.with_index(1) do |product, index|
        puts "\n#{index}. #{product.name} - (BRAND: #{product.brand}) - $#{product.price}"
        puts "Ingredients include: #{product.ingredients_string}"
      end # do |product|
      no_ingredient_menu
    end # if user_input in products
  end # match_yes_ingredient


  #######################################################
  ## SUB-MENUS for MAIN-MENU OPTIONS##
  #######################################################

  def sub_menu_options_text
    puts "\nWhat else would you like to do?"
    puts "1. Search again"
    puts "2. Go to the Main Menu"
    puts "Type 'exit' to exit the program."
  end # sub_menu_options_text

  ## DELETE ONCE YOU REPLACE WITH UNIVERSAL SUB-MENU
  ##FIRST: NEED TO FIGURE OUT HOW TO CORRECTLY PASS METHOD AS PARAMETER
  def product_menu
    sub_menu_options_text
    user_input = gets.downcase.strip

    case user_input
    when "1", "search again"
      match_product
    when "2", "main menu"
      main_menu
    when "exit"
      puts "Exiting the program. Goodbye!"
      return
    else
      puts "\nINVALID ENTRY"
      product_menu
    end # case user_input
  end # product_menu

  ## DELETE ONCE YOU REPLACE WITH UNIVERSAL SUB-MENU
  ##FIRST: NEED TO FIGURE OUT HOW TO CORRECTLY PASS METHOD AS PARAMETER
  def yes_ingredient_menu
    sub_menu_options_text
    user_input = gets.downcase.strip

    case user_input
    when "1", "search again"
      match_yes_ingredient
    when "2", "main menu"
      main_menu
    when "exit"
      puts "Exiting the program. Goodbye!"
      return
    else
      puts "\nINVALID ENTRY"
      yes_ingredient_menu
    end # case user_input
  end # ingredient_menu
  ## Might Need to Delete

  ## DELETE ONCE YOU REPLACE WITH UNIVERSAL SUB-MENU
  ## FIRST: NEED TO FIGURE OUT HOW TO CORRECTLY PASS METHOD AS PARAMETER
  def no_ingredient_menu
    sub_menu_options_text
    user_input = gets.downcase.strip

    case user_input
    when "1", "search again"
      match_no_ingredient
    when "2", "main menu"
      main_menu
    when "exit"
      puts "Exiting the program. Goodbye!"
      return
    else
      puts "\nINVALID ENTRY"
      no_ingredient_menu
    end # case user_input
  end # ingredient_menu
end # class CLI
###################
## END OF CLASS  ##
###################

=end
