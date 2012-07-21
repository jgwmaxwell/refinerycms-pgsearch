namespace :refinery do
    namespace :search do

        task :rebuild => :environment do
            # Get searchable models from hash keys.
            Refinery::Search.searchable_models.keys.each do |model|
                # Delete the old search documents
                PgSearch::Document.delete_all(:searchable_type => model.to_s)
                # Add some new ones!
                model.constantize.find_each{|record| record.update_pg_search_document }
            end
        end

    end
end
