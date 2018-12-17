class Micropost < ApplicationRecord
  belongs_to :user
  
  validates :content, presence:true, length: {maximum:255 }
  
  has_many :likes, dependent: :destroy
  has_many :user_favorited_bys, through: :likes, source: :user
end
