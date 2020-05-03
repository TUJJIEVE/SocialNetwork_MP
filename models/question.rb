class Question < ApplicationRecord
    attr_accessor :date, :time
    validates :title, presence: true
    
end
