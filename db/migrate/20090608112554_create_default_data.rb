class CreateDefaultData < ActiveRecord::Migration
  def self.up
   # create user roles
    Role.create(:role=>"admin",:description=>"super user")
    Role.create(:role=>"normal",:description=>"ordinary user")
    
   #create users
   User.create(:username =>"ceekays",:first_name =>"Edmond",
                :role => Role.find(1).role, :last_name =>"Kachale",  # role == admin
                :password =>"test", :password_confirmation =>"test")

    User.create(:username =>"mile",:first_name =>"Kondwani",
                :role => Role.find(1).role, :last_name =>"Hara",     # role == admin
                :password =>"test", :password_confirmation =>"test")
    
    # create new items, a and b
    a=Item.new(:name=>"Nokia Cellphone",:model=>"Nokia 6030",:manufacturer=>"Nokia Inc.",
               :owner => "Kondwani Hara",:date_of_reception =>Time.now,:location => "BHT",
               :barcode =>"unknown",:serial_number => "unknown",
               :category => "Laptop",:project_name => "Baobab")
             
    b=Item.new(:name=>"Laptop",:model=>"VGN-NS240E",:manufacturer=>"Sony",
               :owner => "Edmond Kachale",:date_of_reception =>Time.now,:location => "BHT",
               :barcode => "00148-119-342-925",:serial_number => "2828-4933-3034-122",
               :category => "Laptop",:project_name => "Baobab")
    
    # create status
    a.statuses<<Status.new(:message=>"new", :reason=>"deployed", :owner=>"Kondwani", :user_id => "2")
    b.statuses<<Status.new(:message=>"new",:reason=>"deployed",:owner=>"Ceekays", :user_id => "1")

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
