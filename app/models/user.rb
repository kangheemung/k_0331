class User < ApplicationRecord
    attr_accessor :remember_token, :activation_token #attr_accessorを使ってアクセス可能な属性を作成する。
    has_secure_password
    has_many :posts, dependent: :destroy
    before_save   :downcase_email
    before_create :create_activation_digest
    before_save { self.email = email.downcase }
    validates :username, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                 format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
     
    private
     # 渡された文字列のハッシュ値を返す
    def self.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def feed
      Post.where("user_id = ?", id)
    end
  # 永続セッションのためにユーザーをデータベースに記憶する
    def remember
      self.remember_token = User.new_token
      update_attribute(:remember_digest, User.digest(remember_token))
    end
  # 渡されたトークンがダイジェストと一致したらtrueを返す
    def authenticated?(remember_token)
      return false if remember_digest.nil?
      BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

  # ランダムなトークンを返す
    def self.new_token
      SecureRandom.urlsafe_base64
    end

     # ユーザーのログイン情報を破棄する
    def forget
      update_attribute(:remember_digest, nil)
    end
  
    # メールアドレスをすべて小文字にする
    def downcase_email
      self.email = email.downcase
    end

    # 有効化トークンとダイジェストを作成および代入する
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

end
