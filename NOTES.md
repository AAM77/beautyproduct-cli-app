PLANNING:

How I want the CLI to work:

## Hello and Welcome
## Please select an option from the menu:

## 1. Search by Product Name
## 2. Search by Ingredient (products that have it)
## 3. Search by Ingredient (products that do not have it)

## If choose 1:
###=> Please enter the product name

## If choose 2 or 3:
###=> Please enter the ingredient name

######## If choose 2:
#########=> These are the products WITH this ingredient:
            (List Ingredients)

            ## Please enter the name of the ingredient you are interested in to see more details:

######## If choose 3:
#########=> These are the products WITHOUT this ingredient:
            (List Ingredients)

            ## Please enter the name of the ingredient you are interested in:


ARCHITECTURE:

Need the following classes:

1. FindMyProduct::CLI
2. FindMyProduct::Product
3. FindMyProduct::Ingredient

## MEH ##
4. FindMyProduct::Price
5. FindMyProduct::Details
