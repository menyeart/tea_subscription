class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea

  validates :title, :price, :status, :frequency, presence: true
  validates :title, uniqueness: true

  enum status: { active: 0, cancelled: 1 }
  enum frequency: { weekly: 0, monthly: 1 }
end
