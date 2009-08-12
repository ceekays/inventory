require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ItemController do

  integrate_views
  
    before(:each)do
    post :login, :user =>{"username"=>"ceekays","password" =>"test"}
  end
  
  before(:each)do
    post :new, :item =>{
    "name"=> "Thinkpad", "model"=>"R50e", "serial_number"=> "",
    "barcode"=> "", "category"=> "Laptop", "manufacturer"=> "IBM"}
  end

  it "should use ItemController" do
    controller.should be_an_instance_of(ItemController)
  end
  
  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end

    it "should create a new item "do
      post :new, :item =>{"name"=> "Notebook", "model"=>"VGN-NS240E",
        "serial_number"=> "","barcode"=> "", "category"=> "Laptop",
        "manufacturer"=> "Toshiba"}
      
      
      @item = Item.find_by_name(params[:item][:name])
     
      flash[:notice].should be_eql("Item registration successful.")
    end
  end

  describe "GET 'edit'" do

    before(:each)do
      params[:item][:name] ="Toshiba Satellite L300"
    end
    it "should be successful" do
      get :edit, :id => 1 , :item=>params[:item]
      response.should be_success
    end

    #This example tries to change the name of the first item in the database
    #and check if the change has been effected
    it "should save changes to an existing item"do
      
      post :edit, :id => 1 , :item=>params[:item]
      Item.find(1).name.should be_eql("Toshiba Satellite L300")
    end
  end

  describe "GET 'find'" do
    it "should be successful" do
      get :find
      response.should be_success
    end

    # Trying to search for an item with a "pad" string
    # The name need not to be "exact"
    it "should find an existing item " do
      params[:item][:query] = "pad"
      post :find, :item=>params[:item]
      query = params[:item][:query]
      flash[:notice].should_not be_eql("#{query} not found.")
    end
  end

  describe "GET 'list'" do
    it "should be successful" do
      get :list
      response.should be_success
    end


=begin

    it"add an exammple here"do
      raise"\"add some examples for 'list' action or comment/remove this example\""
    end
=end
  end

  describe "GET 'show'" do
    it "should be successful" do
      get :show, :id => 1
      response.should be_success
    end
    # if we are able to establish a session of an object, then that object exists
    it "should be able to find an item to be displayed"do
      check_item_id = 1
      post :show, :id => check_item_id
      session[:item_id].should == check_item_id
    end
  end

  describe "GET 'in'" do
    it "should be successful" do
      get :in
      response.should be_success
    end
    
    it "should be able to record the status of an incoming item"do
      post :in, :id => 1, :status =>{
        "item_id"=> :id, "message"=>"This has been take in", "reason"=> "defunked",
        "owner"=> "edmond", "user_id"=> "1"}
      
      flash[:notice].should be_eql("Item successfully recorded as 'in'.")
    end
  end

  describe "GET 'out'" do
    it "should be successful" do
      get :out
      response.should be_success
    end
    it "should be able to record the status of an outgoing item"do
      post :out, :id => 1, :status =>{
        "item_id"=> :id, "message"=>"This has been deployed", "reason"=> "maintained",
        "owner"=> "edmond", "user_id"=> "1"}

      flash[:notice].should be_eql("Item successfully recorded as 'out'.")
    end
  end
end
