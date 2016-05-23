class ChangeDefaultRepeat < ActiveRecord::Migration
  def change
    change_column_default :cards, :repeat, from: 0, to: 1
  end
end
