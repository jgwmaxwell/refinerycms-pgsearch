class CreatePgSearchTable < ActiveRecord::Migration
  def self.up
    say_with_time("Creating table for pg_search multisearch") do
      create_table :pg_search_documents do |t|
        t.text :content
        t.belongs_to :searchable, :polymorphic => true
        t.timestamps
      end
      execute "CREATE EXTENSION IF NOT EXISTS unaccent;"
      execute "ALTER TABLE pg_search_documents ADD COLUMN tsv tsvector;"
      execute "CREATE INDEX index_pg_search_documents_tsv ON pg_search_documents USING gin(tsv);"
      execute "CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE ON pg_search_documents FOR EACH ROW EXECUTE PROCEDURE tsvector_update_trigger(tsv, 'pg_catalog.english', content)"
    end
  end

  def self.down
    say_with_time("Dropping table for pg_search multisearch") do
      drop_table :pg_search_documents
    end
  end
end