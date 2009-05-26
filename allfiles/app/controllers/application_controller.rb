# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  #=============================================================================
  # login method 
  # aunthenticates the user
  # On success:
  #    it returns the user to the previous url or 
  #    just redirect them to 'home page'
  # On failure:
  #    it flags an error message and 'returns' the user to the login form
  #=============================================================================
  
  def login
    session[:user_id] = nil
    user = User.authenticate(username, password)
    if user
      session[:user_id] = user.id
      session[:username] = user.username
      
      url = session[:original_url]
      session[:original_url] = nil
      
      #return the user to the previous url or just redirect them to 'home page'
      redirect_to (url || {action => 'home'})
      flash[:notice] = "Welcome #{session[:username]}," + 
                        "you have succesfully logged in"
          
    else
      flash[:notice] = "Invalid user/password combination"
    end
  end
  #============================================================================= 
  # logout:
  #   clears the session user_id and username
  #=============================================================================
  def logout
    session[:user_id] = nil
    session[:username] = nil
    
    flash[:notice] = "You have logged out"
    redirect_to :action =>'index'
  end
  
  #==========================================================================
  #
  #   This section contains some private methods:
  #
  #      authorize:     enforces the user to login when visiting admin pages
  #
  #      get_layout:    determines the layout to be used according as 
  #                     to whether the user is logged in  
  #==========================================================================
  private
  
  def authorize
     unless User.find_by_user_id(session[:user_id])
       session[:original_uri] = request.request_uri
       flash[:notice] = "Please log in"
       redirect_to(:controller => "viewer" , :action => "show", :name=> "login" )
     end
  end
  
 def get_layout
     if session[:user_id] 
         "admin"   
      else
         "application"
     end
  end
end
