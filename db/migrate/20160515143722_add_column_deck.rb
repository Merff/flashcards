class AddColumnDeck < ActiveRecord::Migration
  def change
    add_column :cards, :deck, :string
  end
end
