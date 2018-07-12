class Tweet < ApplicationRecord
	belongs_to :user
	has_many :tweet_tags
	has_many :tags, through: :tweet_tags
	validates :message, presence: true
	before_validation :link_check, on: :create
  validates :message, length: {maximum: 140, too_long: "A tweet is only 140 max. Everybody knows that!"}
  after_validation :apply_link, on: :create

  private

  def link_check
	  check = false
	  if self.message.include?("http://") || self.message.include?("https://")
	     check = true
	  else
	     check = false
	  end	

	  if check == true
			arr = self.message.split
			ind = arr.map{ |x| x.include?("http://") || x.include?("https://") }.index(true)
			self.link = arr[ind]
	    if arr[ind].length > 23
		    arr[ind] = "#{arr[ind][0..20]}..."	
	    end
						
		  self.message = arr.join(" ")
	  end
 	end	

 	def apply_link
	  arr = self.message.split
	  ind = arr.map { |x| x.include?("http://") || x.include?("https://") }.index(true)
	  if ind
			url = arr[ind]
			arr[ind] = "<a href='#{self.link}' target='_blank'>#{url}</a>"
		end

		self.message = arr.join(" ")
	end
end
