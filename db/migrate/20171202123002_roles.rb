class Roles < ActiveRecord::Migration[5.1]
  def self.up
    create_table :roles do |t|

      t.column :name, :string, :null => false
      t.column :slug, :string, :null => false
      t.column :description, :text
      t.column :status, :integer, :default => 1, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :roles
  end
end
