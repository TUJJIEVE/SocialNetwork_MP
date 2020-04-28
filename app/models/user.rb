class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :validatable, :confirmable, :lockable

  has_one :user_profile , :dependent => :destroy
  has_many :messages , :foreign_key => :user_id , class_name: 'Message'  

  accepts_nested_attributes_for :user_profile

  after_save :init_user_profile  

  #############################################################
  #
  # NEED TO THINK OF A BETTER WAY than USING cREATE HERE      #
  #
  #############################################################
  def init_user_profile    
    @current_user_profile = UserProfile.Create(self.id)
    @current_user_profile 
  end
end
