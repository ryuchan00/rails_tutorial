class CreateMicroposts < ActiveRecord::Migration[5.1]
  def change
    create_table :microposts do |t|
      t.text :content
      t.references :user, foreign_key: true
      t.integer :in_reply_to

      t.timestamps
    end
    add_index :microposts, [:user_id, :created_at, :in_reply_to]
    add_foreign_key :microposts, :users, column: :in_reply_to
  end
end
