class Like < ActiveRecord::Base
  belongs_to :user, class_name: "User"
  belongs_to :post, class_name: "Post"
  validates_presence_of :user_id, :post_index
end
