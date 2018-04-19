[x] Provide a CLI
    ## The app has a CLI that runs upon execution. It provides the user with options for viewing a list of items and for seeing more info on the item.

[x] CLI must provide access to data from a web page.
    ## The app retrieves data from cultbeauty.co.uk's sales page and subsequent data pages.

[x] The data provided must go at least one level deep, generally by showing the user a list of available data and then being able to drill
    down into a specific item.
    ## The data goes at least one level deep, allowing the user not only to find and list out items, but also to select an item for more details

[x] The CLI application can not be a Music CLI application as that is too similiar to the other OO Ruby final project. Also please refrain
    from using Kickstarter as that was used for the scraping 'code along'. Look at the example domains below for inspiration.
    ## The CLI applications is neither a Music CLI application, nor Kickstarter. A tech coach approved the idea before I started working on it.

[x] Use good OO design patterns. You should be creating a collection of objects - not hashes.
    ## The app does not use hashes. It creates objects and populates the attributes with ingredients, description, directions, etc.
    ## When the cli calls on the appropriate functions to list the items, it references class objects, not hashes.
