
pdf.text " Baobab Health Trust ", :size => 17, :style => :bold, :align => :left
pdf.move_down 5
pdf.text " Label Activity Report ", :size => 13, :style => :bold, :align => :left
pdf.move_down 5
pdf.text "Period:  From #{@start_date} To : #{@end_date}"

pdf.move_down 10

items = @stock_activity_list.each.map do |data_row|
  [
    data_row.value_datetime,
    data_row.location,
    data_row.dispatcher,
    data_row.Quantity
  ]
end

pdf.table items,  :border_style => :grid, 
                  :headers      => ["Date","Location","Dispatcher","Quantity"]
pdf.move_down 10

