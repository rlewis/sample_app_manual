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
	attr_accessor :password
	attr_accessible :name, :email, :password, :password_confirmation #this restricts outside modification to the attributes listed here - protects from mass assignment vulnerability
	
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, 	:presence => true,
						:length => { :maximum => 50 }
	validates :email, 	:presence => true,
						:format => { :with => email_regex },
						:uniqueness => { :case_sensitive => false }
						
	# Automatically create the virtual attribute 'password_confirmation'.
	validates :password,:presence     => true,
						:confirmation => true,
						:length => { :within => 6..40 }
	
	before_save	:encrypt_password #callback to method encrypt_password called by Active Record prior to save
	
	# Return true if the user's password matches the submitted password
	def has_password?(submitted_password)
		# compare encrypted_password with the encrypted version of submitted_password
		encrypted_password == encrypt(submitted_password)
	end
	
	def has_password?(submitted_password)
		encrypted_password == encrypt(submitted_password)
	end
	
	def self.authenticate(email, submitted_password)
		user = find_by_email(email)
		return nil if user.nil?
		return user if user.has_password?(submitted_password)
	end
	
	def self.authenticate_with_salt(id, cookie_salt)
		user = find_by_id(id)
		(user && user.salt == cookie_salt) ? user : nil
	end
	
	private #specifies that all of the following methods are for internal use only
		def encrypt_password
			self.salt = make_salt unless has_password?(password)
			self.encrypted_password = encrypt(password) #self here refers to the User object, if omitted, Ruby would create a local variable instead - self is not optional when assigning an attributed, but self.password is understood by context
		end
		
		def	encrypt(string)
			secure_hash("#{salt}--#{string}")
		end
		
		def make_salt
			secure_hash("#{Time.now.utc}--#{password}")
		end
		
		def secure_hash(string)
			Digest::SHA2.hexdigest(string)
		end
end
