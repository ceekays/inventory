pdf.text " Baobab Health Trust ", :size => 17, :style => :bold, :align => :left
pdf.move_down 5
pdf.text "Current Stock List ", :size => 13, :style => :bold, :align => :left
pdf.move_down 5
pdf.text "Period:  From #{@start_date} To : #{@end_date}"

pdf.move_down 10

items = @stocklist.each.map do |data_row|
  [
    data_row.name,
    data_row.model,
    data_row.serial_number,
    data_row.category,
    data_row.manufacturer,
    data_row.date_of_reception,
    data_row.project_name,
    data_row.donor,
    data_row.location,
    data_row.message,
    data_row.supplier
  ]
end

pdf.table items,  :border_style     => :grid, 
                  :headers          => ["Name","Model","S.No","Category","Manufacturer","Date Of Registration",
                                        "Project Name","Donor","Location","Status","Supplier"]
