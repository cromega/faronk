Rails.application.routes.draw do
  post "/", to: "slack#handle", as: "slack"
end
