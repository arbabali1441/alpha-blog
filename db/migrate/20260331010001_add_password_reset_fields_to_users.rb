class AddPasswordResetFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reset_digest, :string
    add_column :users, :reset_sent_at, :datetime
    add_index :users, :reset_digest
  end
end
