This was a fun project to play with thor when it was fairly new.  The idea is to
build CLIs  from recipes.  The concept is we have a wok and we want to cook
from a recipe.  The result can be executed directly, or it can execute in dry mode
to print the process taken by the recipe.


Example Usage:
```
 #> ./bin/wok list
 --------------------------------------------------
 Recipes
 --------------------------------------------------
 recipe1.rb
 recipe2.rb
 --------------------------------------------------
 Ingredients
 --------------------------------------------------
 ingredient1.rb

 #> ./bin/wok -h
Commands:
  wok <command> help                    # Print help for a particular command
  wok help [COMMAND]                    # Describe available commands or one specific command
  wok ingredient <path/name> <options>  # Run ingredient commands
  wok list [partial name]               # Find a recipe or ingredient by a name
  wok recipe <path/name> <options>      # Run recipe commands

 #> ./bin/wok help recipe
Commands:
  wok recipe cleanup <recipe_path> [options]       # Execute the cleanup stage for thise recipe
  wok recipe cook <recipe_path> [options]          # Execute the cook stage for thise recipe
  wok recipe explain [file]                        # recipe show options
  wok recipe help [COMMAND]                        # Describe subcommands or one specific subcommand
  wok recipe list [partial file name]              # Lists avaialable recipes
  wok recipe requirements <recipe_path> [options]  # Execute the requirements stage for thise recipe
  wok recipe taste <recipe_path> [options]         # Execute the taste stage for thise recipe

 #> ./bin/wok help ingredient
Commands:
  wok ingredient cleanup <ingredient_path> [options]       # Execute the cleanup stage for thise ingredient
  wok ingredient cook <ingredient_path> [options]          # Execute the cook stage for thise ingredient
  wok ingredient explain [file]                            # ingredient show options
  wok ingredient help [COMMAND]                            # Describe subcommands or one specific subcommand
  wok ingredient list [partial file name]                  # Lists avaialable ingredients
  wok ingredient requirements <ingredient_path> [options]  # Execute the requirements stage for thise ingredient
  wok ingredient taste <ingredient_path> [options]         # Execute the taste stage for thise ingredient
```

**Example Recipe:**
```ruby
add_spices do
  opt :dry_run, 'Don''t actually do anything, just print steps', :short => '-d'
  opt :log_dir, 'Output logs to this directory', :short => '-l', :type => :string
  opt :interactive, 'Run in interactive mode', :short => '-a'
end

requirements do
  echo 'hello'
end

cook do
  add_ingredient 'ingredient1', iface: 'eth0'
  add_recipe 'recipe2', iface: 'eth0'
end

cleanup do
  clean_ingredient 'ingredient1'
  clean_recipe 'recipe2'
end
```

**Example Ingredient:**
```ruby
add_spices do
  opt :dry_run, 'Don''t actually do anything, just print steps', :short => '-d'
end

requirements do
end

cook do
  add_ingredient 'ingredient2', :iface => 'my iface'
end

cleanup do
  clean_ingredient 'ingredient2'
end
```




The main components are recipes, ingredients, spices, and commands.

**Recipes:**

  Recipes are the main things we are trying to execute.  Recipes have the following

  features:

    1. A recipe is made up of three blocks:
       requirements: Check if the requirements are met for the recipe.
                     This section should also do any setup needed.
       cook:         This section is the actual code that defines the recipe
       cleanup:      Things we need to do after we are done to cleanup the mess
    2. A recipe can add/clean other recipes
    3. A recipe can add/clean ingredients
    4. A recipe can have "spices".
    5. A recipe can run in "taste" mode, that should just print out the steps of the
      recipe.

**Ingredients:**
  Ingredients are shareable between recipes.  The difference between an ingredient
  and a recipe is that ingredients can only add other ingredients.  Ingredients
  are wrappers to small but significant pieces of logic that is shareable among
  recipes.  A good example of an ingredient is a wrapper of a linux command.  Maybe
  something that would start a server and stop a server on clean up.  This allows
  us to just add an ingredient without having to think of how it works between recipes.

  features:

    1. An ingredient is made up of three blocks:
        requirements: Check if the requirements are met for the recipe.
                      This section should also do any setup needed.
        cook:         This section is the actual code that defines the recipe
        cleanup:      Things we need to do after we are done to cleanup the mess
    2. A ingredient can add/clean other ingredients
    3. A recipe can have "spices".
    4. A ingredient can run in "taste" mode, that should just print out the steps of the
          ingredient.

**Spices:**

  Spices are ways to configure what arguments can be passed to a recipe or an
  ingredient.  These get passed directly to Trollop to be parsed and passed to
  their ingredient or recipes.  Checkout the Trollop gem for more information.

**Commands:**
  In order to provide dry mode, we need to override any commands we need to execute
  and have it execute only when we are not in dry mode.





