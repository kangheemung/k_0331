class User < ApplicationRecord
    has_secure_password
      has_many :posts
     #validates :password, length: { maximum: 140 }
end
