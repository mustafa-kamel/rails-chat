class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.references :chat, foreign_key: true
      t.integer :number
      t.string :body
      t.integer :lock_version

      t.timestamps
    end
    change_column :messages, :lock_version, :integer, default: 0
    add_index :messages, %i[number chat_id], unique: true
  end
end
