class Tea < ApplicationRecord
  has_many :subscriptions
  has_many :customers, through: :subscriptions

  validates :title, :description, :brew_time, :temp, presence: true
  validates :title, uniqueness: true
end
