class Status < ActiveRecord::Base
  belongs_to :item
  belongs_to :user

  def who_updated
    @id = self.updated_by
    last_user_to_update = User.find(@id)
    return (last_user_to_update.first_name.to_s + " " + last_user_to_update.last_name.to_s)
  end

end
