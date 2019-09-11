class SubscriptionUrlResolver
  attr_reader :user, :request

  def initialize(user, request)
    @user = user
    @request = request
  end

  def self.call(user, request)
    new(user, request).call
  end

  def call
    current_subscription = user.subscriptions.active.first || user.subscriptions.paused.first

    if current_subscription
      subscriptions_path(current_subscription)
    else
      root_path
    end
  end

  private

  def subscriptions_path(subscription)
    URI(url_helpers.subscriptions_path(subscription)).tap do |uri|
      uri.query = request.query_string.presence
    end.to_s
  end

  def root_path
    url_helpers.root_path
  end

  def url_helpers
    Rails.application.routes.url_helpers
  end
end
