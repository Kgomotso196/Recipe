class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy

  validates :name, :measurement_unit, :quantity, :price, presence: true
  validates :name, uniqueness: true
  validates :quantity, :price, numericality: {only_integer: true, greater_than_or_equal_to: 1}
end
