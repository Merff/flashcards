class ChangeDefaultRepeat < ActiveRecord::Migration
  def change
    change_column_default(:cards, :repeat, 0)
  end
end
