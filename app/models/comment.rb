class Comment < ApplicationRecord
  belongs_to :answer
  validates :body , presence: true, length: {minimum: 5}

end
