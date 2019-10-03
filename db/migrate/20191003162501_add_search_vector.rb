class AddSearchColumns < ActiveRecord::Migration[6.0]
  def up
    add_column :logs, :message_search_tsv, :tsvector
    add_index :logs, :message_search_tsv, using: "gin"

    execute <<-SQL
      CREATE TRIGGER messagetsvupdate BEFORE INSERT OR UPDATE
      ON logs FOR EACH ROW EXECUTE PROCEDURE
      tsvector_update_trigger(
        message_search_tsv, 'pg_catalog.simple', message
      );
    SQL

    now = Time.current.to_s(:db)
    update("UPDATE logs SET updated_at = '#{now}'")
  end

  def down
    execute <<-SQL
      DROP TRIGGER messagetsvupdate
      ON logs
    SQL

    remove_column :message_search_tsv
    remove_index :message_search_tsv
  end
end
