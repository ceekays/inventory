class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string  :role
      t.string  :description
      t.int     :created_by
      t.int     :updated_by

      t.timestamps
    end
  end

  def self.down
    drop_table :roles
  end
end
