class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true, uniqueness: true
	has_many :tweets

	serialize :following, Array
	
	mount_uploader :avatar, AvatarUploader

end
