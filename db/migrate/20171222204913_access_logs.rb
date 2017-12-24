class AccessLogs < ActiveRecord::Migration[5.1]
  def self.up
    create_table :access_logs do |t|
      t.belongs_to :user, index: true
      t.column :user_name, :string, :null => false
      t.column :event, :string, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :emails
  end
end