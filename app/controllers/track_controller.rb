class TrackController < ApplicationController
  def item_in
    if request.post?
      if params[:status]
        status=Status.new(params[:status])
        status.item_id=session[:item_id]
        status.message="item in"
        if status.save
          flash[:notice]="Item successfully recorded as 'in'."
          session[:item_id]=nil
          redirect_to root_path
        else
          flash[:error]="recording item status failed."
        end
      elsif params[:item][:barcode]
        @item=Item.find_by_barcode(params[:item][:barcode])
        if @item
          @status_fields = [:reason,:storage_code]
          session[:item_id]=@item.id
        else
          flash[:notice]="Item not found. Please Register it."
        end
      end
    elsif params[:id]
      @item=Item.find(params[:id])
      if @item
        @status_fields = [:reason,:storage_code]
        session[:item_id]=@item.id
      else
        flash[:notice]="Item not found. Please Register it."
      end
    end
  end

  def item_out
    if request.post?
      if params[:status]
        @item=Item.find(params[:item][:id])
        status=Status.new(params[:status])
        status.message="item out"
        item.statuses << status
        if @item.save
          flash[:notice]="#{@item.name} recorded as 'out'."
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
