class ItemController < ApplicationController
  def new
    if request.post?
      item=Item.new(params[:item])
      status=Status.new(params[:status])
      status.message="item in"
      item.statuses << status
      if item.save
        flash[:notice] = "Item registration successful."
        redirect_to root_path
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
    end
  end

  def find
    if request.post?
      query=params[:item][:query]
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
      @items=Item.find(:all,:include=>:statuses)
    end
    @items_opts=@items.collect{|i| ["#{i.name}(Serial Number: #{i.serial_number})",i.id]} if @items
    @tasks=[
        ["Show", item_path(:show,@item)],
        ["Edit", item_path(:edit,@item)],
        ["Incoming", item_path(:item_in,@item)],
        ["Outgoing", item_path(:item_out,@item)],
      ] if @items
  end

  def show
    if params[:id]
      @item=Item.find(params[:id],:include=>:statuses)
      @tasks=[
        ["Show", item_path(:show,@item)],
        ["Edit", item_path(:edit,@item)],
        ["Incoming", item_path(:item_in,@item)],
        ["Outgoing", item_path(:item_out,@item)],
      ]
    end
  end
end
