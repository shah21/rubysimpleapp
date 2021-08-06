class AddFinalDateToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :final_date, :date
  end
end
