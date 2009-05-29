require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserController do
  integrate_views
  
  #Delete these examples and add some real ones
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
  end

  describe "GET 'list'" do
    it "should be successful" do
      get 'list'
      response.should be_success
    end
  end

  describe "GET 'search'" do
    it "should be successful" do
      get 'search'
      response.should be_success
    end
  end
end
