require 'rails_helper'

RSpec.describe 'Subscriptions request', type: :request do
  describe 'Customer subscription new' do
    it 'creates a new tea subscription and returns it' do
      tea_1 = create(:tea)
      customer_1 = create(:customer)
      data_keys = %i[id type attributes]
      attribute_keys = %i[title price status frequency customer_id tea_id tea_name]
      expect(Subscription.count).to eq(0)

      headers = { 'CONTENT_TYPE' => 'application/json' }
      params =  {
        title: 'A dance with Lady Grey',
        price: 100.00,
        frequency: 'weekly',
        tea_id: tea_1.id
      }

      post "/api/v1/customers/#{customer_1.id}/subscriptions", headers:, params: JSON.generate(params)
      subscription = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(Subscription.count).to eq(1)
      expect(subscription).to be_a(Hash)
      expect(subscription[:data].keys).to eq(data_keys)
      expect(subscription[:data][:attributes].keys).to eq(attribute_keys)
      expect(subscription[:data][:attributes][:title]).to eq(params[:title])
      expect(subscription[:data][:attributes][:price]).to eq(params[:price].to_s)
      expect(subscription[:data][:attributes][:frequency]).to eq(params[:frequency])
      expect(subscription[:data][:attributes][:tea_id]).to eq(params[:tea_id])
    end

    it 'returns an error if inputs are invalid' do
      tea_1 = create(:tea)
      customer_1 = create(:customer)

      headers = { 'CONTENT_TYPE' => 'application/json' }
      params =  {
        title: '',
        price: 100.00,
        frequency: 'weekly',
        customer_id: customer_1.id,
        tea_id: tea_1.id
      }

      post "/api/v1/customers/#{customer_1.id}/subscriptions", headers:, params: JSON.generate(params)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(error).to be_a(Hash)
      expect(error.keys).to eq([:errors])
      expect(error[:errors].keys).to eq([:title])
      expect(error[:errors][:title]).to eq(["can't be blank"])
    end
  end

  describe 'Customer subscription cancel' do
    it "cancels a customer's tea subscription" do
      tea_1 = create(:tea)
      customer_1 = create(:customer)
      subscription_1 = create(:subscription, tea_id: tea_1.id, customer_id: customer_1.id, status: 0)
      data_keys = %i[id type attributes]
      attribute_keys = %i[title price status frequency customer_id tea_id tea_name]

      expect(subscription_1[:status]).to eq('active')

      headers = { 'CONTENT_TYPE' => 'application/json' }
      params =  {
        status: 'cancelled'
      }

      patch "/api/v1/customers/#{customer_1.id}/subscriptions/#{subscription_1.id}", headers:,
                                                                                     params: JSON.generate(params)

      subscription = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(subscription).to be_a(Hash)
      expect(subscription[:data].keys).to eq(data_keys)
      expect(subscription[:data][:attributes].keys).to eq(attribute_keys)
      expect(subscription[:data][:attributes][:status]).to eq('cancelled')
    end

    it 'shows an error if the wrong information is input to cancel a subscription' do
      tea_1 = create(:tea)
      customer_1 = create(:customer)
      subscription_1 = create(:subscription, tea_id: tea_1.id, customer_id: customer_1.id, status: 0)
      expect(subscription_1[:status]).to eq('active')

      headers = { 'CONTENT_TYPE' => 'application/json' }
      params =  {
        status: 'cancelle'
      }

      patch "/api/v1/customers/#{customer_1.id}/subscriptions/#{subscription_1.id}", headers:,
                                                                                     params: JSON.generate(params)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(subscription_1[:status]).to eq('active')
      expect(response).to_not be_successful
      expect(error).to be_a(Hash)
      expect(error[:errors].first.keys).to eq(%i[status title detail])
      expect(error[:errors].first[:status]).to eq('404')
      expect(error[:errors].first[:title]).to eq('Invalid Request')
      expect(error[:errors].first[:detail]).to eq(["'cancelle' is not a valid status"])
    end
  end

  describe 'Customer subscription index' do
    it "lists all of a customer's subscriptions" do
      tea_1 = create(:tea)
      tea_2 = create(:tea)
      tea_3 = create(:tea)
      customer_1 = create(:customer)
      subscription_1 = create(:subscription, tea_id: tea_1.id, customer_id: customer_1.id, status: 0)
      subscription_2 = create(:subscription, tea_id: tea_2.id, customer_id: customer_1.id, status: 0)
      subscription_3 = create(:subscription, tea_id: tea_3.id, customer_id: customer_1.id, status: 0)

      data_keys = %i[id type attributes]
      attribute_keys = %i[title price status frequency customer_id tea_id tea_name]

      get "/api/v1/customers/#{customer_1.id}/subscriptions"

      subscriptions = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      subscriptions[:data].each do |sub|
        expect(sub.keys).to eq(data_keys)
        expect(sub[:type]).to eq('subscription')
        expect(sub[:attributes].keys).to eq(attribute_keys)
      end

      expect(subscriptions[:data].first[:attributes][:title]).to eq(subscription_1.title)
      expect(subscriptions[:data].first[:attributes][:price]).to eq(subscription_1.price.to_s)
      expect(subscriptions[:data].first[:attributes][:status]).to eq(subscription_1.status)
      expect(subscriptions[:data].first[:attributes][:frequency]).to eq(subscription_1.frequency)
      expect(subscriptions[:data].first[:attributes][:customer_id]).to eq(subscription_1.customer_id)
      expect(subscriptions[:data].first[:attributes][:tea_id]).to eq(tea_1.id)
      expect(subscriptions[:data].first[:attributes][:tea_name]).to eq(tea_1.title)
    end

    it 'returns a serialized empty array if the customer has no descriptions' do
      customer_1 = create(:customer)

      get "/api/v1/customers/#{customer_1.id}/subscriptions"

      subscriptions = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(subscriptions).to be_a(Hash)
      expect(subscriptions).to have_key(:data)
      expect(subscriptions[:data]).to be_a(Array)
      expect(subscriptions[:data].count).to eq(0)
    end

    it 'returns an error if the customer is not found' do
      customer_1 = create(:customer)

      get '/api/v1/customers/2/subscriptions'

      error = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(error).to be_a(Hash)
      expect(error[:errors].first.keys).to eq(%i[status title detail])
      expect(error[:errors].first[:status]).to eq('404')
      expect(error[:errors].first[:title]).to eq('Invalid Request')
      expect(error[:errors].first[:detail]).to eq(["Couldn't find Customer with 'id'=2"])
    end
  end
end
