class BeautyProduct::CLI

  #############################################################
  ## INITIALIZES THE SCRAPER AND DISPLAYS A WELCOME MESSAGE" ##
  #############################################################
  def call
    puts "One moment, please."
    puts "This should take less than a minute..."

    BeautyProduct::Product.all.clear
    BeautyProduct::Ingredient.all.clear

    BeautyProduct::Scraper.new

    puts "\n#####################################################"
    puts "##    WELCOME TO THE BEAUTY PRODUCT SEARCH CLI:    ##"
    puts "#####################################################"
    main_menu
  end # call

  ###############################
  ## OPTIONS FOR THE MAIN MENU ##
  ###############################
  def main_menu_options
    puts "\nPlease select an option from the menu (Type 1 to 5):"

    puts "1. List Products"
    puts "2. List Ingredients"
    puts "3. Search Product by Name"
    puts "4. Search by Ingredient (products that have it)"
    puts "5. Search by Ingredient (products that DO NOT have it)"
  end # menu_options

  #############################
  ## DISPLAYS THE MAIN MENU ##
  ############################
  def main_menu
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
      exit
    else
      puts "\nINVALID ENTRY!"
      puts "Type 1, 2, 3, 4, or 5 and press the 'Enter'/'Return' key."
      main_menu
    end # case user_input
  end # main_menu

  #######################################################
  ##   Provides a list of products on the sales page   ##
  #######################################################
  def list_products
    products = BeautyProduct::Product.all.sort_by{ |product| product.name }
    @current_method = :list_products
    display_search_results(products)
    display_sub_menu
  end # list_products

  #######################################################################
  ## Provides a list of ingredients present in the products being sold ##
  #######################################################################
  def list_ingredients
    ingredient_names = BeautyProduct::Ingredient.all.collect { |ingredient| ingredient.name }.uniq
    puts "\n#{ingredient_names.size} ingredients found"
    puts "The following ingredients are found in the on sale items:"
    ingredient_names.sort.each.with_index(1) { |ingredient, index| puts "#{index}. #{ingredient}" }
  end # list_ingredients

  ##################################################################
  ## Searches for products with the specified keyword in its name ##
  ##################################################################
  def match_product
    puts "Enter the name of the product you wish to look for (partial or exact match):"
    user_input = gets.downcase.strip

    products = BeautyProduct::Product.all.select { |element| element.name.downcase.include?(user_input) }
    puts "\nSearching for products with '#{user_input}' in their name..."

    @current_method = :match_product
    display_search_results(products)
    display_sub_menu
  end # match_product

  #######################################################
  ##  Searches for products WITH specified ingredient  ##
  #######################################################
  def match_yes_ingredient
    puts "Enter ingredient name for a list of products that contain it:"
    user_input = gets.downcase.strip

    products = BeautyProduct::Product.all.select { |element| element.ingredients_string.downcase.include?(user_input) if element.ingredients_string }
    puts "\nSearching for products WITH '#{user_input}' in their ingredients list..."

    @current_method = :match_yes_ingredient
    display_search_results(products)
    display_sub_menu
  end # match_yes_ingredient

  ########################################################
  ## Searches for products WITHOUT specified ingredient ##
  ########################################################
  def match_no_ingredient
    puts "Enter ingredient name for a list of products:"
    user_input = gets.downcase.strip

    products = BeautyProduct::Product.all.select { |element| !element.ingredients_string.downcase.include?(user_input) if element.ingredients_string }
    puts "\nSearching for products WITHOUT '#{user_input}' in their ingredients list..."

    @current_method = :match_no_ingredient
    display_search_results(products)
    display_sub_menu
  end # match_yes_ingredient

  #######################################################
  ##            Displays the Search Results            ##
  #######################################################
  def display_search_results(products)
    if products.nil? || products.empty?
      puts "\nSORRY. Your search returned 0 results."
    elsif !products.nil?
      puts "\n==================================="
      puts "= #{products.size} Products Found ="
      puts "==================================="
      products.each.with_index(1) do |product, index|
        puts "\n#{index}. #{product.name} - (BRAND: #{product.brand}) - $#{product.sale_price}"
      end # do |product|
      full_product_info(products)
    end # if user_input in products
  end # display_search_results()

  ########################################################
  ##          Displays the Product's Full Info          ##
  ########################################################
  def full_product_info(products)
    user_selection = nil

    until (!user_selection.nil? && 1 <= user_selection && user_selection <= products.size)
      puts "\nEnter a valid item number from the list see more information (1 - #{products.size}):"
      user_selection = gets.downcase.strip.to_i
    end # until

    product_index = (user_selection - 1)
    product = products[product_index]

    puts "\nPRODUCT NAME:     #{product.name}"
    puts "PRODUCT BRAND:    #{product.brand}"
    puts "SALE PRICE:       $#{product.sale_price}"

    puts "\nDESCRIPTION:"
    puts "#{product.description}"

    puts "\nHOW TO USE:"
    puts "#{product.directions}"

    puts "\nINGREDIENTS INCLUDE:"
    product.ingredients_string.nil? ? (puts "No Ingredients listed for this product.") : (puts "#{product.ingredients_string}")
  end # print_product_info

  #######################################################
  ##                OPTIONS for SUB-MENU               ##
  #######################################################
  def sub_menu_options_text
    puts "\nWhat else would you like to do?"
    puts "1. Search again"
    puts "2. Go to the Main Menu"
    puts "Type 1, 2, or 'exit'"
  end # sub_menu_options_text

  #######################################################
  ##                DISPLAYS a SUB-MENU                ##
  #######################################################
  def display_sub_menu
    sub_menu_options_text
    user_input = gets.downcase.strip

    case user_input
    when "1"
      send(@current_method)
    when "2"
      main_menu
    when 'exit'
      puts "Exiting program. Goodbye!"
      exit
    else
      puts "\nINVALID ENTRY"
      display_sub_menu
    end # case user_input
  end # display_sub_menu
end # class CLI
###################
## END OF CLASS  ##
###################
