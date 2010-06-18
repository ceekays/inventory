class ItemController < ApplicationController
  before_filter :authorize, :except   => [:login, :logout, :get_layout]
  def render_item_menu
    @tasks=[
      ["Generate Reports",item_path(:report)],
      ["Item Management",main_path(:items)],
      ["Main Dashboard",main_path(:index)]
    ]
    
    if @tasks && session[:user_id]
    @tasks<<["Logout", user_path(:logout)]
    else
      @tasks<<["Login", user_path(:login)]
    end
  end

  def new
    render_item_menu
    if request.post?
      item=Item.new(params[:item]) if params[:item]
      item.created_by = session[:user_id]
      item.updated_by = session[:user_id]
      
      if item.save
        params[:status][:storage_code]  = item.barcode
        params[:status][:item_id]       = item.id
        params[:status][:voided]        = 0
        params[:status][:created_by]    = session[:user_id]
        params[:status][:updated_by]    = session[:user_id]

        status=Status.new(params[:status]) if params[:status]

        status.save

        params[:id] = item.id
        flash[:notice] = "Item registration successful."
        print_and_redirect("/item/printlabel/#{item.id}",item_path(:show,item))
      else
        flash[:error] = "Item registration failed."
      end
    else
      @item_fields   = [:name, :model, :serial_number, :category,
                        :manufacturer, :project_name, :donor, :supplier]

      @status_fields = [:date_of_reception, :quantity, :delivered_by,
                        :regstration_location,:item_condition]
    end
  end

  def edit
    render_item_menu
    if request.post?
      item=Item.find(params[:id])
      if item and item.update_attributes(params[:item])
        flash[:notice] = "Item updated successfully."
        redirect_to root_path
      else
        flash[:error] = "Item updating failed."
      end
    else
      #@item_fields = [:name,:model,:serial_number,:barcode,:category,:manufacturer]
      @item_fields   = [:name,:model,:serial_number,:barcode,:category,
                        :manufacturer,:quantity, :collected_by,:date_of_reception,:location,
                        :catergory,:project_name]
      @item=Item.find(params[:id])
    end if params[:id]
  end

  def find
    render_item_menu
    if request.post?
      query=params[:item][:query] if params[:item][:query]
      @items=Item.find(:all,
        :conditions=>[
          "name like  ? OR model like ? OR category like ?
          OR serial_number like ? OR barcode like ?
          OR manufacturer like ? OR location like ? OR project_name like ?
          OR donor like ? OR supplier like ?",
          "%#{query}%","%#{query}%","%#{query}%","%#{query}%",
          "%#{query}%","%#{query}%","%#{query}%","%#{query}%",
          "%#{query}%","%#{query}%"
        ]
      )
      if @items.empty?
        flash[:notice]="#{query} not found."
        redirect_to main_path(:items)
      elsif @items.many?
        redirect_to item_path(:list,@items)
      else
        redirect_to item_path(:show,@items.first)
      end
    end
  end

  def list
    render_item_menu
    if params[:id]
      item_ids=params[:id].split('/')
      @items=Item.find(item_ids)
    else
      @items=Item.find(:all,:order=>"name")
    end

    @items = [] if @items.nil?
  end

  def show
    render_item_menu

    if params[:id]
      id=params[:id].to_s
      @item=Item.find(id,:include=>:statuses)
      session[:item_id]=@item.id

      if @item.statuses
        @item_status = @item.statuses.last
      else
        @item_status = nil
      end
    end

      if @tasks
        @tasks<< ["Edit", item_path(:edit,@item)]
        @tasks<< ["Incoming", track_path(:in,@item)]
        @tasks<< ["Outgoing", track_path(:out,@item)]
        @tasks<< ["Print Label", track_path(:printlabel,@item)]
      end

  end

def in
     render_item_menu
   if params[:id]
      @status_fields = [:reason, :date_of_reception, :quantity,
                        :collected_by, :regstration_location]
      @item=Item.find(params[:id])
   elsif request.get?
    if params[:barcode]

        @item=Item.find_by_barcode(params[:barcode])
        if @item
          redirect_to item_path(:in, @item) and return
        else
          flash[:notice]="The item is not found. Please Register it."
          redirect_to main_path(:items) and return
        end
      end
    end

  render :layout => "barcodelayout" unless @item
  end
  
  ######################################################
  # Change:   added the "edited" section
  # Reason:   resolve this bug "Couldn't find Item without an ID"
  # Solution: set the "id" to "status.item_id"
  # Author:   Edmond Kachale on 30 July 2009
  ######################################################
   def out
     render_item_menu
   if params[:id]
      #@status_fields = [:reason,:quantity, :date_dispatched, :collected_by,:location, :out]
      @status_fields = [:reason, :date_dispatched, :quantity,
                        :delivered_by, :destination]
      @item=Item.find(params[:id])
   elsif request.get?
    if params[:barcode]
        
        @item=Item.find_by_barcode(params[:barcode])
        if @item
          redirect_to item_path(:out, @item) and return
        else
          flash[:notice]="The item (<i>barcode: #{params[:barcode]}</i>) is not found. Please Register it."
          redirect_to main_path(:items) and return
        end
      end
    end

  render :layout => "barcodelayout" unless @item
  end

    def report
      render_item_menu

      #void a give status of an item
      if (params[:void] && params[:void]== "true")
        status = Status.find(params[:id]) rescue nil
        if(status)
          if(status.void)
            flash[:notice] = "<font color='green'> <b>The status was voided successfully.</b></font>"
          end
        else
          flash[:error] = "Item failed to be voided."
        end
        params.delete(:void)
      end

      if params[:query]
        query = params[:query].to_s
        if query == ""
          flash[:msg_on_item] = "That item does not exist in the database"
          return
        else
          @item_id=Item.find(:all,
      :conditions=>[
        "name like  ? OR model like ? OR category like ?
        OR serial_number like ? OR barcode like ?
        OR manufacturer like ?
        OR location like ? OR project_name like ?",
        "%#{query}%","%#{query}%","%#{query}%","%#{query}%",
        "%#{query}%","%#{query}%","%#{query}%","%#{query}%"
      ]).first.id
          @item=Item.find(@item_id,:include=>:statuses)
        end

        if !@item
          flash[:msg_on_item] = "There are no items in the database"
          return
        end
        session[:item_id]=@item.id

        if (@item.statuses.nil? || @item.statuses.empty?)
          flash[:msg_on_item_status] = "There are no statuses for this item"
          return
        elsif (@item.statuses)
          @item_statuses = @item.statuses.find(:all, :conditions => ["voided = 0"])
        else
          @item_status = nil
        end
        @tasks=[
          ["Edit", item_path(:edit,@item)],
          ["Incoming", track_path(:in,@item)],
          ["Outgoing", track_path(:out,@item)],
          ["Item Management",main_path(:items)],
          ["Main Dashboard",main_path(:index)]
        ]
    end
      
  end
  def report_list
    render_item_menu
    if request.post?
      query=params[:item][:query] if params[:item][:query]
      @item=Item.find(:all,
        :conditions=>[
          "name like  ? OR model like ? OR category like ?
          OR serial_number like ? OR barcode like ?
          OR manufacturer like ?
          OR location like ? OR project_name like ?",
          "%#{query}%","%#{query}%","%#{query}%","%#{query}%",
          "%#{query}%","%#{query}%","%#{query}%","%#{query}%"
        ]
      )
      if @item.empty?
        flash[:notice]="#{query} not found."
      elsif @item.many?
        redirect_to item_path(:list,@item)
      else
        redirect_to item_path(:report,@item.first)
      end
    end
  end

    def printlabel
      item = Item.find(params[:id])
      send_data(item.print_label, :type=> "application/label; charset=utf-8", :stream=> false, :filename=>"#{item.id}#{rand(10000)}.lbl", :disposition => 'inline')
    end

    def save

      params[:status][:voided]        = 0
      params[:status][:item_id]       = params[:id]
      params[:status][:message]       = params[:message]
      params[:status][:created_by]    = session[:user_id]
      params[:status][:updated_by]    = session[:user_id]

      #check if the item exists
      @item  = Item.find(params[:status][:item_id])
      status = Status.new(params[:status])
      status.item_id = session[:item_id]
     
      if status.save && @item
        flash[:notice] = "<b>New item status has been  recorded. </b><br>"
        redirect_to item_path(:show,@item)
      else
        flash[:error]="recording item status failed."
      end
    end
end
