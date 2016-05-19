class AddTrueAnswersAndTryToCards < ActiveRecord::Migration
  def change
    add_column :cards, :true_answers, :integer, default: 0
    add_column :cards, :try,          :integer, default: 0
  end
end
