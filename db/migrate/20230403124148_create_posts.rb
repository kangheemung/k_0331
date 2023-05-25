class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :content
      t.integer :user_id
      t.datetime :created_at
      t.datetime :update_at
      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end
    add_index :posts, [:user_id, :created_at]
  end
end
