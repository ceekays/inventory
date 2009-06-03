require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
       params_user = {:password_confirmation =>"mile",:username =>"milex",
            :role =>"admin", :last_name =>"Hara",
            :password =>"mile", :first_name =>"Kondwani"}
    @user =  User.new(params_user)
  end

  it "should exist" do
    User.exists?
  end
  it "should be valid after saving" do
    @user.save
    @user.should be_valid
  end
  it "should be authenticated on login"do
	u = User.authenticate(@user.username, @user.password)
		puts u.username
		#puts @user.password
  end
end

