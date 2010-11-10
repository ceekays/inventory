class Item < ActiveRecord::Base
  has_many :statuses
  before_create :bar_code
  def print_label(num = 1)
    # item_name
    # serial_number
    # assigned_to
    # barcode


    label = ZebraPrinter::StandardLabel.new
    label.font_size = 1
    label.font_horizontal_multiplier = 2
    label.font_vertical_multiplier = 2
    label.left_margin = 50
	  label.draw_text("Name: #{self.name.titleize}", 40, 30, 0, 1, 2, 2, false)
	  label.draw_text("Serial #: #{self.serial_number}", 40, 80, 0, 1, 2, 2, false)
    label.draw_barcode(40, 120, 0, 1, 5, 15, 120, true, "#{self.barcode}")
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
      digit = digit * 2 if (index % 2 == parity)
      digit = digit - 9 if digit > 9
      sum = sum + digit
    end

    checkdigit = 0
    checkdigit = checkdigit + 1 while ((sum +(checkdigit)) % 10)!= 0
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

  # generate a random serial code from a given set of characters
  # we are taking out the following letters B, I, O, Q, S, Z
  # because the might be mistaken for 8, 1, 0, 0, 5, 2 respectively
  def self.generate_serial_code
    base = ["0","1","2","3","4","5","6","7","8","9","A","C","D","E","F",
            "G","H","J","K","L","M","N","P","R","T","U","V","W","X","Y"]
    (1..8).collect { base[rand(base.size)] }.to_s
  end

  def self.print_serial_codes(data)

    label = ZebraPrinter::StandardLabel.new
    label.font_size = 1
    label.font_horizontal_multiplier = 2
    label.font_vertical_multiplier = 2
    label.left_margin = 50

    y_axis = 50

    lines = data.count/2 #summing it is even

    lines.times do |i|
      #label.draw_text("#{data[i]}", 100,  y_axis, 0, 1, 2, 2, false)
      #label.draw_text("#{data[(i+2)]}", 3000, y_axis, 0, 1, 2, 2, false)
      label.draw_barcode(100,  y_axis, 0, 1, 2, 4, 40, true, "#{data[i]}")
      label.draw_barcode(2880, y_axis, 0, 1, 2, 4, 40, true, "#{data[i+2]}")
      y_axis += 150
    end

	  label.print(1)
  end
end
