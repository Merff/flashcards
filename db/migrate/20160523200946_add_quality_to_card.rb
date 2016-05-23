class AddQualityToCard < ActiveRecord::Migration
  def change
    add_column :cards, :quality, :integer
  end
end
