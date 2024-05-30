class CreateJoinTableCartItems < ActiveRecord::Migration[7.1]
  def change
    create_join_table :carts, :items
  end
end
