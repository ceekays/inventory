class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :name
      t.string :model
      t.string :serial_number
      t.string :barcode
      t.string :category
      t.string :manufacturer
      t.string :date_of_reception
      t.string :location
      t.string :project_name
      t.string :donor
      t.string :supplier
      t.integer :created_by
      t.integer :updated_by
      t.integer :voided
      t.integer :voided_by
      t.text  :void_reason

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
