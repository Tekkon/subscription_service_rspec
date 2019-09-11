Rails.application.routes.draw do
  root 'welcome#index'

  get 'subscriptions' => 'subscriptions#index'
  get 'subscriptions/:id' => 'subscriptions#show'
end
