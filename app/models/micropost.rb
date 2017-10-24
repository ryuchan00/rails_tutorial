class Micropost < ApplicationRecord
  belongs_to :user
  # belongs_to :in_reply, :class_name => "User" # :class_nameを指定
  default_scope -> {order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}
  validate :picture_size
  scope :including_replies, -> (user_id) {where(in_reply_to: user_id)}

  private

    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picutre, "should be less than 5MB")
      end
    end
end
