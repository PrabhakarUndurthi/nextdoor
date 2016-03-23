class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    has_many :statuses
    has_many :friends
    has_many :user_friendships
    has_many :friends, through: :user_friendships

    validates :first_name, :last_name, :user_name, presence: true
    
    validates :user_name, presence: true, uniqueness: true
    
    validates :user_name, format: {
    with: /\A[a-zA-Z0-9_-]+\z/,
    message: "must be formatted correctly."
  }
    def full_name
    	first_name + " " + last_name
    end

    def gravatar_url
      stripped_email = email.strip
      downcased_email = stripped_email.downcase
      hash = Digest::MD5.hexdigest(downcased_email)

      "http://gravatar.com/avatar/#{hash}"
    end
end
