class MainController < ApplicationController
  def index

    #process = if session then  (session[id] = nil && user_path(:logout)) else user_path(:login) end
  
    @tasks=[
      ["Item Management",main_path(:items)],
      ["User Administration",main_path(:users)]
    ]
    #render :text=>"#{@tasks}"
  end
  def items
    @tasks=[
      ["Find Item",item_path(:find)],
      ["Register Item",item_path(:new)],
      ["Record Incoming Item",item_path(:in)],
      ["Record Outgoing Item",item_path(:out)],
      ["Generate Reports",item_path(:list)],
      ["Main Dashboard",main_path(:index)]
    ]
  end
  def users
     num_of_users = User.find(:all)

    users = 0
    @summary = {:user, :log}
    num_of_users.each { users += 1 }

    @summary[:user] = "There are " + users.to_s + " users in the system."

    if session[:user_id]
      @summary[:log] =  "You are currently logged in"
    else
      @summary[:log] = "You are not logged in, please log in."
    end
    @tasks=[
      ["Add User",user_path(:new)],
      ["Find User",user_path(:search)],
      ["List Users",user_path(:list)],
      ["Main Dashboard",main_path(:index)]
    ]
  end
end
