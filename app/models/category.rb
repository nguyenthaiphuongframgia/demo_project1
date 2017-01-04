class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :name, presence: true, length: {maximum: Settings.maximum.name}
  
  scope :by_category, ->category_id do
    where category_id: category_id if category_id.present?
  end
  
  def is_leaf?
    self.rgt == self.lft + 1
  end
end
