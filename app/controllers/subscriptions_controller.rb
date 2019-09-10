class SubscriptionsController < ApplicationController
  def index
    redirect_to SubscriptionUrlResolver.call(user, request)
  end
end
