class Post < ActiveRecord::Base
    belongs_to :user
    has_many :comments
    has_many :reader, through: :shared_posts
    
    default_scope -> { order(created_at: :desc) }
    validates :title, presence: true
    validates :content, presence: true

    def share(reader)
    	shared_posts.create(author: current_user, post:post, reader: reader)
    end

    def unshare(reader)
    	shared_posts.find_by(author:current_user, post: post, reader:reader).destroy
    end

    def shared?(reader)
    	shared_posts.include?(author:current_user, post: post, reader: reader)
    end
end
