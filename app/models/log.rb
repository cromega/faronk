class Log < ApplicationRecord
  validates_presence_of :user
  validates_presence_of :channel
  validates_presence_of :message
  validates_presence_of :sent_at
end
