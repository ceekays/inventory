
pdf.text " Baobab Health Trust ", :size => 17, :style => :bold, :align => :left
pdf.move_down 5
pdf.text " Label Analysis Report ", :size => 13, :style => :bold, :align => :left
pdf.move_down 5
pdf.text "Period:  From #{@start_date} To : #{@end_date}"

pdf.move_down 10

items = @Stock_distribution_list.each.map do |data_row|
  [
    data_row.location,
    data_row.amount
  ]
end

pdf.table items,  :border_style => :grid, 
                  :headers      => ["Name","Amount"]
pdf.move_down 10

pdf.text "Total Items in for the period: #{@total_items_in}"

