class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|

      t.text :comment, null: false
      t.integer :customer_id
      t.integer :recipe_id
      t.integer :star

      t.timestamps
    end
  end
end
