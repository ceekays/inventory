class User < ActiveRecord::Base
  has_many :statuses
#  has_one :role

  validates_presence_of 		:username, :message => "cannot be blank, please check"  
  validates_uniqueness_of	  :username
  validates_presence_of 		:password
  #validates_uniqueness_of	:password
  attr_accessor 						:password_confirmation #, :message => "cannot be blank, please check"
  validates_confirmation_of	:password 

  #checks whether the password is blank and records an error message
  def validate
    errors.add(:password, "Missing password" ) if password.blank?
    #errors.add_to_base("Missing password" ) if password.blank?
  end

=begin rdoc
  Authenticates the user using the password that is entered.
  Using the username, it checks whether the user exists in the database. If the
  user exists, it takes the user's salt and encryipts the password that the user 
  entered to check it against the expected password, which the one in the database
=end
  
  def self.authenticate(username, password)
  
    user = self.find_by_username(username)
    
    if user
      expected_password = encrypt_password(password, user.salt)
    if user.encrypted_password != expected_password
        user = nil            
      end
    end
    
    user # return the user
  end

  # 'password' is a virtual attribute
  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    return if pwd.blank?

    create_new_salt
    self.encrypted_password=User.encrypt_password(self.password,self.salt)
  end 
  
  def create_new_salt
    self.salt = String.random_alphanumeric
  end
  private

  def self.encrypt_password(password, salt)     
    string_to_hash = password + salt  
    Digest::SHA1.hexdigest(string_to_hash)
  end
  
  # Returns a random alphanumeric string of arbitrary size.

  def String.random_alphanumeric(size=40)
    s = ""
    size.times { s << (i = Kernel.rand(62); i += ((i < 10) ? 48 : ((i < 36) ? 55 : 61 ))).chr }
    s
  end

end
