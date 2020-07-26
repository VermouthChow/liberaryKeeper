class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :name, comment: '书名'
      t.text :describe, comment: '简介'
      t.string :author, comment: '作者'
      t.string :isbn, comment: '图书版号'
      t.integer :status, comment: '状态', default: 0
      t.integer :category, comment: '分类'
      t.datetime :issue_at, comment: '发行时间'
      t.datetime :purchase_at, comment: '购入时间'
      t.datetime :deleted_at

      t.belongs_to :user, index: true
      t.belongs_to :group, index: true
      t.belongs_to :series_book, index: true

      t.timestamps
    end

    add_index :books, :deleted_at
    add_index :books, :name
    add_index :books, :isbn
    add_index :books, :status
  end
end
