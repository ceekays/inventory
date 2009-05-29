class UserController < ApplicationController

  def index
    @pagetitle = 'Test Main Menu'
  end
  def new
    @pagetitle = 'Test Create New User'
    @user = User.new(params[:user])
    if request.post? && @user.save
      redirect_to(:action => "index")
      flash[:notice] = "User #{@user.username} has been succesfully created"
      @user = User.new
    end
  end

  def basi
    render :text => 'aaaaaa'
  end
  
  #lists users in the users' table
  def list
    @pagetitle = 'Test User Details'
    @all_users = User.find(:all)
    #session[:edit_user] = @edit
  end
  
  # searches for a user to be edited
  # The request.post? runs by defualt if, called using a 'link_to' or a 
  # In the index contoller, there is
  def search
     @pagetitle = 'Search for a Particular User'		
    #session[:method] = 'get'
    if request.post?
      redirect_to :action=>"edit", :id => params[:user][:id] 
    end
  end
  
  # edits user details
  # requires an id paramter from the search action 
  def edit								
    @pagetitle = 'Edit User Details'
    if params[:id]
    @user = User.find(params[:id])
    if request.post? &&  @user
      if @user.update_attributes(params[:user])
        redirect_to :action => "index"
        flash[:notice] ="The changes on '#{@user.username}' have been effected succefully!"
      else
        #redirect_to :action => "index"
        flash[:notice] ="The changes have not been effected on the user!" 
      end
    end
  end
  end
  
end
