json.key_format! camelize: :lower

json.extract! book, :id, :name, :describe, :author, :status, :category, :issue_at, :purchase_at
json.rented book.rented?
