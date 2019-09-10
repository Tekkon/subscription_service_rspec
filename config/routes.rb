Rails.application.routes.draw do
  root 'welcome#index'

  get 'subscription' => 'subscriptions#index'
  get 'subscription/:id' => 'subscriptions#show'
end
