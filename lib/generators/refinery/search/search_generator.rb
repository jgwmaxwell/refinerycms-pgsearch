require 'rails/generators'
require 'rails/generators/migration'

module Refinery
  class SearchGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    desc "Creates the installation files for RefineryCMS Search"
    
    source_root File.expand_path("../templates", __FILE__)

    def self.next_migration_number(dirname)
        if ActiveRecord::Base.timestamped_migrations
          Time.new.utc.strftime("%Y%m%d%H%M%S")
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
    end

    def create_migration_file
      migration_template '01_create_search_page.rb', 'db/migrate/create_search_page.rb'
      sleep 1
    end

    def pg_search_migration
      migration_template '02_create_pg_search_table.rb', 'db/migrate/create_pg_search_table.rb'
    end

    def copy_initializer
        copy_file "03_initializer.rb", "config/initializers/refinery/search.rb"
    end

    def append_load_seed_data
      create_file 'db/seeds.rb' unless File.exists?(File.join(destination_root, 'db', 'seeds.rb'))
      append_file 'db/seeds.rb', :verbose => true do
        <<-EOH

# Added by Refinery CMS Search engine
Refinery::Search::Engine.load_seed
        EOH
      end
    end

  end
end
