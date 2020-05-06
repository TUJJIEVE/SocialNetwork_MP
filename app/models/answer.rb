class Answer < ApplicationRecord
  belongs_to :question
  has_many :comments, dependent: :destroy 
  has_many :a_votes, dependent: :destroy
  validates :body, presence: true, length: {minimum: 3}
end
