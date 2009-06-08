require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
       params_user = {:password_confirmation =>"test",:username =>"mondi",
            :role => Role.find(1).role, :last_name =>"Edmond",
            :password =>"test", :first_name =>"Kachale"}
    @user =  User.new(params_user)
    @user.save
  end

  it "should exist" do
    User.exists?
  end

  it "should be valid after saving" do   
    @user.should be_valid
  end

  it "should have a username" do
    @user.username.should_not be_nil 
  end

  it "should be authenticated on login"do   
    u = User.authenticate(@user.username,"cheek")
		u.should_not be_true
  end
  
  it "should have a role"do
    @user.role.should == "admin"
  end

  it "should have a password that is not less than 4 characters"do
    @user.password.length.should >= 4
  end
  it "should have an encrypted password" do
     @user.encrypted_password.should_not == "mondi"
  end

  it "should create a salt of length not less than 40"do
    @user.encrypted_password.length.should >= 40
  end
end

