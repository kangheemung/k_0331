class User < ApplicationRecord
    has_secure_password
    has_many :post
     validates :password, length: { maximum: 140 }
end
