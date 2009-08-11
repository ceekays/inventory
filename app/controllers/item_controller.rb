class ItemController < ApplicationController
  before_filter :authorize, :except   => [:login, :logout, :get_layout]
  def new
    
    if request.post?
      item=Item.new(params[:item]) if params[:item]
      if item.save
        flash[:notice] = "Item registration successful."
        redirect_to item_path(:show,item)
      else
        flash[:error] = "Item registration failed."
      end
    else
      @item_fields   = [:name,:model,:serial_number,:barcode,:category,
                        :manufacturer,:owner,:date_of_reception,:location,
                        :catergory,:project_name]
      @status_fields = [:message,:reason,:owner,:location,:storage_code,
                        :item_condition]
    end
  end

  def edit
    if request.post?
      item=Item.find(params[:id])
      if item and item.update_attributes(params[:item])
        flash[:notice] = "Item updated successfully."
        redirect_to root_path
      else
        flash[:error] = "Item updating failed."
      end
    else
      @item_fields = [:name,:model,:serial_number,:barcode,:category,:manufacturer]
      @item=Item.find(params[:id])
    end if params[:id]
  end

  def find
    if request.post?
      query=params[:item][:query] if params[:item][:query]
      @items=Item.find(:all,
        :conditions=>[
          "name LIKE  ? OR model LIKE ? OR category LIKE ? OR serial_number LIKE ?",
          "%#{query}%","%#{query}%","%#{query}%","%#{query}%"
        ]
      )
      if @items.empty?
        flash[:notice]="#{query} not found."
      elsif @items.one?
        redirect_to item_path(:show,@items.first)
      else
        redirect_to item_path(:list,@items)
      end
    end
  end

  def list
    if params[:id]
      item_ids=params[:id].split('/')
      @items=Item.find(item_ids)
    else
      @items=Item.find(:all,:order=>"name")
    end

    @items = [] if @items.nil?
  end

  def show
    if params[:id]
      id=params[:id].to_s
      @item=Item.find(id,:include=>:statuses)
      session[:item_id]=@item.id

      if @item.statuses
        @item_status = @item.statuses.last
        @x_user_id = @item.statuses.last.user_id
        #raise @item_status.user.username
        #@item_status.user = User.find(@x_user_id).username
        #raise @item_status.user_id.to_s
      else
        @item_status = nil
      end
      @tasks=[
        ["Edit", item_path(:edit,@item)],
        ["Incoming", track_path(:in,@item)],
        ["Outgoing", track_path(:out,@item)],
        ["DashBoard",main_path(:index)]
      ]
    end
  end
  def in
    if request.post?
      if params[:status]
        # section: edited
        params[:status][:item_id] = params[:id]
        params[:status][:user_id] = session[:user_id]
        # end of section
         #raise session[:user_id].to_s
        #check if the item exists
        @item  = Item.find(params[:status][:item_id])
        status = Status.new#(params[:status])
        status.item_id = session[:item_id]
        status.message = "item in"
        if status.save && @item
          flash[:notice] = "Item successfully recorded as 'in'."
          session[:item_id] = nil
          redirect_to root_path
        else
          flash[:error]="recording item status failed."
        end
      elsif params[:item][:barcode]
        @item = Item.find_by_barcode(params[:item][:barcode])
        if @item
          @status_fields = [:reason,:storage_code,:item_condition]
          session[:item_id] = @item.id
        else
          flash[:notice] = "Item not found. Please Register it."
        end
      end
    elsif params[:id]
      @item=Item.find(params[:id])
      if @item
        @status_fields = [:reason,:storage_code,:item_condition]
        session[:item_id]=@item.id
      else
        flash[:notice]="Item not found. Please Register it."
      end
    end
  end
  
  ######################################################
  # Change:   added the "edited" section
  # Reason:   resolve this bug "Couldn't find Item without an ID"
  # Solution: set the "id" to "status.item_id"
  # Author:   Edmond Kachale on 30 July 2009
  ######################################################
   def out
    if request.post?
      if params[:status]

        # section: edited 
        params[:status][:item_id] = params[:id]
        params[:status][:user_id] = session[:user_id]
        # end of section
        
        #check if the item exists
        @item  = Item.find(params[:status][:item_id])
        status = Status.new(params[:status])
        status.item_id = session[:item_id]
        status.message = "item out"
        if status.save && @item
          flash[:notice] = "Item successfully recorded as 'out'."
          redirect_to root_path
        else
          flash[:error]="recording item status failed."
        end
      elsif params[:item][:barcode]
        @item=Item.find_by_barcode(params[:item][:barcode])
        if @item
          @status_fields = [:reason,:owner,:location]
        else
          flash[:notice]="Item not found. Please Register it."
          redirect_to item_path(:new)
        end
      end
    elsif params[:id]
      @status_fields = [:reason,:owner,:location]
      @item=Item.find(params[:id])
    end
  end
end
