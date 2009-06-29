require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MainController do

  integrate_views
  
  it "should use MainController" do
    controller.should be_an_instance_of(MainController)
  end
  describe "GET paths" do

	it "should link to items menu"do
      route_for(:controller => "main", :action => "items").should == main_path(:items)
    end

end
  describe "GET 'index'" do

    before(:each)do
      get 'index'
    end

    it "should be successful" do
      response.should be_success
    end
    
    it "should have a link to item management" do
      response.body.should include(main_path(:items))
    end

    it "should have a link to user management" do
      response.body.should include(main_path(:users))
    end

    it "should have a link to generate reports" do
      response.body.should include(item_path(:list))
    end
    
  end

  describe "GET 'items'" do

    before(:each)do
      get 'items'
    end

    it "should be successful" do
      response.should be_success
    end

    it "should have a link to 'Find Item'" do
      response.body.should include(item_path(:find))
    end

    it "should have a link to 'Register Item'" do
      response.body.should include(item_path(:new))
    end

    it "should have a link to 'Record Incoming Item'" do
      response.body.should include(item_path(:in))
    end

    it "should have a link to 'Record Incoming Item'" do
      response.body.should include(item_path(:out))
    end

    it "should have a link to index" do
      response.body.should include(main_path(:index))
    end
    
  end

  describe "GET 'users'" do
    
    before(:each)do
      get 'users'
    end
    
    it "should be successful" do      
      response.should be_success
    end

    it "should have a link to /user/new", :shared => true do
      response.body.should include(user_path(:new))
    end

    it "should have a link to /user/search" do
        response.body.should include(user_path(:search))
      end

    it "should have a link to /user/list" do
        response.body.should include(user_path(:list))
    end

    it "should have a link to index" do
      response.body.should include(main_path(:index))
    end

  end
  
end
