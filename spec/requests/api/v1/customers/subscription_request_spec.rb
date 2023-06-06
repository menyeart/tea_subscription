require 'rails_helper'

RSpec.describe 'Subscriptions request', type: :request do
  describe 'Customer subscription new' do
    it 'creates a new tea subscription and returns it' do
      tea_1 = create(:tea)
      customer_1 = create(:customer)

      headers = { 'CONTENT_TYPE' => 'application/json' }
      params =  {
        title: "A dance with Lady Grey",
        price: 100.00,
        frequency: "Weekly",
        customer_id: customer_1.id,
        tea_id: tea_1.id
      }

      post "/api/v1/customers/#{customer_1.id}/subscriptions", headers: headers, params: JSON.generate(params)
      deeds = JSON.parse(response.body, symbolize_names: true)
      binding.pry
      expect(response).to be_successful
      expect(deeds).to be_a(Hash)
      expect(deeds[:data]).to be_a(Array)
      expect(deeds[:data].count).to eq(2)
    end
  end
end