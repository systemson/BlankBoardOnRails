class CreateJoinTableRecipients < ActiveRecord::Migration[5.1]
  def change
    create_table :recipients do |t|
      t.belongs_to :email, index: true
      t.belongs_to :user, index: true
      t.column :status, :integer, :default => 1
      t.column :is_read, :integer, :default => 0
    end
  end
end
