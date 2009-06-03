class SuggestController < ApplicationController
  def index
    raise "index"
  end
  def items
    if params[:field]
      field=params[:field]
      value=params[:value]
      @items=Item.find_by_sql(["SELECT ? FROM items WHERE ? LIKiE ? ",
        field,field,"%#{value}%"])
      render :text=>@items
    end
  end
  def users
    raise "users"
  end
end
