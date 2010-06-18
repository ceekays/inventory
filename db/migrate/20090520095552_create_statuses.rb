class CreateStatuses < ActiveRecord::Migration
  def self.up
    create_table :statuses do |t|
      t.integer :item_id
      t.string :message
      t.string :dispatcher
      t.string :value_datetime
      t.string :location
      t.string :storage_code
      t.string :item_condition
      t.integer :quantity
      t.integer :created_by
      t.integer :updated_by
      t.integer :voided
      t.integer :voided_by
      t.text  :void_reason

      t.timestamps
    end
  end

  def self.down
    drop_table :statuses
  end
end
