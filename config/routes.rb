Rails.application.routes.draw do
  root to: "home#index"
  post "/slack", to: "slack#handle"
end
