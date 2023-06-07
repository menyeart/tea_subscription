class Api::V1::Customers::SubscriptionsController < ApplicationController

  def create
    subscription = Subscription.new(subscription_params)
    if subscription.save
      render json: SubscriptionSerializer.new(subscription), status: :created
    else
      render json: ErrorSerializer.new(subscription.errors), status: :bad_request
    end
  end

  def update
    subscription = Subscription.find(params[:id])
    if subscription.update(subscription_params)
      render json: SubscriptionSerializer.new(subscription), status: :accepted
    else
      render json: ErrorSerializer.new(subscription.errors), status: :bad_request
    end
  end

private

def subscription_params
  params.permit(:title, :price, :status, :frequency, :customer_id, :tea_id)
end

end