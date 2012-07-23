# Search plugin for [RefineryCMS](http://www.refinerycms.com)
[Github](http://github.com/resolve/refinerycms)

## Shape the future of this Gem
Please fill in this [questionnaire](https://docs.google.com/spreadsheet/viewform?formkey=dGEtODg5d0pVeG9reEVfdTEyc0MtNWc6MQ) to help me shape the future development of the gem. It's also a chance to request features, too!

By: [JGW Maxwell](http://jgwmaxwell.com)

Powered by: [pg_search](http://github.com/Casecommons/pg_search). **This only works on PostgreSQL databases, ideally 9.0+.**

I will be stabilising support for 8.x soon, but as long as you can install extensions you'll be good to go. Any of the new [Heroku Postgres](http://postgres.heroku.com) plans, even the Dev one, will suit.

## Installation

Simply use this by adding the following to your `Gemfile`:

```ruby
gem 'refinerycms-pgsearch'
# or for the latest and greatest
gem 'refinerycms-pgsearch', github: 'jgwmaxwell/refinerycms-pgsearch'
```
Then run `bundle install`, and `rails g refinery:search` to generate the migrations. Finally, run `rake db:migrate` and `rake db:seed` to finish setting up.

## Check The Initializer

The default installation will search in Pages. If you wish to find results in other plugins you have created or installed, you can specify these in `config/initializers/refinery/search.rb` like so:

```ruby
Refinery::Search.configure do |config|
    config.searchable_models = {
        "Refinery::Page" => [:title, :all_parts],
        "Refinery::Blog::Post" => [:title, :body]
    }
end
```
This will index Pages and Blog Posts for you. The format is: `"STRING_OF_MODEL_CLASS" => [:array, :of, :attribute, :symbols]`. You might notice that Pages are indexing `:all_parts` - this is a convenience to get the content out of multiple page parts that will be defined if you use it.

## To use your own Models

Simple pass another line into the hash in the initializer, such as:

```ruby
"Employee" => [:name, :bio]
```
You can use any public method, as well. So if you have `:first_name` and `:last_name` but a method like `name` to join them, it can be indexed.

## Existing Data and Rebuilding

If at any point you need to rebuild your search index, run `rake refinery:search:rebuild` to update all your search records!

## Searching and Viewing

A sample search form can be found in [views/refinery/shared/_search.html.erb](http://github.com/jgwmaxwell/refinerycms-pgsearch/blob/master/app/views/refinery/shared/_search.html.erb).
You can either use this partial directly, or copy the appropriate parts.

If you wish to override the url used in the search results just add a `url` method to your model and the result of this method will be used instead.

## Migrating from refinerycms-search

You'll need to run the generator, migrate the database, update the new initializer and remove the old code from `application.rb`. Then remove the `acts_as_indexed` statements from your models but otherwise it should be good to go. Let me know if you need help.