class User < ApplicationRecord
    has_secure_password
      has_many :posts
      validates :email, presence: true, length: { maximum: 255 }
     validates :username, presence: true, length: { maximum: 50 }
     validates :password, length: { maximum: 140 }
     validates :email, presence: true
end
