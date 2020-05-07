class Article < ApplicationRecord

    attr_accessor :date, :time
    validates :title, presence: true, length: {minimum: 5}
    validates :body , presence: true, length: {minimum: 5}
    has_many :ataggings, dependent: :destroy
    has_many :tags, through: :ataggings
    has_many :claps, dependent: :destroy   
    def all_tags=(names)
        self.tags = names.split(",").map do |name|
            Tag.where(name: name.strip).first_or_create!
        end
    end

    def self.tagged_with(name)
        @rec = Tag.find_by_name(name)
        if @rec != nil 
            @rec.articles
        else
            nil

        end
    end

    def all_tags
        self.tags.map(&:name).join(",")
    end

end
