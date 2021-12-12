class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.references :application, foreign_key: true
      t.integer :number
      t.integer :messages_count
      t.integer :lock_version

      t.timestamps
    end
    change_column :chats, :messages_count, :integer, default: 0
    change_column :chats, :lock_version, :integer, default: 0
    add_index :chats, %i[number application_id], unique: true
  end
end
