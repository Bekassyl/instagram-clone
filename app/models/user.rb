class User < ApplicationRecord

  before_create :create_remember_token
  has_secure_password
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy

  has_many :likes, foreign_key:	"user_id",	dependent:	:destroy
  has_many :post_indexes, through: :likes, source: :index


  has_many	:relationships,	foreign_key:	"follower_id",	dependent:	:destroy
  has_many :followed_users, through: :relationships, source: :followed

  has_many :reverse_relationships, foreign_key: "followed_id",
            dependent: :destroy, class_name: "Relationship"
  has_many :followers, through: :reverse_relationships




  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  has_attached_file :avatar,
              styles: {:thumbnail => "35x35", :avatar => "200x200"}

  validates_attachment :avatar, presence: true, content_type: {content_type: ["image/png", "image/jpeg"]},  size: {in: 1..5000.kilobytes}

  validates :login, presence: true, uniqueness: true,
                    length: {minimum: 3, maximum: 12}
  validates :email, presence: true,
                    uniqueness: {case_sensitive: false},
                    format: VALID_EMAIL_REGEX
  validates :password, length: {minimum: 6}
  validates :bio, presence: true, length: {maximum: 120}


  def	User.new_remember_token
      SecureRandom.urlsafe_base64
  end

  def	User.encrypt(token)
      Digest::SHA1.hexdigest(token.to_s)
  end

  def like(post)
    self.likes.create(post_index: post)
  end

  def dislike(post)
    self.likes.find_by_post_index(post).destroy if likes?(post)
  end

  def liking?(user)
    self.likes.find_by_post_index(posts)
  end

  def follow(user)
    self.relationships.create(followed_id: user)
  end

  def unfollow(user)
    self.relationships.find_by_followed_id(user).destroy if following?(user)
  end

  def following?(user)
      self.relationships.find_by_followed_id(user)
  end

  def feed
    Post.where(user_id: followed_user_ids)
  end

  private
  def	create_remember_token
      self.remember_token	=	User.encrypt(User.new_remember_token)
  end
end
