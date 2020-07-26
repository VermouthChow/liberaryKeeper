class AddRentToBook < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :rent, :decimal, default: 0, comment: '租金'
  end
end
