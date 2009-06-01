class DefaultData < ActiveRecord::Migration
  def self.up
    i=Item.new(:name=>"Nokia Cellphone",:model=>"Nokia 6030",:manufacturer=>"Nokia Inc.", :type=>"Cellphone")
    i.statuses<<Status.new(:message=>"item in",:reason=>"Deployment",:owner=>"Kondwani")
    i.save
    Role.create(:role=>"admin",:description=>"Super User")
    Role.create(:role=>"normal",:description=>"Ordinary User")
  end

  def self.down
    Item.find(:first).destroy
    Status.find(:first).destroy
    Role.find(:first).destroy
    Role.find(:first).destroy
  end
end
