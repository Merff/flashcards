class ChangeDefaultRepeat < ActiveRecord::Migration
  def change
    change_column_default :cards, :repeat, from: 1, to: 0
  end
end
