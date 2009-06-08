require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserController do
  integrate_views

  before(:each)do
    post :login, :user =>{"username"=>"ceekays","password" =>"test"}
  end


  it "should use UserController" do
    controller.should be_an_instance_of(UserController)
  end


  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should create new user" do
      post :new, :user=>{"username"=>"edceekays",
          "last_name"=>"Kachale", "first_name"=>"Edmond",
          "password"=>"test", "password_confirmation"=>"test","role"=>"admin"}

      @user = User.find_by_username(params[:user][:username])
      flash[:notice].should be_eql("User #{@user.username} has been succesfully created")
      end
  end

  describe "GET 'list'" do
  it "should be successful" do
  get 'list'
  response.should be_success
  end

  it "should find all users in the database"do
  #make sure that some user exists

  post :new, :user=>{"username"=>"edceekays",
  "last_name"=>"Kachale", "first_name"=>"Edmond",
  "password"=>"test", "password_confirmation"=>"test","role"=>"admin"}

  @all_users = User.find(:all)
  @all_users.should_not be_nil
  end
  end

  describe "GET 'search'" do
  it "should be successful" do
  get 'search'
  response.should be_success
  end

  end

  describe "GET 'edit'" do
  before(:each)do
  #create a new user and check if the user exists
  post :new, :user=>{"username"=>"edceekays",
  "last_name"=>"Kachale", "first_name"=>"Edmond",
  "password"=>"test", "password_confirmation"=>"test","role"=>"admin"}
  end

  it "should be successful" do
  get 'edit'
  response.should be_success
  end

  it "should save changes made to an existing user" do

  post :new, :user=>{"username"=>"edceekays",
  "last_name"=>"TryMan", "first_name"=>"Edmond",
  "password"=>"test", "password_confirmation"=>"test","role"=>"admin"}

  # trying to change the user username
  params[:user][:username] = "kaliko"
  #params[]

  post :edit, :id => "edceekays" , :user=>params[:user]
  #flash[:notice].should be_eql("The changes on 'kaliko' have been effected succefully!")

  User.find_by_username('kaliko').should_not be_nil

  end
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserController do
  integrate_views

  before(:each)do
  post :login, :user =>{"username"=>"ceekays","password" =>"test"}
  end


  it "should use UserController" do
  controller.should be_an_instance_of(UserController)
  end


  describe "GET 'index'" do
  it "should be successful" do
  get 'index'
  response.should be_success
  end
  end

  describe "GET 'new'" do
  it "should be successful" do
  get 'new'
  response.should be_success
  end

  it "should create new user" do
  post :new, :user=>{"username"=>"edceekays",
  "last_name"=>"Kachale", "first_name"=>"Edmond",
  "password"=>"test", "password_confirmation"=>"test","role"=>"admin"}

  @user = User.find_by_username(params[:user][:username])
  flash[:notice].should be_eql("User #{@user.username} has been succesfully created")
  end
  end

  describe "GET 'list'" do
  it "should be successful" do
  get 'list'
  response.should be_success
  end

  it "should find all users in the database"do
  #make sure that some user exists

  post :new, :user=>{"username"=>"edceekays",
  "last_name"=>"Kachale", "first_name"=>"Edmond",
  "password"=>"test", "password_confirmation"=>"test","role"=>"admin"}

  @all_users = User.find(:all)
  @all_users.should_not be_nil
  end
  end

  describe "GET 'search'" do
  it "should be successful" do
  get 'search'
  response.should be_success
  end

  end

  describe "GET 'edit'" do
  before(:each)do
  #create a new user and check if the user exists
  post :new, :user=>{"username"=>"edceekays",
  "last_name"=>"Kachale", "first_name"=>"Edmond",
  "password"=>"test", "password_confirmation"=>"test","role"=>"admin"}
  end

  it "should be successful" do
  get 'edit'
  response.should be_success
  end

  it "should save changes made to an existing user" do

  post :new, :user=>{"username"=>"edceekays",
  "last_name"=>"TryMan", "first_name"=>"Edmond",
  "password"=>"test", "password_confirmation"=>"test","role"=>"admin"}

  # trying to change the user username
  params[:user][:username] = "kaliko"
  #params[]

  post :edit, :id => "edceekays" , :user=>params[:user]
  #flash[:notice].should be_eql("The changes on 'kaliko' have been effected succefully!")

  User.find_by_username('kaliko').should_not be_nil

  end
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserController do
  integrate_views

  before(:each)do
  post :login, :user =>{"username"=>"ceekays","password" =>"test"}
  end


  it "should use UserController" do
  controller.should be_an_instance_of(UserController)
  end


  describe "GET 'index'" do
  it "should be successful" do
  get 'index'
  response.should be_success
  end
  end

  describe "GET 'new'" do
  it "should be successful" do
  get 'new'
  response.should be_success
  end

  it "should create new user" do
  post :new, :user=>{"username"=>"edceekays",
  "last_name"=>"Kachale", "first_name"=>"Edmond",
  "password"=>"test", "password_confirmation"=>"test","role"=>"admin"}

  @user = User.find_by_username(params[:user][:username])
  flash[:notice].should be_eql("User #{@user.username} has been succesfully created")
  end
  end

  describe "GET 'list'" do
  it "should be successful" do
  get 'list'
  response.should be_success
  end

  it "should find all users in the database"do
  #make sure that some user exists

  post :new, :user=>{"username"=>"edceekays",
  "last_name"=>"Kachale", "first_name"=>"Edmond",
  "password"=>"test", "password_confirmation"=>"test","role"=>"admin"}

  @all_users = User.find(:all)
  @all_users.should_not be_nil
  end
  end

  describe "GET 'search'" do
  it "should be successful" do
  get 'search'
  response.should be_success
  end

  end

  describe "GET 'edit'" do
  before(:each)do
  #create a new user and check if the user exists
  post :new, :user=>{"username"=>"edceekays",
  "last_name"=>"Kachale", "first_name"=>"Edmond",
  "password"=>"test", "password_confirmation"=>"test","role"=>"admin"}
  end

  it "should be successful" do
  get 'edit'
  response.should be_success
  end

  it "should save changes made to an existing user" do

  post :new, :user=>{"username"=>"edceekays",
  "last_name"=>"TryMan", "first_name"=>"Edmond",
  "password"=>"test", "password_confirmation"=>"test","role"=>"admin"}

  # trying to change the user username
  params[:user][:username] = "kaliko"
  #params[]

  post :edit, :id => "edceekays" , :user=>params[:user]
  #flash[:notice].should be_eql("The changes on 'kaliko' have been effected succefully!")

  User.find_by_username('kaliko').should_not be_nil

  end
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserController do
  integrate_views

  before(:each)do
  post :login, :user =>{"username"=>"ceekays","password" =>"test"}
  end


  it "should use UserController" do
  controller.should be_an_instance_of(UserController)
  end


  describe "GET 'index'" do
  it "should be successful" do
  get 'index'
  response.should be_success
  end
  end

  describe "GET 'new'" do
  it "should be successful" do
  get 'new'
  response.should be_success
  end

  it "should create new user" do
  post :new, :user=>{"username"=>"edceekays",
  "last_name"=>"Kachale", "first_name"=>"Edmond",
  "password"=>"test", "password_confirmation"=>"test","role"=>"admin"}

  @user = User.find_by_username(params[:user][:username])
  flash[:notice].should be_eql("User #{@user.username} has been succesfully created")
  end
  end

  describe "GET 'list'" do
  it "should be successful" do
  get 'list'
  response.should be_success
  end

  it "should find all users in the database"do
  #make sure that some user exists

  post :new, :user=>{"username"=>"edceekays",
  "last_name"=>"Kachale", "first_name"=>"Edmond",
  "password"=>"test", "password_confirmation"=>"test","role"=>"admin"}

  @all_users = User.find(:all)
  @all_users.should_not be_nil
  end
  end

  describe "GET 'search'" do
  it "should be successful" do
  get 'search'
  response.should be_success
  end

  end

  describe "GET 'edit'" do
  before(:each)do
  #create a new user and check if the user exists
  post :new, :user=>{"username"=>"edceekays",
  "last_name"=>"Kachale", "first_name"=>"Edmond",
  "password"=>"test", "password_confirmation"=>"test","role"=>"admin"}
  end

  it "should be successful" do
  get 'edit'
  response.should be_success
  end

  it "should save changes made to an existing user" do

  post :new, :user=>{"username"=>"edceekays",
  "last_name"=>"TryMan", "first_name"=>"Edmond",
  "password"=>"test", "password_confirmation"=>"test","role"=>"admin"}

  # trying to change the user username
  params[:user][:username] = "kaliko"
  #params[]

  post :edit, :id => "edceekays" , :user=>params[:user]
  #flash[:notice].should be_eql("The changes on 'kaliko' have been effected succefully!")

  User.find_by_username('kaliko').should_not be_nil

  end

  end
end
