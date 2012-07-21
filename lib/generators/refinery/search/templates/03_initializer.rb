Refinery::Search.configure do |config|
    config.searchable_models = {
        # Add a Hash of "ModelName" => [:searchable, :field, :names, :as, :keys]
        
        # Below are common Refinery models that you might want indexed.
        # Uncomment any that you wish to use, and then run:
        #       rake refinery:search:rebuild
        # To rebuild the search index.

        # Refinery::Page
        # We defined a special method called #all_parts to allow
        # all of the content in the different Page Parts to be indexed
        # simply under the parent page.
        
        "Refinery::Page" => [:title, :all_parts],

        # Refinery::Blog::Post and Refinery::News::Item
        # These are simple, only indexing fields on the model.

        # "Refinery::Blog::Post" => [:title, :body],
        # "Refinery::News::Item" => [:title, :body]
    }
end