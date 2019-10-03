class CreateLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :logs do |t|
      t.string :user
      t.string :channel
      t.text :message
      t.datetime :sent_at

      t.timestamps
    end
  end
end
