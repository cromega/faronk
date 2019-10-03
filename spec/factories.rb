FactoryBot.define do
  factory :log do
    user { "user" }
    channel { "channel" }
    message { "message" }
    sent_at { DateTime.now }
  end
end