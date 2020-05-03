class Question < ApplicationRecord
    attr_accessor :date, :time
    validates :title, presence: true, length: {minimum: 5}
    has_many :answers, dependent: :destroy
end
