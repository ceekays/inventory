class CreateDefaultData < ActiveRecord::Migration
  def self.up
    i=Item.new(:name=>"Nokia Cellphone",:model=>"Nokia 6030",:manufacturer=>"Nokia Inc.", :type=>"Cellphone")
    i.statuses<<Status.new(:message=>"item in",:reason=>"Deployment",:owner=>"Kondwani")
    i.save
    i=Item.new(:name=>"Head Phone",:model=>"Nokia 6030",:manufacturer=>"Nokia Inc.", :type=>"Cellphone")
    i.statuses<<Status.new(:message=>"item in",:reason=>"Deployment",:owner=>"Kondwani")
    i.save
    Role.create(:role=>"admin",:description=>"Super User")
    Role.create(:role=>"normal",:description=>"Ordinary User")

    User.create(:username =>"ceekays",:first_name =>"Edmond",
                :role => Role.find(1), :last_name =>"Kachale",
                :password =>"test", :password_confirmation =>"test")

    User.create(:username =>"mile",:first_name =>"Kondwani",
                :role => Role.find(1), :last_name =>"Hara",
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
