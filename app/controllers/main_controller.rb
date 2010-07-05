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

    @categories = Item.find(:all,
                    :select => "category AS name, COUNT(category) AS quantity",
                    :group => "category")


 if(@categories.count == 1)
   flash[:num_of_items] = "There <b><i>one category</i></b> of Items."
 else
  flash[:num_of_items] = "There are <b><i>#{@categories.count} categories</i></b> of Items."
 end

    @tasks=[
      ["Find Item",item_path(:find)],
      ["Register Item",item_path(:new)],
      ["Record Incoming Item",item_path(:in)],
      ["Record Outgoing Item",item_path(:out)],
      ["Generate Reports",reports_path(:index)],
      ["Main Dashboard",main_path(:index)]
    ]
  end
  def users
     num_of_users = User.find(:all)

    users = 0
    @summary = {:user=>:user, :log => :log}

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
