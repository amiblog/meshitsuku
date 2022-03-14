class Recipe < ApplicationRecord
  has_one_attached :recipe_image

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :customer

  validates :title, presence: true
  validates :body, presence: true

  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

end
