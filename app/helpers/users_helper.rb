module UsersHelper
	def gravatar_for(user, options = { :size => 50 })
		gravatar_image_tag(user.email.downcase, :alt => h(user.name), #alt attributes must be escaped explicitly, note use of 'h'
												:class => 'gravatar',
												:gravatar => options)
	end
end
