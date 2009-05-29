class ItemController < ApplicationController
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
      @item_fields = [:name,:model,:serial_number,:barcode,:category,:manufacturer]
      @status_fields = [:message,:reason,:owner,:location,:storage_code]
    end
  end

  def edit
    if request.post?
      item=Item.find(params[:id])
      if item and item.update_attributes(params[:item])
        flash[:notice] = "Item updatingsuccessful."
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

    @items = @items.one? ? @items.first : @items unless @items.empty?
  end

  def show
    if params[:id]
      id=params[:id].to_s
      @item=Item.find(id,:include=>:statuses)
      session[:item_id]=@item.id
      if @item.statuses
        @item_status = @item.statuses.last
      else
        @item_status = nil
      end
      @tasks=[
        ["Edit", item_path(:edit,@item)],
        ["Incoming", track_path(:item_in,@item)],
        ["Outgoing", track_path(:item_out,@item)],
      ]
    end
  end
end
