class Log < ApplicationRecord
  include PgSearch::Model

  validates_presence_of :user
  validates_presence_of :channel
  validates_presence_of :message
  validates_presence_of :sent_at

  pg_search_scope :search_by_message,
    against: :message,
    using: {
      tsearch: {
        prefix: true,
        any_word: true,
        tsvector_column: "message_search_tsv",
      },
    }

  scope :by_timestamp, -> { order(sent_at: :asc) }

  after_save :update_search_index

  private

  def update_search_index
    query = ActiveRecord::Base.sanitize_sql([
      "UPDATE logs SET message_search_tsv = to_tsvector('simple', ?) WHERE id = ?", message, id])
    ActiveRecord::Base.connection.execute(query)
  end
end
