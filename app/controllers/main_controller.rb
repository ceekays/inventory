class MainController < ApplicationController
  def index
  @tasks=[
    ["Find Item",item_path(:find)],
    ["Register Item",item_path(:new)],
    ["Record Incoming Item",track_path(:item_in)],
    ["Record Outgoing Item",track_path(:item_out)],
    ["Generate Reports",item_path(:list)]
  ]
  end
end
