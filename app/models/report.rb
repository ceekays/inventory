class Report < ActiveRecord::Base
set_table_name "items"

  def self.current_stock
    stock_list = Item.find(:all,
                           :joins =>
                                        "INNER JOIN statuses S ON
                                          items.id = S.item_id",
                           :group =>    "items.serial_number",
                           :order =>    "items.name",
                           :select => "items.name, items.model, max(S.id), items.serial_number, items.category, items.manufacturer, items.date_of_reception, items.project_name, items.donor, S.location, S.message, items.supplier"
                          )

  end
  
  def self.generate_report_quarters(start_date, end_date)
    
    report_quarters   = []
    current_quarter   = ""
    #quarter_end_dates = ["#{end_date.year}-03-31".to_date, "#{end_date.year}-06-30".to_date, "#                             {end_date.year}-09-30".to_date, "#{end_date.year}-12-31".to_date]
    quarter_end_dates = ["#{end_date.year}-03-31".to_date, "#{end_date.year}-06-30".to_date, "#{end_date.year}-09-30".to_date, "#{end_date.year}-12-31".to_date]
    quarter_end_dates.each_with_index do |quarter_end_date, quarter|
      (current_quarter = (quarter + 1) and break) if end_date < quarter_end_date
    end

    quarter_number  =  current_quarter
    report_quarters += ["Cumulative"]
    current_date    =  end_date

    begin
      report_quarters += ["Q#{quarter_number} #{current_date.year}"]
      (quarter_number > 1) ? quarter_number -= 1: (current_date = current_date - 1.year and quarter_number = 4)
    end while (current_date.year >= start_date.year)

    report_quarters
    
  end
  
  def self.generate_report_date_range(quarter = "", start_date = nil, end_date = nil)

    quarter_beginning   = start_date.to_date  rescue nil
    quarter_ending      = end_date.to_date    rescue nil
    quarter_end_dates   = []
    quarter_start_dates = []
    date_range          = [nil, nil]

    if(!quarter_beginning.nil? && !quarter_ending.nil?)
      date_range = [quarter_beginning, quarter_ending]
		elsif (!quarter.nil? && quarter == "Cumulative")
      quarter_beginning = Item.first.created_at.to_date
      quarter_ending    = Date.today.to_date

      date_range        = [quarter_beginning, quarter_ending]
		elsif(!quarter.nil? && (/Q[1-4][\_\+\- ]\d\d\d\d/.match(quarter)))
			quarter, quarter_year = quarter.humanize.split(" ")

      quarter_start_dates = ["#{quarter_year}-01-01".to_date, "#{quarter_year}-04-01".to_date, "#{quarter_year}-07-01".to_date, "#{quarter_year}-10-01".to_date]
      quarter_end_dates   = ["#{quarter_year}-03-31".to_date, "#{quarter_year}-06-30".to_date, "#{quarter_year}-09-30".to_date, "#{quarter_year}-12-31".to_date]

      current_quarter   = (quarter.match(/\d+/).to_s.to_i - 1)
      quarter_beginning = quarter_start_dates[current_quarter]
      quarter_ending    = quarter_end_dates[current_quarter]

      date_range = [quarter_beginning, quarter_ending]

    end

    return date_range
  end
  #combined function to return the total items that came in at a particular period
  def self.get_item_analysis_total(start_date,end_date, item_to_look_for, donor)
    search_query = " SELECT SUM(RESULT.quantity) as amount
                     FROM	(
	                     SELECT ITEM.id, ITEM.serial_number, ITEM.category,STATUS.quantity, min(STATUS.id),ITEM.created_at
	                     FROM items ITEM
                      	 	INNER JOIN statuses STATUS
                      		ON ITEM.id = STATUS.item_id
	                     WHERE
                      	 ITEM.donor = '#{donor}' 
		                     AND ITEM.name = '#{item_to_look_for}'
		                     AND ITEM.category = 'Consumables'
		                     AND ITEM.created_at BETWEEN '#{start_date}' AND '#{end_date}'
		                     GROUP BY ITEM.serial_number
	                    ) RESULT
                     "
    
    total_items_in = Item.find_by_sql(search_query).first.amount

  end 

  #combined function to search for the item_analysis
  def self.return_item_analysis(start_date, end_date, item_to_look_for, donor)

      search_query = " SELECT SUM(RESULT.quantity) AS amount, RESULT.location
                       FROM	(
	                       SELECT ITEM.id, ITEM.serial_number, ITEM.category,STATUS.location, SUM(STATUS.quantity) as quantity,ITEM.created_at
	                       FROM items ITEM
                        	 	INNER JOIN statuses STATUS
                        		ON ITEM.id = STATUS.item_id
	                       WHERE
                        		ITEM.donor = '#{donor}' 
		                        AND ITEM.name = '#{item_to_look_for}'
		                        AND STATUS.message not in ('item in')
		                        AND ITEM.category = 'Consumables'
		                        AND STATUS.created_at BETWEEN '#{start_date}' AND '#{end_date}'
		                        GROUP BY STATUS.location
	                      ) RESULT
                       GROUP BY RESULT.location"
        

      stock_distribution_list = Item.find_by_sql(search_query)

  end

  def self.generate_donors  
    result_list = Item.find(:all, :order => "donor", :select => "distinct(donor)")
    result_list.map(&:donor)
  end

  def self.return_item_activity(start_date,end_date,item_category,donor)
    search_query = "SELECT STATUS.value_datetime, STATUS.location, STATUS.dispatcher, STATUS.Quantity
                    FROM items ITEM
	                    INNER JOIN statuses STATUS
	                    ON ITEM.id = STATUS.item_id
                    WHERE STATUS.message not in ('item in')
	                    AND ITEM.donor = '#{donor}'
	                    AND ITEM.name = '#{item_category}'
	                    AND ITEM.category = 'Consumables'
	                    AND STATUS.created_at BETWEEN '#{start_date}' AND '#{end_date}'"

   activity_report = Item.find_by_sql(search_query)
    
  end
  
  end
