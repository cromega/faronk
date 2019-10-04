Rails.application.routes.draw do
  post "/slack", to: "slack#handle", as: "slack"
end
