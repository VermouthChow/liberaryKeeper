class AddDefaultValueToUserAndAccount < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:users, :status, 0)
    change_column_default(:accounts, :status, 0)
  end
end
