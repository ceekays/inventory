require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
       params_user = {:username =>"mondi",:first_name =>"Edmond",:last_name =>"Kachale",
            :role => Role.find(1).role, :password =>"test", :password_confirmation =>"test"}
          
    @user =  User.new(params_user)
    @user.save
  end

  it "should exist" do
    User.exists?.should be_true
  end

  
  it "should have a username" do
    @user.username.should_not be_nil 
  end

  it "should not have a blank password" do
    @user.password.should_not be_blank    
  end
  
  it "should not encrypt blank password" do

    encrypted_password = @user.encrypted_password
    @user.encrypted_password.should == encrypted_password
  end

   it "should have a password that is not less than 4 characters" do
    @user.password.length.should_not < 4
  end
  
  it "should have a role" do
    @user.role.should_not be_blank
  end

  it "should be valid after saving" do
    @user.should be_valid
  end
 
  it "should have an encrypted password" do
    @user.encrypted_password.eql?(@user.password).should be_false
  end

  it "should be authenticated on login" do
    u = User.authenticate(@user.username,"cheek")
		u.should_not be_true
  end

  it "should create a salt of length not less than 40" do
    @user.salt.length.should >= 40
  end

end

