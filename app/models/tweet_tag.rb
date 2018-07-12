class TweetTag < ApplicationRecord
	belongs_to :Tweet
	belongs_to :tag
end
