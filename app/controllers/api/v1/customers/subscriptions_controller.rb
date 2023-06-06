class Api::V1::Customers::SubscriptionsController < ApplicationController
  def create
    subscription = Subscription.new(subscription_params)
    if subscription.save
      render json: SubscriptionSerializer.new(subscription), status: :created
    else
      
    end
    end

  
  end

private

def subscription_params
  params.permit(:title, :price, :status, :frequency, :customer_id, :tea_id)
end

end