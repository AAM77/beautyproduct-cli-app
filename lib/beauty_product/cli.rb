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
   #puts "5. Search by Ingredient (products that DO NOT have it)"
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
      product_menu
      #return_to_main_menu? ## delete if product_menu works
    when "4"
      match_yes_ingredient
      ingredient_menu
      #return_to_main_menu? ## delete if ingredient_menu works
    when "exit"
      puts "Exiting program. Goodbye!"
      return
    else
      puts "INVALID ENTRY!"
      main_menu
    end # case user_input
  end # main_menu

  def list_products
    product_names = BeautyProduct::Product.all.collect { |product| [product.name, product.brand] } ## might need to remove array and product.brand
    puts "#{product_names.size} found"
    puts "The following items are on sale:"
    product_names.sort.each.with_index(1) { |product, index| puts "#{index}. #{product[0]}" }
  end # list_products

  def list_ingredients
    ingredient_names = BeautyProduct::Ingredient.all.collect { |ingredient| ingredient.name }.uniq
    puts "#{ingredient_names.size}"
    puts "The following ingredients are found in the on sale items:"
    ingredient_names.sort.each.with_index(1) { |ingredient, index| puts "#{index}. #{ingredient}" }
  end # list_ingredients

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
      product.ingredients_string.nil? ? (puts "No Ingredients listed for this product.") : (puts "Ingredients include: #{product.ingredients_string}")

    elsif product.nil? || product.empty?
      puts "PRODUCT NOT FOUND"
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

    elsif ingredients.nil? || ingredients.empty?
      puts "INGREDIENT NOT FOUND"
    end # if user_input in products
  end # match_yes_ingredient



  def product_menu
    puts "\nSearch for a different product? (yes/no)"
    run_same_method_again?
  end # product_menu

  def ingredient_menu
    puts "\nSearch using another ingredient? (yes/no)"
    run_same_method_again?
  end # product_menu
  ## Might Need to Delete

  def run_same_method_again?
    puts "\nType 'yes', 'no', or 'exit'"
    user_input = gets.downcase.strip

    case user_input
    when "y", "yes"
      self.send(__method__)
    when "n", "no"
      return_to_main_menu?
    when "exit"
      return
    else
      "Invalid entry."
      run_same_method_again?
      ##return_to_main_menu? ## delete if this works
    end # case user_input
  end # return_to_main_menu?

  def return_to_main_menu?
    puts "\nReturn to the Main Menu? (yes/no)"
    puts "Typing 'n', 'no', or 'exit' will quit the program."
    user_input = gets.downcase.strip

    case user_input
    when "y", "yes"
      main_menu
    when "n", "no", "exit"
      return
    else
      "Invalid entry."
      return_to_main_menu?
    end # case user_input
  end # return_to_main_menu?

=begin


  def run_method_again
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
      send(__method__)
      ##return_to_main_menu? ## delete if this works
    end # case user_input
  end # return_to_main_menu?


=end

end # class CLI
