class CreateCheckOutRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :check_out_records do |t|

      t.integer :status, default: 0, comment: '状态'
      t.datetime :lend_at, comment: '借出时间'
      t.datetime :return_at, comment: '归还时间'
      t.datetime :deleted_at

      t.belongs_to :user, index: true
      t.belongs_to :book, index: true

      t.timestamps
    end

    add_index :check_out_records, :deleted_at
    add_index :check_out_records, :status
    add_index :check_out_records, :lend_at
    add_index :check_out_records, :return_at
  end
end
