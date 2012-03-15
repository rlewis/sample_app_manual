class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :email

      t.timestamps #creates two magic columns called created_at and updated_at
    end
  end

  def self.down
    drop_table :users
  end
end
