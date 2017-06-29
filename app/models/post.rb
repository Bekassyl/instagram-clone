class Post < ApplicationRecord


  has_attached_file :image,
              styles: {:thumbnail => "60x60", :large => "570x570"}
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :likes, foreign_key:	"post_index",	dependent:	:destroy
  has_many :user_ids, through: :likes, source: :id

  validates :user_id, presence: true
  validates :description, length: {maximum: 255}
  validates_attachment :image, presence: true, content_type: {content_type: ["image/png", "image/jpeg"]},  size: {in: 1..5000.kilobytes}

  belongs_to :user

end
