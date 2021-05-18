class Micropost < ApplicationRecord
  belongs_to :user
  belongs_to :parent, class_name: "Micropost", optional: true
  has_many :quotes, class_name: "Micropost",
                    foreign_key: "parent_id"
  has_many :reposts
  has_many :comments
  has_many :likes
  has_one_attached :image
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
                                    message: "must be a valid image format" },
                    size:         { less_than: 5.megabytes,
                                    message: "should be less than 5MB" }

  # Returns a resized image for display.
  def display_image
    image.variant(resize_to_limit: [500, 500])
  end

  # Returns the users that the given user follows that have reposted a certain micropost
  def followings_who_reposted(user)
    following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
    repost_ids = "SELECT user_id FROM reposts
                  WHERE micropost_id = :micropost_id"
    User.where("id IN (#{following_ids})
                AND id IN (#{repost_ids})", user_id: user.id, micropost_id: id)
  end

  # Returns total number of quotes and reposts
  def rqcount
    reposts.count + quotes.count
  end
end
