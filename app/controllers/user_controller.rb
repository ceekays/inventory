class UserController < ApplicationController

  # find 'login' and 'logout' in ApplicationController
  before_filter :authorize, :except   => [:login, :logout, :get_layout]
  # creates a new user in the database 
	
  def index
    @pagetitle = 'Main Menu'
  end
  def new
    @pagetitle = 'Create New User'
   
		@user = User.new(params[:user])
        
    if request.post?
      @user.role = Role.find_by_role(params[:user][:role]).id
      if (@user.save)
        flash[:notice] = "User #{@user.username} has been succesfully created"
      else
        flash[:notice] = "User #{@user.username} has not been created"
      end
      redirect_to(:action => "index")

      @user = User.new
    end
  end
  
  #lists users in the users' table
  def list
        @tasks=[
      ["Item Management",main_path(:items)],
      ["User Administration",main_path(:users)],
      ["Main Dashboard",main_path(:index)]
    ]
    
    @pagetitle = 'User Details'
    @all_users = User.find(:all)
    @admin = false
    @admin = true if (Role.find(User.find(session[:user_id]).role).role.downcase == "admin")
    #session[:edit_user] = @edit
  end
  
  # searches for a user to be edited
  # The request.post? runs by defualt if, called using a 'link_to' or a 
  # In the index contoller, there is
  def search
     @pagetitle = 'Search for a Particular User'		
   	
    if request.post?
	#params[:user] = User.find_by_username(params[:user][:username])
      	redirect_to :action=>"edit", :id => params[:user][:username]
    end
  end
  
  # edits user details
  # requires an id paramter from the search action 
  def edit								
    @pagetitle = 'Edit User Details'
    if params[:id]
    @user = User.find(params[:id])
    if request.post? &&  @user
      @user.role = Role.find_by_role(params[:user][:role]).id
      if @user.update_attributes(params[:user])
        redirect_to :action => "index"
        flash[:notice] ="The changes on '#{@user.username}' have been effected succefully!"
      else
        redirect_to :action => "index"
        flash[:notice] ="The changes have not been effected on the user! Probably the user does not exist."
      end
    end
  end
  end
  
end
