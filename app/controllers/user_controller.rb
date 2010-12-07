class UserController < ApplicationController

  # find 'login' and 'logout' in ApplicationController
  before_filter :authorize, :except   => [:login, :logout, :get_layout]
  # creates a new user in the database 
	
  def index
    @pagetitle = 'Main Menu'
  end

	def render_user_menu
		 @tasks=[
      ["Item Management",main_path(:items)],
      ["User Administration",main_path(:users)],
      ["Main Dashboard",main_path(:index)]
    ]
    
    @pagetitle = 'User Details'
    @all_users = User.find(:all)
    @admin = false
    @admin = true if (Role.find(User.find(session[:user_id]).role).role.downcase == "admin")
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
    render_user_menu
    #session[:edit_user] = @edit
  end
  
  # searches for a user to be edited
  # The request.post? runs by defualt if, called using a 'link_to' or a 
  # In the index contoller, there is
  def search
     @pagetitle = 'Search for a Particular User'		
   	
    if request.post?
			#query=params[:user][:query] if params[:user][:query]
		  
		  query = User.find_by_username(params[:user][:query])
			if !(query == nil)
      	redirect_to :action=>"show", :id => query.id
      else
      	flash[:notice] = "#{params[:user][:query]} not found"
      	redirect_to main_path(:users)
      end
    end
  end
  
  #show user details
  def show
  	render_user_menu
  	@user = User.find(params[:id])
  	if @tasks
       @tasks<< ["Edit", user_path(:edit,@user)]
       @tasks<< ["List", user_path(:list,@user)]
    end
  end
  
  #remove/delete user from the database
  def delete_user
  	render_user_menu
  	@user = User.find(params[:id])
    @user.destroy
    
    redirect_to :action => "list"
    flash[:notice] ="#{@user.username} successfully deleted!"
  end
  
  # edits user details
  # requires an id paramter from the search action 
  def edit								
    @pagetitle = 'Edit User Details'
    if params[:id]
    	@user = User.find(params[:id])
		  if request.post? &&  @user
		    params[:user][:role] = Role.find_by_role(params[:user][:role]).id
		    if @user.update_attributes(params[:user])
		      redirect_to :action => "index"
		      flash[:notice] ="The changes on '#{@user.username}' have been effected succefully!"
		    else
		      redirect_to :action => "index"
		      flash[:notice] ="The changes have not been effected on the user!"
		    end
		  end
  	end
  end
  
end
