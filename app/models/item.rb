class Item < ActiveRecord::Base
  has_many :statuses

  def print_label(num = 1)
    # item_name
    # serial_number
    # assigned_to
    # barcode


    label = ZebraPrinter::StandardLabel.new
	  label.draw_barcode(40, 180, 0, 1, 5, 15, 120, true, "#{self.barcode}")
	  label.draw_text("Name: #{self.name.titleize}", 40, 30, 0, 2, 2, 2, false)
	  label.draw_text("Serial Number: #{self.serial_number}", 40, 80, 0, 2, 2, 2, false)
	  label.draw_text("Assigned to: #{self.assigned_to}", 40, 130, 0, 2, 2, 2, false)
	  label.print(num)
  end
end
