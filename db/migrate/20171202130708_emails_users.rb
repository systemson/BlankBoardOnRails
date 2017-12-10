class EmailsUsers < ActiveRecord::Migration[5.1]
  def self.up
    create_table :emails_users, id: false do |t|
      t.belongs_to :email, index: true
      t.belongs_to :user, index: true
    end
  end

  def self.down
    drop_table :emails_users
  end
end
