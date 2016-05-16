class AddCurrentDeckToUser < ActiveRecord::Migration
  def change
    add_column :users, :deck_id, :integer
  end
end
