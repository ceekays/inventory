class Status < ActiveRecord::Base
  belongs_to :item
  belongs_to :user

  def who_updated
    @id = self.updated_by
    return User.find(@id).username
  end

end
