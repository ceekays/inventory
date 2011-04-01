class ReportsController < ApplicationController
   before_filter :authorize, :except   => [:login, :logout, :get_layout]

   def render_item_menu
     @tasks=[
       ["Current Stock List", reports_path(:current_stock)],
       ["Labels", reports_path(:labels_index)],
       ["Ribbons", reports_path(:ribbons_index)],
       ["Specimen Labels", reports_path(:specimen_labels_index)],
       ["Item Management",main_path(:items)],
       ["Main Dashboard",main_path(:index)]
     ]
   end

   def index
     render_item_menu
   end

   def labels_index
     @tasks=[
       ["Label Analysis", reports_path(:select_date_range, :report_name=> "labels_analysis")],
       ["Label Activity", reports_path(:select_date_range, :report_name=> "labels_activity")],
       ["Reports List", reports_path(:index)],
       ["Item Management",main_path(:items)],
       ["Main Dashboard",main_path(:index)]
     ]
   end

   def ribbons_index
     @tasks=[
       ["Ribbon Analysis", reports_path(:select_date_range, :report_name=> "ribbons_analysis")],
       ["Ribbon Activity", reports_path(:select_date_range, :report_name=> "ribbons_activity")],
       ["Reports List", reports_path(:index)],
       ["Item Management",main_path(:items)],
       ["Main Dashboard",main_path(:index)]
     ]
   end

   def specimen_labels_index
     @tasks=[
       ["Specimen Label Analysis", reports_path(:select_date_range, :report_name=> "specimen_labels_analysis")],
       ["Specimen Label Activity", reports_path(:select_date_range, :report_name=> "specimen_labels_activity")],
       ["Reports List", reports_path(:index)],
       ["Item Management",main_path(:items)],
       ["Main Dashboard",main_path(:index)]
     ]
   end

   def select_date_range

     donor_based_reports = ["labels_analysis","specimen_labels_analysis","ribbons_analysis",
                           "labels_activity","specimen_labels_activity","ribbons_activity"]

     @report_type  = params[:report_name]
     start_date  = Item.first.created_at.to_date
     end_date    = Date.today
     @funders    = Report.generate_donors if donor_based_reports.include? @report_type

     @reports_range = Report.generate_report_quarters(start_date, end_date)

   end

   def report_lists
     report_name  = params[:report_name]

     case report_name
       when "specimen_labels_analysis"
            redirect_to :controller     => :reports,
                         :action         => :specimen_labels_analysis,
                         :report_quarter => params[:report_quarter],
                         :funder         => params[:funder]
           return

       when  "specimen_labels_activity"
           redirect_to :controller     => :reports,
                       :action         => :specimen_labels_activity,
                       :report_quarter => params[:report_quarter],
                       :funder         => params[:funder]
       return

       when "ribbons_analysis"
            redirect_to :controller     => :reports,
                         :action         => :ribbons_analysis,
                         :report_quarter => params[:report_quarter],
                         :funder         => params[:funder]
       return

       when "ribbons_activity"
           redirect_to :controller     => :reports,
                       :action         => :ribbons_activity,
                       :report_quarter => params[:report_quarter],
                       :funder         => params[:funder]
       return

       when "labels_analysis"
           redirect_to :controller     => :reports,
                       :action         => :labels_analysis,
                       :report_quarter => params[:report_quarter],
                       :funder         => params[:funder]
       return

       when "labels_activity"
           redirect_to :controller     => :reports,
                       :action         => :labels_activity,
                       :report_quarter => params[:report_quarter],
                       :funder         => params[:funder]
       return
     end
   end

   #
   # Analysis Reports
   #

   def labels_analysis
     donor      = params[:funder]
     date_range  = Report.generate_report_date_range(params[:report_quarter])
     @start_date  = date_range.first
     @end_date    = date_range.last
     item_to_search_for = 'labels'
     #used the common methods to get the below data
     @total_items_in = Report.get_item_analysis_total(@start_date, @end_date, item_to_search_for, donor)
     @Stock_distribution_list  = Report.return_item_analysis(@start_date,@end_date,item_to_search_for, donor)

     respond_to do |format|
       format.html # index.html.erb
       format.xml
       format.pdf
     end
   end

   def current_stock
      prawnto :prawn => {:page_layout => :landscape, :font_size => 8 }
      @stocklist = Report.current_stock

     respond_to do |format|
       format.html # index.html.erb
       format.xml {render :xml => @stock_activity_list}
       format.pdf {render :layout => false}
     end
   end

   def ribbons_analysis
     donor      = params[:funder]
     date_range  = Report.generate_report_date_range(params[:report_quarter])
     @start_date  = date_range.first
     @end_date    = date_range.last
     item_to_search_for = 'ribbons'
     #used the common methods to get the below data
     @total_items_in = Report.get_item_analysis_total(@start_date, @end_date, item_to_search_for, donor)
     @Stock_distribution_list  = Report.return_item_analysis(@start_date,@end_date,item_to_search_for, donor)

     respond_to do |format|
       format.html # index.html.erb
       format.xml {render :xml => @stock_activity_list}
       format.pdf {render :layout => false}
     end
   end

   def specimen_labels_analysis
     donor      = params[:funder]
     date_range  = Report.generate_report_date_range(params[:report_quarter])
     @start_date  = date_range.first
     @end_date    = date_range.last
     item_to_search_for = 'specimen_labels'
     #used the common methods to get the below data
     @total_items_in = Report.get_item_analysis_total(@start_date, @end_date, item_to_search_for, donor)
     @Stock_distribution_list  = Report.return_item_analysis(@start_date,@end_date,item_to_search_for, donor)

     respond_to do |format|
       format.html # index.html.erb
       format.xml {render :xml => @stock_activity_list}
       format.pdf {render :layout => false}
     end
   end

   #
   # Activity Reports
   #

   def labels_activity

     donor         = params[:funder]
     date_range    = Report.generate_report_date_range(params[:report_quarter])
     @start_date  = date_range.first
     @end_date    = date_range.last
     item_to_search_for = 'labels'

     @stock_activity_list = Report.return_item_activity(@start_date, @end_date, item_to_search_for, donor)

     respond_to do |format|
       format.html # index.html.erb
       format.xml {render :xml => @stock_activity_list}
       format.pdf {render :layout => false}
     end
   end

   def ribbons_activity
     donor         = params[:funder]
     date_range    = Report.generate_report_date_range(params[:report_quarter])
     @start_date  = date_range.first
     @end_date    = date_range.last
     item_to_search_for = 'ribbons'

     @stock_activity_list = Report.return_item_activity(@start_date, @end_date, item_to_search_for, donor)

     respond_to do |format|
       format.html # index.html.erb
       format.xml {render :xml => @stock_activity_list}
       format.pdf {render :layout => false}
     end
   end

   def specimen_labels_activity
     donor         = params[:funder]
     date_range    = Report.generate_report_date_range(params[:report_quarter])
     @start_date  = date_range.first
     @end_date    = date_range.last
     item_to_search_for = 'specimen_labels'

     @stock_activity_list = Report.return_item_activity(@start_date, @end_date, item_to_search_for, donor)

     respond_to do |format|
       format.html # index.html.erb
       format.xml {render :xml => @stock_activity_list}
       format.pdf {render :layout => false}
     end
   end

 end

