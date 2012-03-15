# == Schema Information 
#This was added via the annotate 2.4.0 gem added to group :development
#once gem is installed, run $ bundle exec annotate --position before
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
	attr_accessible :name, :email #this restricts outside modification to the attributes listed here - protects from mass assignment vulnerability
	
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, 	:presence => true,
						:length => { :maximum => 50 }
	validates :email, 	:presence => true,
						:format => { :with => email_regex },
						:uniqueness => { :case_sensitive => false }
end
