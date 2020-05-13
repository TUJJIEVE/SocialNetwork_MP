class Question < ApplicationRecord
    attr_accessor :date, :time
    validates :title, presence: true, length: {minimum: 5, maximum:30}
    validates :text , presence: true, length: {minimum: 5}
    has_many :answers, dependent: :destroy
    has_many :q_comments, dependent: :destroy
    has_many :q_votes, dependent: :destroy
    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings

    has_one_attached :qimage  , :dependent => :purge_later

    def all_tags=(names)
        self.tags = names.split(",").map do |name|
            Tag.where(name: name.strip).first_or_create!
        end
    end

    def self.tagged_with(name)
        @rec = Tag.find_by_name(name)
        if @rec != nil 
            @rec.questions
        else
            nil

        end
    end

    def all_tags
        self.tags.map(&:name).join(",")
    end

end
