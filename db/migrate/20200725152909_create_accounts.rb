class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.decimal :amount, comment: '账户金额'         
      t.integer :status, comment: '状态'
      t.datetime :deleted_at

      t.belongs_to :user, index: true  

      t.timestamps
    end

    add_index :accounts, :status
    add_index :accounts, :deleted_at
  end
end
