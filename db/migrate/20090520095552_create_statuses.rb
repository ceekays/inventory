class CreateStatuses < ActiveRecord::Migration
  def self.up
    create_table :statuses do |t|
      t.integer :item_id
      t.string :message
      t.string :reason
      t.string :owner
      t.string :location
      t.string :storage_code
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :statuses
  end
end
