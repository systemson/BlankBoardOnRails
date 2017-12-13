class Users < ActiveRecord::Migration[5.1]
  def self.up
    create_table :users do |t|

      t.column :user, :string, :null => false
      t.column :name, :string, :null => false
      t.column :last_name, :string
      t.column :email, :string, :null => false
      t.column :password_digest, :string, :null => false
      t.column :status, :integer, :default => 1, :null => false
      t.column :image, :string
      t.column :description, :text
      t.column :last_login, :datetime
      t.column :remember_token, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end

end
