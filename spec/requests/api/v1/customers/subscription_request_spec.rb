require 'rails_helper'

RSpec.describe 'Subscriptions request', type: :request do
  describe 'Customer subscription new' do
    it 'creates a new tea subscription and returns it' do
      tea_1 = create(:tea)
      customer_1 = create(:customer)
      data_keys = [:id, :type, :attributes]
      attribute_keys = [:title, :price, :status, :frequency, :customer_id, :tea_id, :tea]
      expect(Subscription.count).to eq(0)

      headers = { 'CONTENT_TYPE' => 'application/json' }
      params =  {
        title: "A dance with Lady Grey",
        price: 100.00,
        frequency: "weekly",
        customer_id: customer_1.id,
        tea_id: tea_1.id
      }

      post "/api/v1/customers/#{customer_1.id}/subscriptions", headers: headers, params: JSON.generate(params)
      subscription = JSON.parse(response.body, symbolize_names: true)
    
      expect(response).to be_successful
      expect(Subscription.count).to eq(1)
      expect(subscription).to be_a(Hash)
      expect(subscription[:data].keys).to eq(data_keys)
      expect(subscription[:data][:attributes].keys).to eq(attribute_keys)
      expect(subscription[:data][:attributes][:title]).to eq(params[:title])
      expect(subscription[:data][:attributes][:price]).to eq(params[:price].to_s)
      expect(subscription[:data][:attributes][:frequency]).to eq(params[:frequency])
      expect(subscription[:data][:attributes][:customer_id]).to eq(params[:customer_id])
      expect(subscription[:data][:attributes][:tea_id]).to eq(params[:tea_id])
    end

    it 'returns an error if inputs are invalid' do
      tea_1 = create(:tea)
      customer_1 = create(:customer)

      headers = { 'CONTENT_TYPE' => 'application/json' }
      params =  {
        title: "",
        price: 100.00,
        frequency: "weekly",
        customer_id: customer_1.id,
        tea_id: tea_1.id
      }

      post "/api/v1/customers/#{customer_1.id}/subscriptions", headers: headers, params: JSON.generate(params)

      error = JSON.parse(response.body, symbolize_names: true)
    
      expect(response).to_not be_successful
      expect(error).to be_a(Hash)
      expect(error.keys).to eq([:errors])
      expect(error[:errors].keys).to eq([:title])
      expect(error[:errors][:title]).to eq(["can't be blank"])
    end
  end

  describe "Customer subscription cancel" do
    it "cancels a customer's tea subscription" do
      tea_1 = create(:tea)
      customer_1 = create(:customer)
      subscription_1 = create(:subscription, tea_id: tea_1.id, customer_id: customer_1.id, status: 0)
      data_keys = [:id, :type, :attributes]
      attribute_keys = [:title, :price, :status, :frequency, :customer_id, :tea_id, :tea]

      expect(subscription_1[:status]).to eq("active")

      headers = { 'CONTENT_TYPE' => 'application/json' }
      params =  {
        status: "cancelled"
                }

      patch "/api/v1/customers/#{customer_1.id}/subscriptions/#{subscription_1.id}", headers: headers, params: JSON.generate(params)

      subscription = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(subscription).to be_a(Hash)
      expect(subscription[:data].keys).to eq(data_keys)
      expect(subscription[:data][:attributes].keys).to eq(attribute_keys)
      expect(subscription[:data][:attributes][:status]).to eq("cancelled")
    end

    it "shows an error if the wrong information is input to cancel a subscription" do
      tea_1 = create(:tea)
      customer_1 = create(:customer)
      subscription_1 = create(:subscription, tea_id: tea_1.id, customer_id: customer_1.id, status: 0)
      expect(subscription_1[:status]).to eq("active")

      headers = { 'CONTENT_TYPE' => 'application/json' }
      params =  {
        status: "cancelle"
                }

      patch "/api/v1/customers/#{customer_1.id}/subscriptions/#{subscription_1.id}", headers: headers, params: JSON.generate(params)

      error = JSON.parse(response.body, symbolize_names: true)
   
      expect(response).to_not be_successful
      expect(subscription_1[:status]).to eq("active")
      expect(response).to_not be_successful
      expect(error).to be_a(Hash)
      expect(error[:errors].first.keys).to eq([:status, :title, :detail])
      expect(error[:errors].first[:status]).to eq("404")
      expect(error[:errors].first[:title]).to eq("Invalid Request")
      expect(error[:errors].first[:detail]).to eq(["'cancelle' is not a valid status"])
    end
  end
end