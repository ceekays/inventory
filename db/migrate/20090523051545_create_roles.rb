class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string  :role
      t.string  :description
      t.integer :created_by
      t.integer :updated_by
      t.integer :voided
      t.integer :voided_by
      t.text  :void_reason

      t.timestamps
    end
  end
#execute "alter table roles add constraint fk_roles_users_creator foreign key (created_by) references users(id)"

  #execute "alter table roles add constraint fk_roles_users_updator foreign key (updated_by) references users(id)"

  def self.down
    drop_table :roles
  end
end
