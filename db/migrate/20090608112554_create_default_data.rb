class CreateDefaultData < ActiveRecord::Migration
  def self.up
   # create user roles
    Role.create(:role=>"admin",:description=>"Super User")
    Role.create(:role=>"normal",:description=>"Ordinary User")
    
   #create users
   User.create(:username =>"ceekays",:first_name =>"Edmond",
                :role => Role.find(:first).id, :last_name =>"Kachale",  # role == admin
                :password =>"test", :password_confirmation =>"test")

    User.create(:username =>"kaytee",:first_name =>"Thummim",
                :role => Role.find(:first).id, :last_name =>"Moya",     # role == admin
                :password =>"test", :password_confirmation =>"test")
    
    # create new items, a and b
    a=Item.new(:name=>"Touchscreen",:model=>"Eye Opener",:manufacturer=>"Eye Opener Inc.",
               :assigned_to => "Samuel Manda",:date_of_reception =>Time.now,
               :location => "Operations Dept.",
               :barcode =>"unknown",:serial_number => "unknown",
               :category => "Touchscreen",:project_name => "Baobab",
               :created_by => "1", :updated_by => "1", :voided => "0")
             
    b=Item.new(:name=>"Sony Laptop",:model=>"VGN-NS240E",:manufacturer=>"Sony",
               :assigned_to => "Edmond Kachale",:date_of_reception =>Time.now,
               :location => "Software Dept.",
               :barcode => "00148-119-342-925",:serial_number => "2828-4933-3034-122",
               :category => "Laptop",:project_name => "Baobab", 
               :created_by => "2", :updated_by => "2", :voided => "0")
    
    # create status
    a.statuses<<Status.new(:message=>"new", :reason=>"deployed", 
              :assigned_to=>"Soyapi", :location => "Software Dept.", 
              :created_by => "2", :updated_by => "2", :voided => "0")
            
    b.statuses<<Status.new(:message=>"new",:reason=>"deployed",
              :assigned_to=>"Ceekays", :location => "Software Dept.",
              :created_by => "1", :updated_by => "1", :voided => "0")

    #save the items
    a.save
    b.save
    

    
  end

  def self.down
    Item.find(:first).destroy
    Item.find(:first).destroy
    Status.find(:first).destroy
    Role.find(:first).destroy
    Role.find(:first).destroy
    User.find(:first).destroy
    User.find(:first).destroy
  end
end
