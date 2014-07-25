class Post < ActiveRecord::Base
	validates :content, :presence => true, :length => { :minimum => 20 }
	validates :title, :presence => true, :uniqueness => true
	# , format: { with: /\A[a-zA-Z]+\z/,
 #    message: "only allows letters" , }
    # , exclusion: { in: %w(xxx 3x),
    # message: "%{value} is not allowed." }, 
    # inclusion: { in: %w(small medium large),
    # message: "%{value} is not a valid size" }
    # , allow_nil: true, allow_blank: true
    has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" }
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	extend FriendlyId
	friendly_id :slug_candidates, use: [:slugged, :finders, :history]
	
	searchable do
	    text :title, :boost => 2.0
	    text :content
  	end
	def self.get_other_posts(post_id)
		posts = Post.where.not(id: post_id) rescue nil
		return posts
	end

	def slug_candidates
		[
			:title,
			[:title, :id]
		]
	end

	def should_generate_new_friendly_id?
	  title_changed?
	end
	
end
