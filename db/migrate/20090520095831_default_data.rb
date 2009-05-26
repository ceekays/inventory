class DefaultData < ActiveRecord::Migration
  def self.up
    i=Item.new(:name=>"Nokia Cellphone",:model=>"Nokia 6030",:manufacturer=>"Nokia Inc.", :type=>"Cellphone")
    i.statuses<<Status.new(:message=>"item in",:reason=>"Deployment",:owner=>"Kondwani")
    i.save
  end

  def self.down
    i=Item.find_by_name("Nokia Cellphone")
    i.destroy
  end
end
