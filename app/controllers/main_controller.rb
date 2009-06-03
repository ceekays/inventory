class MainController < ApplicationController
  def index
    @tasks=[
      ["Item Management",main_path(:items)],
      ["User Administration",main_path(:users)],
      ["Generate Reports",item_path(:list)]
    ]
  end
  def items
    @tasks=[
      ["Find Item",item_path(:find)],
      ["Register Item",item_path(:new)],
      ["Record Incoming Item",item_path(:in)],
      ["Record Outgoing Item",item_path(:out)],
      ["DashBoard",main_path(:index)]
    ]
  end
  def users
    @tasks=[
      ["Add User",user_path(:new)],
      ["Find User",user_path(:search)],
      ["List Users",user_path(:list)],
      ["DashBoard",main_path(:index)]
    ]
  end
end
