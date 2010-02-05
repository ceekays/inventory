class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string  :first_name
      t.string  :last_name
      t.string  :username
      t.string  :encrypted_password
      t.string  :salt
      t.integer :role, :references => :roles
      t.integer :created_by
      t.integer :updated_by
      t.integer :voided
      t.integer :voided_by
      t.text  :void_reason
      
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
