class Status < ActiveRecord::Base
  belongs_to :item
  belongs_to :user

  def who_updated
    @id = self.updated_by
    last_user_to_update = User.find(@id).name rescue "Uknown" 
    return (last_user_to_update)
  end

  def void
    return false if(self.voided == 1)
    self.update_attribute(:voided,1)
  end
end
