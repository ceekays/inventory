class CreateDefaultData < ActiveRecord::Migration
  def self.up
    i=Item.new(:name=>"Nokia Cellphone",:model=>"Nokia 6030",:manufacturer=>"Nokia Inc.", :type=>"Cellphone")
    i.statuses<<Status.new(:message=>"item in",:reason=>"Deployment",:owner=>"Kondwani", :user_id => "2")
    i.save
    i=Item.new(:name=>"Head Phone",:model=>"Panasonic",:manufacturer=>"Panasonic", :type=>"Headphone")
    i.statuses<<Status.new(:message=>"item in",:reason=>"Deployment",:owner=>"Ceekays", :user_id => "1")
    i.save
    Role.create(:role=>"admin",:description=>"Super User")
    Role.create(:role=>"normal",:description=>"Ordinary User")

    User.create(:username =>"ceekays",:first_name =>"Edmond",
                :role => Role.find(1), :last_name =>"Kachale",  # role == admin
                :password =>"test", :password_confirmation =>"test")

    User.create(:username =>"mile",:first_name =>"Kondwani",
                :role => Role.find(1), :last_name =>"Hara",     # role == admin
                :password =>"test", :password_confirmation =>"test")
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
