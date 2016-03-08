class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    has_many :statuses

    validates :first_name, :last_name, :user_name, presence:true
    
    validates :user_name, presence:true, uniqueness:true
    
    validates :user_name, format: {
    with: /\A[a-zA-Z\-\_]+\Z/,
    message: "must be formatted correctly."
  }
    def full_name
    	first_name + " " + last_name
    end
end
