class Item < ActiveRecord::Base
  has_many :statuses
  before_create :bar_code
  def print_label(num = 1)
    # item_name
    # serial_number
    # assigned_to
    # barcode


    label = ZebraPrinter::StandardLabel.new
	  label.draw_barcode(40, 180, 0, 1, 5, 15, 120, true, "#{self.barcode}")
	  label.draw_text("Name: #{self.name.titleize}", 40, 30, 0, 2, 2, 2, false)
	  label.draw_text("Serial Number: #{self.serial_number}", 40, 80, 0, 2, 2, 2, false)
	  #label.draw_text("Collected y: #{self.collected_by rescue ''}", 40, 130, 0, 2, 2, 2, false)
	  label.print(num)
  end

  def bar_code
    if (self.barcode.blank? || self.barcode.nil?)
      create_barcode
    else
       self.barcode
    end
  end

  def formatted_bar_code
     self.barcode[0..2]+"-"+self.barcode[3..5]+"-"+self.barcode[6..8]
  end

  def create_barcode
    last_item     = Item.find(:first,:order=>"barcode desc")
    last_barcode  = last_item.barcode rescue "0"
    new_barcode   = (last_barcode[3..-2].to_i + 1).to_s.rjust(5,"0")
    check_digit   = calculate_checkdigit(new_barcode)
    new_barcode   = "BHT#{new_barcode}#{check_digit}"
    self.barcode  = new_barcode
  end

  def calculate_checkdigit(number)
    # This is Luhn's algorithm for checksums
    # http://en.wikipedia.org/wiki/Luhn_algorithm
    number = number.to_s
    number = number.split(//).collect { |digit| digit.to_i }
    parity = number.length % 2

    sum = 0
    number.each_with_index do |digit,index|
      digit = digit * 2 if index%2==parity
      digit = digit - 9 if digit > 9
      sum = sum + digit
    end

    checkdigit = 0
    checkdigit = checkdigit +1 while ((sum+(checkdigit))%10)!=0
    return checkdigit
  end

  def self.collect(query)
    self.find(:all,
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
  end

  def self.search_all()
    
  end
end
