class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, comment: '用户名'                
      t.string :sn, comment: '用户编号'                
      t.integer :status, comment: '状态'    
      t.datetime :deleted_at

      t.belongs_to :role, index: true

      t.timestamps
    end

    add_index :users, :status
    add_index :users, :deleted_at
  end
end
