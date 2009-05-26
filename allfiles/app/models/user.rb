class User < ActiveRecord::Base
	validates_presence_of 		:username,:message => "cannot be blank, please check"  
	validates_uniqueness_of	:username
	
	validates_presence_of 		:password
	#validates_uniqueness_of	:password
	
	attr_accessor 							:password_confirmation #, :message => "cannot be blank, please check"
	validates_confirmation_of	:password 
 
  def validate
    errors.add(:password, "Missing password" ) if password.blank?
    #errors.add_to_base("Missing password" ) if password.blank?
  end
  
  def self.authenticate(username, password)
user = self.find_by_username(username)
if user
expected_password = encrypt_password(password, user.salt)

if user.password != expected_password
user = nil            
end
end
user # return the user
  end
  
  # 'password' is a virtual attribute
  def user_password
   @password
  end
  
  def user_password=(pwd)
   @password = pwd
   return if pwd.blank?
   
   create_new_salt
   self.user_password = User.encrypt_password(self.password, self.salt)
  end
  
  def create_new_salt
  
  self.salt = self.object_id.to_s + rand.to_s
  end
  
  private
  
  def self.encrypt_password(password, salt)
  string_to_hash = password + "wibble" + salt  # 'wibble' makes it harder to guess
  Digest::SHA1.hexdigest(string_to_hash)
  end
end
