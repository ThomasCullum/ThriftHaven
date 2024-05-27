class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :category 
      t.text :description
      t.integer :rating
      t.references :user_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
