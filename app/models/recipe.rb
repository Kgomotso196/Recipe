class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy

  validates :name, presence: true
  validates :cooking_time, numericality: { greater_than: 0 }
  validates :preparation_time, numericality: { greater_than: 0 }
  validates :user_id, presence: true

  scope :public_recipes, -> { where(public: true).order(created_at: :desc) }

  def toggle_public
    update(public: !public)
  end

  def add_to_shopping_list
    update(add_to_shopping_list: !add_to_shopping_list)
  end
end
