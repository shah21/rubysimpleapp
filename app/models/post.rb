class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: {minimum: 3,maximum: 30}
  validates :details, presence: true, length: {minimum: 3,maximum: 100}
  validates :final_date, presence: :true

  has_many :comments, dependent: :destroy
  
end
