class SuperMemo < ActiveRecord::Migration
  def change
    change_table :cards do |t|
      t.remove :true_answers, :try
      t.integer :repeat,   default: 0
      t.float   :efactor,  default: 2.5
      t.integer :interval, default: 0
    end
  end
end
