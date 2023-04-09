class User < ApplicationRecord
    has_secure_password
     has_many :posts
     before_save { email.downcase! }
     validates :email, presence: true, length: { maximum: 255 },
                 format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }
                  
     VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
     validates :username, presence: true, length: { maximum: 50 }
      validates :password, presence: true, length: { minimum: 6 }

    
end
