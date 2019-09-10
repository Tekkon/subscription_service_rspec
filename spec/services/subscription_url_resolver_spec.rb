require_relative '../rails_helper'

describe SubscriptionUrlResolver do
  let!(:user) { create(:user) }
  let(:url_helpers) { Rails.application.routes.url_helpers }
  let(:request) { instance_double('request', query_string: 'param1=1') }
  let(:subscription_path) { ->(subscription) { "#{URI(url_helpers.subscription_path(subscription)).to_s}?#{request.query_string}" } }

  describe '#call' do
    context 'a subscription exists' do
      before do
        create(:subscription, :not_active, user: user)
      end

      context 'an active subscription exists' do
        let!(:active_subscription) { create(:subscription, :active, user: user) }

        it 'returns an active subscription url' do
          expect(SubscriptionUrlResolver.call(user, request)).to eq subscription_path[active_subscription]
        end
      end

      context 'an active subscription does not exists' do
        let!(:paused_subscription) { create(:subscription, :paused, user: user) }

        it 'returns a paused subscription url' do
          expect(SubscriptionUrlResolver.call(user, request)).to eq subscription_path[paused_subscription]
        end
      end
    end

    context 'there are no subscriptions' do
      it 'returns the root path' do
        expect(SubscriptionUrlResolver.call(user, request)).to eq url_helpers.root_path
      end
    end
  end
end
