class SearchController < ApplicationController

  #
  # a generic method that searches for a query_string by model and field_name
  # 
  # http://my-domain-name/search/by_model?model=model-name&column=column-name&value=
  #

  def by_model
   
    key = 0
    @options = []
    field_name = []
    @results = []
    while(!params["column"+key.to_s].nil?)

      model            = params["model"+key.to_s].constantize
      field_name[key]  = params["column"+key.to_s]
      query_string     = params[:value]
      
      @results += model.
        find_by_sql("SELECT #{field_name[key]} FROM #{model.table_name} GROUP BY #{field_name[key]}").
        collect{|each|
          @options << "<li>#{(each.instance_variable_get(:@attributes)[field_name[key]]) }</li>"
        }.
        join("\n").
        grep(/#{query_string}/i).
        compact.
        sort_by{|text| 
          text.index(/#{query_string}/i)
        }

      key = key + 1
    end
    
    render :text => @options.delete_if{|string| !(string).match(/#{query_string}/i)}. uniq.sort
  end
end
