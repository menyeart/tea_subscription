class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :title, :price, :status, :frequency, :customer_id, :tea_id

  attributes :tea do |object|
    object.title
  end
end