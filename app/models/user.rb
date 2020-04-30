class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :validatable, :confirmable, :lockable

  has_one :user_profile , :dependent => :destroy
  has_many :messages , :foreign_key => :user_id , class_name: 'Message'  

  accepts_nested_attributes_for :user_profile

  after_save :init_user_profile  

  def init_user_profile    
    @current_user_profile = UserProfile.Find(self.id)
    if @current_user_profile == nil 
      @current_user_profile = UserProfile.Create(self.id)
    end    
  end

  def User::exist(id)
    user = User.find_by_id(id)
    if user == nil
      return false
    else
      return true
    end
  end  
end
