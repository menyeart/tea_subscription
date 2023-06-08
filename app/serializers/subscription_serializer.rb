class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :title, :price, :status, :frequency, :customer_id, :tea_id

  attributes :tea_name do |object|
    object.tea[:title]
  end
end