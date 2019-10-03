class AddSearchVector < ActiveRecord::Migration[6.0]
  def up
    add_column :logs, :message_search_tsv, :tsvector
    add_index :logs, :message_search_tsv, using: "gin"

    Log.find_each { |log| log.touch }
  end

  def down
    remove_column :logs, :message_search_tsv
    remove_index :logs, :message_search_tsv
  end
end
