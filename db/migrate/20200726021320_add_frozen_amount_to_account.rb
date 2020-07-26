class AddFrozenAmountToAccount < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :frozen_amount, :decimal, default: 0, comment: '冻结金额'
  end
end
