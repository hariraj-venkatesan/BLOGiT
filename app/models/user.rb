class User < ActiveRecord::Base
	has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :shared_posts, dependent: :destroy

	attr_accessor :remember_token
    before_create :confirmation_token
	before_save { self.email = email.downcase }
    
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    validates :password, presence: true, length: { minimum: 8 }, allow_nil: true
    has_secure_password

    def User.digest(string)
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    	BCrypt::Password.create(string, cost: cost)
    end

    def User.new_token
    	SecureRandom.urlsafe_base64
    end

    def remember
    	self.remember_token = User.new_token
    	update_attribute(:remember_digest, User.digest(remember_token))
    end

    def authenticated?(remember_token)
    	return false if remember_digest.nil?
    	BCrypt::Password.new(remember_token).is_password?(remember_token)
    end

    def forget
    	update_attribute(:remember_digest, nil)
    end

    def feed
        shared_post_ids = SharedPost.where(reader_id:id).map { |s| s.post_id }
        shared_post_ids.concat Post.where("user_id = ?", id).map{ |p| p.id }
    	Post.where('id IN (?)', shared_post_ids)
    end

    def self.all_except(user)
      where.not(id: user)
    end

    def email_activate
        self.email_confirmed = true
        self.confirm_token = nil
        save!(validate: false)
    end

    def confirmation_token
        if self.confirm_token.blank?
            self.confirm_token = SecureRandom.urlsafe_base64.to_s
        end
    end

    def name_with_email
        "#{name} ( #{email} )"
    end
end
