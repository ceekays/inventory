class ReportsController < ApplicationController
  before_filter :authorize, :except   => [:login, :logout, :get_layout]
  def render_item_menu
    @tasks=[
      ["Item Management",main_path(:items)],
      ["Main Dashboard",main_path(:index)]
    ]

    if @tasks && session[:user_id]
    @tasks<<["Logout", user_path(:logout)]
    else
      @tasks<<["Login", user_path(:login)]
    end
  end

  def index

  end

  def consummables

  end

  def ribbons

  end
  
  def labels

  end
end
