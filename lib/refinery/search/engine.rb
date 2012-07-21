module Refinery
    module Search
        class Engine < Rails::Engine
            include Refinery::Engine

            initializer "register refinery_search plugin" do
                Refinery::Plugin.register do |plugin|
                    plugin.name = 'refinery_search'
                    plugin.version = 2.0
                    plugin.hide_from_menu = true
                end
            end

            config.to_prepare do
                ::Refinery::Search.searchable_models ||= {"Refinery::Page" => [:title, :all_parts]}
            end

            config.after_initialize do
                require 'pg_search'

                PgSearch.multisearch_options = {
                    using: {
                        tsearch: {
                            prefix: true,
                            dictionary: "english",
                            tsvector_column: 'tsv'
                        }
                    },
                    ignoring: :accents
                }

                ::Refinery::Search.searchable_models.each do |model, fields|
                    model.constantize.module_eval do
                        include PgSearch
                        multisearchable :against => fields
                        if fields.include?(:all_parts)
                            def all_parts
                                @all_parts ||= parts.pluck(:body).join(' ')
                            end
                        end
                    end
                end
            end

        end
    end
end
