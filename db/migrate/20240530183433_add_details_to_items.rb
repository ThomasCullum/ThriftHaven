class AddDetailsToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :sold, :boolean
    add_column :items, :bought, :boolean
    add_column :items, :views, :integer
  end
end
