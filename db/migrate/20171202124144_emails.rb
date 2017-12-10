class Emails < ActiveRecord::Migration[5.1]
  def self.up
    create_table :emails do |t|
      t.belongs_to :user, index: true
      t.column :user_id, :integer, :null => false
      t.column :subject, :string, :null => false
      t.column :body, :longtext
      t.column :status, :integer, :default => 1, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :emails
  end
end
