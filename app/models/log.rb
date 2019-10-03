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
        dictionary: "simple",
        tsvector_column: "message_search_tsv",
      },
    }



end
