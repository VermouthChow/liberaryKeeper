class CreateTransitionRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :transition_records do |t|
      t.decimal :amount, comment: '金额'
      t.integer :type, comment: '转账类型'
      t.string :note, comment: '备注'
      t.datetime :transition_time, comment: '发生时间'
      t.datetime :deleted_at

      t.belongs_to :user, index: true
      t.belongs_to :book, index: true

      t.timestamps
    end

    add_index :transition_records, :deleted_at
    add_index :transition_records, :type
    add_index :transition_records, :transition_time
  end
end
