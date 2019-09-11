require 'rails_helper'

describe SubscriptionUrlResolver do
  let!(:user) { create(:user) }
  let(:url_helpers) { Rails.application.routes.url_helpers }
  let(:request) { instance_double('request', query_string: 'param1=1') }
  let(:subscription_path) { ->(subscription) { "#{URI(url_helpers.subscription_path(subscription)).to_s}?#{request.query_string}" } }

  describe '#call' do
    subject { SubscriptionUrlResolver.call(user, request) }

    context 'when user has a current (active or paused) subscription' do
      before { create(:subscription, :not_active, user: user) }

      context 'and when the subscription is active' do
        let!(:active_subscription) { create(:subscription, :active, user: user) }

        it { is_expected.to eq subscription_path[active_subscription] }
      end

      context 'and when the subscription is paused' do
        let!(:paused_subscription) { create(:subscription, :paused, user: user) }

        it { is_expected.to eq subscription_path[paused_subscription] }
      end
    end

    context 'when user has no subscriptions' do
      it { is_expected.to eq url_helpers.root_path }
    end
  end
end
