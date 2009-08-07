class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :name
      t.string :model
      t.string :serial_number
      t.string :barcode
      t.string :category
      t.string :manufacturer
      t.string :owner
      t.string :date_of_reception
      t.string :location
      t.string :project_name

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
